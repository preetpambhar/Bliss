//
//  OrderManager.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-16.
//
import Foundation


@MainActor
class OrderManager: ObservableObject {
    @Published private(set) var orders: [Order] = []
    @Published private(set) var orderItems: [String: [OrderItem]] = [:]
    @Published var isLoading = false
    @Published var error: Error?
    
    private let supabase = supabaseClient
    
    func loadOrders() async {
        isLoading = true
        do {
            let query = supabase
                .from("orders")
                .select()
                .order("created_at", ascending: false)
            
            orders = try await query.execute().value
        } catch {
            self.error = error
        }
        isLoading = false
    }
    
    func loadOrderItems(for orderId: String) async {
        do {
            let query = supabase
                .from("order_items")
                .select("""
                    *,
                    bouquet:bouquets(*),
                    flower:flowers(*)
                    """)
                .eq("order_id", value: orderId)
            
            let items: [OrderItem] = try await query.execute().value
            orderItems[orderId] = items
        } catch {
            self.error = error
        }
    }
}
