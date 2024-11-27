//
//  AvailableFlowersSection.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-26.
//
import SwiftUI

struct AvailableFlowersSection: View {
    let flowers: [Flower]
    let selectedFlowers: [String: Int]
    let onTap: (Flower) -> Void
    
    var availableFlowers: [Flower] {
        // Filter out flowers that are already selected
        flowers.filter { flower in
            selectedFlowers[flower.id] == nil
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Available Flowers")
                .font(.headline)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                ForEach(availableFlowers) { flower in // Use filtered flowers
                    CustomFlowerCard(
                        flower: flower,
                        isSelected: false, // Always false since we're filtering
                        onTap: { onTap(flower) }
                    )
                }
            }
        }
        .padding(.horizontal)
    }
}
