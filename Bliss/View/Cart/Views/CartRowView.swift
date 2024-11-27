//
//  CartRowView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-22.
//

import SwiftUI
import Foundation

struct CartRowView: View {
    @EnvironmentObject var cartManager: CartManager
    let item: CartItem
    @State private var quantity: Int
    
    init(item: CartItem) {
        self.item = item
        self._quantity = State(initialValue: item.quantity)
    }
    
    var body: some View {
        HStack(spacing: 20) {
            // Image
            AsyncImageView(imageURL: item.imageUrl)
                .aspectRatio(contentMode: .fit)
                .frame(width: 60)
                .cornerRadius(10)
           
            // Item Details
            VStack(alignment: .leading, spacing: 10) {
                Text(item.itemName)
                    .bold()
                    .lineLimit(2)
                
                HStack {
                    Text("$\(item.itemPrice, specifier: "%.2f")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    // Quantity Stepper
                    HStack(spacing: 12) {
                        Button {
                            if quantity > 1 {
                                quantity -= 1
                                updateQuantity()
                            }
                        } label: {
                            Image(systemName: "minus.circle")
                                .foregroundColor(.blue)
                        }
                        
                        Text("\(quantity)")
                            .font(.subheadline.bold())
                        
                        Button {
                            quantity += 1
                            updateQuantity()
                        } label: {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            
            Spacer()
            
            // Delete Button
            Button {
                Task {
                    await cartManager.removeFromCart(item: item)
                }
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func updateQuantity() {
        Task {
            await cartManager.updateQuantity(for: item, quantity: quantity)
        }
    }
}

// Preview
#Preview {
    CartRowView(item: CartItem(
        id: "123",
        cartId: "444",
        bouquetId: "88",
        flowerId: nil,
        quantity: 1,
        createdAt: Date.now.description,
        bouquet: Bouquet(
            id: "123",
            name: "Sample Bouquet",
            description: "A beautiful bouquet",
            imageUrl: "https://example.com/image.jpg",
            price: 29.99,
            status: Date().ISO8601Format(),
            isCustom: false,
            createdAt: "Pending"
        )
    ))
    .environmentObject(CartManager())
    .padding()
}
