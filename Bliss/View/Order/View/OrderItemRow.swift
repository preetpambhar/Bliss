//
//  OrderItemRow.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-16.
//
import SwiftUI

struct OrderItemRow: View {
    let item: OrderItem
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: item.bouquet?.imageUrl ?? item.flower?.imageUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 60, height: 60)
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.bouquet?.name ?? item.flower?.name ?? "Unknown Item")
                    .font(.headline)
                
                Text("Qty: \(item.quantity) × \(item.unitPrice.currencyFormat())")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(item.totalPrice.currencyFormat())
                .font(.headline)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}
