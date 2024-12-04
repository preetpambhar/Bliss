//
//  ImageSearchView.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-27.
//
import SwiftUI
import PhotosUI

struct ImageSearchView: View {
    @StateObject private var viewModel = ImageSearchViewModel()
    @State private var showingImagePicker = false
    @State private var searchType: SearchType = .bouquets
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Search Type Picker
                Picker("Search Type", selection: $searchType) {
                    Text("Bouquets").tag(SearchType.bouquets)
                    Text("Flowers").tag(SearchType.flowers)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                // Image Upload Section
                VStack(spacing: 16) {
                    if let image = viewModel.selectedImage {
                        SwiftUI.Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                Button(action: { viewModel.selectedImage = nil }) {
                                    SwiftUI.Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.white)
                                        .padding(8)
                                }
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                                .padding(8),
                                alignment: .topTrailing
                            )
                    } else {
                        Button(action: { showingImagePicker = true }) {
                            VStack(spacing: 12) {
                                SwiftUI.Image(systemName: "photo.on.rectangle.angled")
                                    .font(.system(size: 40))
                                Text("Upload a photo to search")
                                    .font(.headline)
                                Text("Tap to browse your photos")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
                .padding(.horizontal)
                
                // Search Results
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if !viewModel.searchResults.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            ForEach(viewModel.searchResults) { result in
                                SearchResultCard(result: result)
                            }
                        }
                        .padding()
                    }
                } else if viewModel.hasSearched {
                    ImageSearchNoResultsView()
                }
                
                Spacer()
            }
            .navigationTitle("Visual Search")
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $viewModel.selectedImage)
            }
            .onChange(of: viewModel.selectedImage) { _ in
                if viewModel.selectedImage != nil {
                    Task {
                        await viewModel.performSearch(type: searchType)
                    }
                }
            }
            .alert("Error", isPresented: $viewModel.showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage)
            }
        }
    }
}

// Search Result Card
struct SearchResultCard: View {
    let result: SearchResult
    
    var body: some View {
        NavigationLink(destination: destinationView) {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: result.imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        SwiftUI.Image(systemName: "photo")
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(result.name)
                        .font(.headline)
                        .lineLimit(2)
                    
                    Text(result.price.currencyFormat())
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
            }
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }
    
    @ViewBuilder
    var destinationView: some View {
        if result.type == .bouquets {
            ProductDetailsView(bouquet: result.toBouquet())
        } else {
            FlowerDetailView(flower: result.toFlower())
        }
    }
}

// No Results View
struct ImageSearchNoResultsView: View {
    var body: some View {
        VStack(spacing: 16) {
            SwiftUI.Image(systemName: "magnifyingglass")
                .font(.system(size: 50))
                .foregroundColor(.gray)
            
            Text("No matches found")
                .font(.headline)
            
            Text("Try uploading a different image")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
