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
    
    var body: some View {
        ZStack {
            VStack {
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
                            Image(systemName: isSaved ? "heart.fill" : "heart")
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
                    
                    Text("$\(bouquet.price.formatted())")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                }
                .padding()
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
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
                    Image(systemName: isSaved ? "heart.fill" : "heart")
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
