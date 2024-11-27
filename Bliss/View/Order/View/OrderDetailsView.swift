//
//  OrderDetailsView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-11-12.
//

import SwiftUI

struct OrderDetailsView: View {
    let order: Order
    @StateObject private var orderManager = OrderManager()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Order Summary
                VStack(alignment: .leading, spacing: 8) {
                    Text("Order Summary")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack {
                        Text("Order ID:")
                        Text(order.id)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Status:")
                        Text(order.status.capitalized)
                            .foregroundColor(statusColor)
                    }
                    
                    HStack {
                        Text("Date:")
                        Text(order.createdAt)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 2)
                
                // Order Items
                if let items = orderManager.orderItems[order.id] {
                    ForEach(items) { item in
                        OrderItemRow(item: item)
                    }
                }
                
                // Order Totals
                VStack(alignment: .leading, spacing: 8) {
                    Text("Order Total")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    HStack {
                        Text("Subtotal:")
                        Spacer()
                        Text(order.subtotal.currencyFormat())
                    }
                    
                    HStack {
                        Text("Tax:")
                        Spacer()
                        Text(order.tax.currencyFormat())
                    }
                    
                    HStack {
                        Text("Shipping:")
                        Spacer()
                        Text(order.shippingFee.currencyFormat())
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Total:")
                            .fontWeight(.bold)
                        Spacer()
                        Text(order.totalPrice.currencyFormat())
                            .fontWeight(.bold)
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 2)
            }
            .padding()
        }
        .navigationTitle("Order Details")
        .task {
            await orderManager.loadOrderItems(for: order.id)
        }
    }
    
    var statusColor: Color {
        switch order.status.lowercased() {
        case "pending": return .orange
        case "processing": return .blue
        case "shipped": return .purple
        case "delivered": return .green
        case "cancelled": return .red
        default: return .gray
        }
    }
}
