//
//  cartManager.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-22.
//
import Foundation

class CartManager: ObservableObject {
    @Published private(set) var cartItems: [CartItem] = []
    @Published private(set) var total: Double = 0
    @Published var isLoading = false
    @Published var error: Error?
    @Published var paymentSuccess = false
    
    private let supabase = supabaseClient
    private let paymentHandler = PaymentHandler()
    private var cartId: String?
    
    init() {
        Task {
            await loadCart()
        }
    }
    
    @MainActor
    private func loadCart() async {
        isLoading = true
        do {
            let cartId = try await getOrCreateCart()
            self.cartId = cartId
            
            let query = supabase
                .from("cart_items")
                .select("""
                    *, 
                    bouquet:bouquets(*), 
                    flower:flowers(*)
                    """)
                .eq("cart_id", value: cartId)
            
            let items: [CartItem] = try await query.execute().value
            self.cartItems = items
            calculateTotal()
        } catch {
            self.error = error
        }
        isLoading = false
    }
    
    @MainActor
    func addToCart(bouquet: Bouquet) async {
        do {
            let cartId = try await getOrCreateCart()
            print("Found cart ID: \(cartId)")
            
            struct CartItemInsert: Codable {
                let cart_id: String
                let bouquet_id: String
                let quantity: Int
            }
            
            let payload = CartItemInsert(
                cart_id: cartId,
                bouquet_id: bouquet.id,
                quantity: 1
            )
            
            try await supabase
                .from("cart_items")
                .insert(payload)
                .execute();
            
            await loadCart()
        } catch {
            self.error = error
            print("Debug - Error adding to cart: \(error)")
        }
    }
    
    @MainActor
    func removeFromCart(item: CartItem) async {
        do {
            let query = supabase
                .from("cart_items")
                .delete()
                .eq("id", value: item.id)
            
            try await query.execute()
            await loadCart()
        } catch {
            self.error = error
        }
    }
    
    @MainActor
    func updateQuantity(for item: CartItem, quantity: Int) async {
        do {
            struct QuantityUpdate: Codable {
                let quantity: Int
            }
            
            let query = try supabase
                .from("cart_items")
                .update(QuantityUpdate(quantity: quantity))
                .eq("id", value: item.id)
            
            try await query.execute()
            await loadCart()
        } catch {
            self.error = error
        }
    }
    
    private func calculateTotal() {
        total = cartItems.reduce(0) { sum, item in
            sum + (item.itemPrice * Double(item.quantity))
        }
    }
    
    private func getOrCreateCart() async throws -> String {
        if let existingCartId = cartId {
            return existingCartId
        }
        
        print("Fetching carts!")
        let carts: [CartModel] = try await supabase
            .from("carts")
            .select()
            .execute()
            .value
        
        print("Fetching carts, done.")
        if let existingCart = carts.first {
            return existingCart.id
        }
        
        // Create new cart
        guard let userId = try? await supabase.auth.session.user.id else {
            throw NSError(domain: "CartManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }
        
        struct CartInsert: Codable {
            let userId: String
            
            enum CodingKeys: String, CodingKey {
                case userId = "user_id"
            }
        }
        
        let newCart: CartModel = try await supabase
            .from("carts")
            .insert(CartInsert(userId: userId.uuidString))
            .select()
            .single()
            .execute()
            .value
        
        return newCart.id
    }
    
    func pay() {
        paymentHandler.startPayment(products: [], total: total) { [weak self] success in
            guard let self = self else { return }
            self.paymentSuccess = success
            if success {
                Task {
//                    await self.convertCartToOrder()
                }
            }
        }
    }
    
//    private func convertCartToOrder() async {
//        guard let cartId = cartId else { return }
//        
//        do {
//            struct OrderInsert: Codable {
//                let totalPrice: Double
//                let status: String
//                let userId: String
//                
//                enum CodingKeys: String, CodingKey {
//                    case totalPrice = "total_price"
//                    case status
//                    case userId = "user_id"
//                }
//            }
//            
//            guard let userId = await supabase.auth.session.user.id else {
//                throw NSError(domain: "CartManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
//            }
//            
//            let orderQuery = try supabase
//                .from("orders")
//                .insert(OrderInsert(
//                    totalPrice: total,
//                    status: "pending",
//                    userId: userId.uuidString
//                ))
//            
//            let newOrder: Order = try await orderQuery.execute().value[0]
//            
//            // Copy cart items to order items
//            struct OrderItemInsert: Codable {
//                let orderId: String
//                let bouquetId: String?
//                let flowerId: String?
//                let quantity: Int
//                let price: Double
//                
//                enum CodingKeys: String, CodingKey {
//                    case orderId = "order_id"
//                    case bouquetId = "bouquet_id"
//                    case flowerId = "flower_id"
//                    case quantity, price
//                }
//            }
//            
//            for item in cartItems {
//                let orderItemQuery = try supabase
//                    .from("order_items")
//                    .insert(OrderItemInsert(
//                        orderId: newOrder.id.uuidString,
//                        bouquetId: item.bouquetId,
//                        flowerId: item.flowerId,
//                        quantity: item.quantity,
//                        price: item.itemPrice
//                    ))
//                
//                try await orderItemQuery.execute()
//            }
//            
//            // Clear cart items
//            let deleteQuery = supabase
//                .from("cart_items")
//                .delete()
//                .eq("cart_id", value: cartId)
//            
//            try await deleteQuery.execute()
//            
//            await loadCart()
//            
//        } catch {
//            self.error = error
//        }
//    }
}
