//
//  cartManager.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-22.
//
import Foundation

@MainActor
class CartManager: ObservableObject {
    @Published private(set) var cartItems: [CartItem] = []
    @Published private(set) var total: Double = 0
    @Published var isLoading = false
    @Published var error: Error?
    @Published var paymentSuccess = false
    @Published var shouldNavigateToOrders = false
    
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
           bouquet:bouquets(
               id,
               name,
               description,
               bouquet_images(id, image_url, is_primary, created_at),
               price,
               status,
               is_custom,
               created_at
           ),
           flower:flowers(
               id,
               name,
               description,
               flower_images(id, image_url, is_primary, created_at),
               price,
               stock,
               status,
               created_at
           )
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
                    await self.convertCartToOrder()
                    await MainActor.run {
                        self.shouldNavigateToOrders = true
                        self.paymentSuccess = false
                    }
                }
            }
        }
    }
    
    @MainActor
    private func convertCartToOrder() async {
        guard let cartId = cartId else { return }
        
        do {
            struct OrderInsert: Codable {
                let user_id: String
                let status: String
                let subtotal: Double
                let tax: Double
                let shipping_fee: Double
                let total_price: Double
                
                enum CodingKeys: String, CodingKey {
                    case user_id
                    case status
                    case subtotal
                    case tax
                    case shipping_fee
                    case total_price
                }
            }
            
            guard let userId = try? await supabase.auth.session.user.id.uuidString else {
                throw NSError(domain: "CartManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
            }
            
            // Calculate order totals
            let subtotal = total
            let tax = subtotal * 0.13 // 13% tax
            let shippingFee = 10.0 // Fixed $10 shipping
            let totalPrice = subtotal + tax + shippingFee
            
            let orderPayload = OrderInsert(
                user_id: userId,
                status: "pending",
                subtotal: subtotal,
                tax: tax,
                shipping_fee: shippingFee,
                total_price: totalPrice
            )
            
            print("Debug - Creating order with payload:", orderPayload)
            
            let newOrder: Order = try await supabase
                .from("orders")
                .insert(orderPayload)
                .select()
                .single()
                .execute()
                .value
            
            print("Debug - Created order:", newOrder)
            
            // Copy cart items to order items
            struct OrderItemInsert: Codable {
                let order_id: String
                let bouquet_id: String?
                let flower_id: String?
                let quantity: Int
                let unit_price: Double
                let total_price: Double
            }
            
            // Insert order items
            for item in cartItems {
                let itemPrice = item.itemPrice
                let orderItemPayload = OrderItemInsert(
                    order_id: newOrder.id,
                    bouquet_id: item.bouquetId,
                    flower_id: item.flowerId,
                    quantity: item.quantity,
                    unit_price: itemPrice,
                    total_price: itemPrice * Double(item.quantity)
                )
                
                try await supabase
                    .from("order_items")
                    .insert(orderItemPayload)
                    .execute()
            }
            
            // Clear cart items
            try await supabase
                .from("cart_items")
                .delete()
                .eq("cart_id", value: cartId)
                .execute()
            
            await loadCart()
            
        } catch {
            self.error = error
            print("Debug - Error converting cart to order: \(error)")
        }
    }
}
