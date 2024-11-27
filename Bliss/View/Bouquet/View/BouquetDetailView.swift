//
//  BouquetDetailView.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-04.
//

import SwiftUI

struct BouquetDetailView: View {
    let bouquet: Bouquet
    @StateObject private var savedManager = SavedBouquetsManager()
    @State private var isSaved = false
    @State private var currentImageIndex = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Image Carousel
                TabView(selection: $currentImageIndex) {
                    ForEach(bouquet.images.indices, id: \.self) { index in
                        AsyncImage(url: URL(string: bouquet.images[index].imageUrl)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            case .failure:
                                SwiftUI.Image(systemName: "photo")
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .tag(index)
                    }
                }
                .frame(height: 300)
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(bouquet.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button {
                            Task {
                                if isSaved {
                                    await savedManager.removeSavedBouquet(bouquet)
                                } else {
                                    await savedManager.saveBouquet(bouquet)
                                }
                                isSaved.toggle()
                            }
                        } label: {
                            SwiftUI.Image(systemName: isSaved ? "heart.fill" : "heart")
                                .font(.title2)
                                .foregroundColor(isSaved ? .red : .gray)
                                .symbolEffect(.bounce, value: isSaved)
                        }
                    }
                    
                    if let description = bouquet.description {
                        Text(description)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    
                    Text(bouquet.price.currencyFormat())
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                .padding()
                
                // ... rest of the view ...
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Task {
                        if isSaved {
                            await savedManager.removeSavedBouquet(bouquet)
                        } else {
                            await savedManager.saveBouquet(bouquet)
                        }
                        isSaved.toggle()
                    }
                } label: {
                    SwiftUI.Image(systemName: isSaved ? "heart.fill" : "heart")
                        .font(.title2)
                        .foregroundColor(isSaved ? .red : .gray)
                        .symbolEffect(.bounce, value: isSaved)
                }
            }
        }
        .task {
            isSaved = await savedManager.isBouquetSaved(bouquet)
        }
    }
}
