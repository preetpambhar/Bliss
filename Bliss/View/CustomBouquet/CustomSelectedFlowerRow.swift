//
//  CustomSelectedFlowerRow.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-26.
//
import SwiftUI

struct CustomSelectedFlowerRow: View {
    let flower: Flower
    let quantity: Int
    let onIncrease: () -> Void
    let onDecrease: () -> Void
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: flower.imageUrl)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading) {
                Text(flower.name)
                    .font(.subheadline)
                Text(flower.price.currencyFormat())
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            HStack {
                Button(action: onDecrease) {
                    Image(systemName: "minus.circle.fill")
                }
                
                Text("\(quantity)")
                    .frame(width: 30)
                
                Button(action: onIncrease) {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
