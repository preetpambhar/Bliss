//
//  OrderRowView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-11-11.
//

import SwiftUI

struct OrderRowView: View {
    var order: Order
    @StateObject private var orderManager = OrderManager()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Order Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Order #\(order.id.prefix(8))")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text(formatDate(order.createdAt))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text(order.status.capitalized)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(statusColor.opacity(0.2))
                    .foregroundColor(statusColor)
                    .cornerRadius(8)
            }
            
            Divider()
            
            // Order Summary
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(itemCount) items")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(order.totalPrice.currencyFormat())
                        .font(.title3)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .task {
            await orderManager.loadOrderItems(for: order.id)
        }
    }
    
    private var itemCount: Int {
        orderManager.orderItems[order.id]?.count ?? 0
    }
    
    private var statusColor: Color {
        switch order.status.lowercased() {
        case "pending": return .orange
        case "processing": return .blue
        case "shipped": return .purple
        case "delivered": return .green
        case "cancelled": return .red
        default: return .gray
        }
    }
    
    private func formatDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let date = formatter.date(from: dateString) else {
            return dateString
        }
        
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    OrderRowView(order: Order(
        id: "123",
        userId: "456",
        status: "pending",
        subtotal: 99.99,
        tax: 13.00,
        shippingFee: 10.00,
        totalPrice: 122.99,
        createdAt: "2024-11-16T12:00:00.000Z"
    ))
}
