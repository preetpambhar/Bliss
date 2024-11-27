//
//  flowers.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-09-27.
//

import SwiftUI

struct Flowers: View {
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    @State var selectedLocationTitle: String
    @State private var showAddAddress = false
    @State private var searchText = ""
    @State private var flowers: [Flower] = []
    @State private var isLoading = true
    
    var filteredFlowers: [Flower] {
        guard !searchText.isEmpty else { return flowers }
        return flowers.filter { flower in
            flower.name.localizedCaseInsensitiveContains(searchText) ||
            flower.description?.localizedCaseInsensitiveContains(searchText) ?? false
        }
    }
    
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    // Address Section
                    Group {
                        if !selectedLocationTitle.isEmpty {
                            Text("Delivery to: " + selectedLocationTitle)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        } else {
                            NavigationLink(destination: AddAddress(showBackButton: true, requestedpage: "product"), isActive: $showAddAddress) {
                                Text("Select delivery address")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                                    .onTapGesture {
                                        showAddAddress = true
                                    }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    if isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 200)
                    } else if filteredFlowers.isEmpty && !searchText.isEmpty {
                        NoResultsView(searchText: searchText)
                    } else {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(filteredFlowers, id: \.id) { flower in
                                NavigationLink(destination: FlowerDetailView(flower: flower)) {
                                    FlowerCard(flower: flower)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Flowers")
            .searchable(text: $searchText, prompt: "Search flowers...")
            .task {
                await loadFlowers()
            }
        }
    }
    
    func loadFlowers() async {
        do {
            let query = supabaseClient
                .from("flowers")
                .select()
            let response: [Flower] = try await query.execute().value
            flowers = response
            isLoading = false
        } catch {
            print("Error loading flowers: \(error)")
            isLoading = false
        }
    }
}

struct FlowerCard: View {
    let flower: Flower
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: flower.imageUrl)) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .fill(Color.gray.opacity(0.1))
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(ProgressView())
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                case .failure:
                    Rectangle()
                        .fill(Color.gray.opacity(0.1))
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(.gray)
                        )
                @unknown default:
                    EmptyView()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(flower.name)
                    .font(.system(.subheadline, weight: .medium))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Text("$\(String(format: "%.2f", flower.price))")
                    .font(.system(.subheadline, weight: .regular))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 4)
        }
        .background(Color(.systemBackground))
    }
}

struct FlowerDetailView: View {
    let flower: Flower
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: flower.imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 300)
                            .overlay(ProgressView())
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 300)
                            .clipped()
                    case .failure:
                        Rectangle()
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 300)
                            .overlay(
                                Image(systemName: "photo")
                                    .foregroundColor(.gray)
                            )
                    @unknown default:
                        EmptyView()
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(flower.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    if let description = flower.description {
                        Text(description)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("$\(String(format: "%.2f", flower.price))")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text("\(flower.stock) in stock")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Button(action: {
                        // Add to cart functionality
                    }) {
                        Text("Add to Cart")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .padding(.top, 8)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NoResultsView: View {
    let searchText: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 64))
                .foregroundColor(.gray)
                .padding(.bottom, 8)
            
            Text("No flowers found")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("We couldn't find any flowers matching\n\(searchText)")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, minHeight: 300)
        .padding()
    }
}

#Preview {
    Flowers(selectedLocationTitle: "")
       // .environmentObject(LocationSearchViewModel())
}
