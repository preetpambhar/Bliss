//
//  ProductRowView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-11.
//
import SwiftUI

struct ProductRowView: View {
    
    let product: Product
    
    var body: some View {
        HStack(spacing: 12) {
            productImage
                .frame(width: 120, height: 120)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4) // Add a subtle shadow
            
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                Text(product.category)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 4) {
                    ForEach(1...5, id: \.self) { index in
                        Image(systemName: index <= Int(product.rating.rate) ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                    }
                    Text(String(format: "%.1f", product.rating.rate))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text(product.price.currencyFormat())
                        .font(.title3)
                        .foregroundColor(.indigo)
                    
                    Spacer()
                    
                    buyButton
                }
                .padding(.top, 4)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2) // Add a lighter shadow to the entire row
    }
    
    var productImage: some View {
        Group {
            if let url = URL(string: product.image) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(15)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(15)
                    .foregroundColor(.gray)
            }
        }
    }
    
    var buyButton: some View {
        Button(action: {
            // Add action for buy button
        }) {
            Text("Add")
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.indigo)
                .clipShape(Capsule())
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2) // Add a shadow to the button
        }
    }
}

struct ProductRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProductRowView(product: Product.dummy)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
