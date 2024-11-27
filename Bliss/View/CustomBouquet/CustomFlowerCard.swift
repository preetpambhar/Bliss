//
//  CustomFlowerCard.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-26.
//
import SwiftUI

struct CustomFlowerCard: View {
    let flower: Flower
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack {
                AsyncImage(url: URL(string: flower.primaryImage)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text(flower.name)
                    .font(.subheadline)
                    .lineLimit(1)
                
                Text(flower.price.currencyFormat())
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isSelected ? Color.blue.opacity(0.1) : Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isSelected ? Color.blue : Color.gray.opacity(0.3), lineWidth: 1)
                )
        )
    }
}
