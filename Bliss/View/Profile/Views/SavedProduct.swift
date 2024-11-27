//
//  SavedProduct.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-11-06.
//

import SwiftUI

struct SavedProduct: View {
    @StateObject private var savedManager = SavedBouquetsManager()
    
    var body: some View {
        Group {
            if savedManager.isLoading {
                ProgressView()
            } else if savedManager.savedBouquets.isEmpty {
                EmptyStateView()
            } else {
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16)
                    ], spacing: 16) {
                        ForEach(savedManager.savedBouquets, id: \.id) { bouquet in
                            NavigationLink(destination: ProductDetailsView(bouquet: bouquet)) {
                                SavedBouquetCard(bouquet: bouquet, savedManager: savedManager)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Saved Bouquets")
        .alert("Error", isPresented: .constant(savedManager.error != nil)) {
            Button("OK") { savedManager.error = nil }
        } message: {
            Text(savedManager.error?.localizedDescription ?? "")
        }
        .task {
            await savedManager.loadSavedBouquets()
        }
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "heart.slash")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No Saved Bouquets")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Your saved bouquets will appear here")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

struct SavedBouquetCard: View {
    let bouquet: Bouquet
    let savedManager: SavedBouquetsManager
    @State private var showingUnsaveAlert = false
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: bouquet.imageUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .frame(height: 150)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .frame(height: 150)
                        .clipped()
                case .failure:
                    Image(systemName: "photo")
                        .frame(maxWidth: .infinity)
                        .frame(height: 150)
                @unknown default:
                    EmptyView()
                }
            }
            .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(bouquet.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(2)
                
                Text(bouquet.price.currencyFormat())
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            
            Button {
                showingUnsaveAlert = true
            } label: {
                Label("Remove", systemImage: "heart.fill")
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.horizontal, 8)
                    .padding(.bottom, 6)
            }
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .alert("Remove from Saved?", isPresented: $showingUnsaveAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Remove", role: .destructive) {
                Task {
                    await savedManager.removeSavedBouquet(bouquet)
                }
            }
        } message: {
            Text("Are you sure you want to remove this bouquet from your saved items?")
        }
    }
}

#Preview {
    SavedProduct()
}
