//
//  BouquetDetailsSection.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-26.
//
import SwiftUI

struct BouquetDetailsSection: View {
    @Binding var bouquetName: String
    @Binding var bouquetDescription: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Bouquet Details")
                .font(.headline)
            
            TextField("Bouquet Name", text: $bouquetName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Description (Optional)", text: $bouquetDescription)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding(.horizontal)
    }
}
