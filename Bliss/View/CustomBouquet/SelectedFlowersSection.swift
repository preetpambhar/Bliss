//
//  SelectedFlowersSection.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-26.
//
import SwiftUI

struct SelectedFlowersSection: View {
    let flowers: [Flower]
    let selectedFlowers: [String: Int]
    let onIncrease: (Flower) -> Void
    let onDecrease: (Flower) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Selected Flowers")
                .font(.headline)
            
            if flowers.isEmpty {
                Text("No flowers selected")
                    .foregroundColor(.secondary)
                    .padding(.vertical)
            } else {
                ForEach(flowers) { flower in
                    if selectedFlowers[flower.id] != nil {
                        CustomSelectedFlowerRow(
                            flower: flower,
                            quantity: selectedFlowers[flower.id, default: 0],
                            onIncrease: { onIncrease(flower) },
                            onDecrease: { onDecrease(flower) }
                        )
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}
