//
//  BouquetDetailView.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-04.
//

import SwiftUI

struct BouquetDetailView: View {
    let bouquet: Bouquet
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: URL(string: bouquet.imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Image(systemName: "photo")
                            .imageScale(.large)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(bouquet.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    if let description = bouquet.description {
                        Text(description)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    
                    Text("$\(bouquet.price.formatted())")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
