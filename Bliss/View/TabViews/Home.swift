//
//  home.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-09-27.
//

import SwiftUI

struct Home: View {
    @State private var searchText = ""
    @State private var showLocationSearchView = false
    @State var selectedLocationTitle: String
    @State private var showAddAddress = false
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    @StateObject private var bouquetViewModel = BouquetViewModel(client: supabaseClient)
    @State private var showCustomBouquetView = false
    
    var filteredBouquets: [Bouquet] {
        guard !searchText.isEmpty else { 
            return bouquetViewModel.bouquets.filter { !$0.isCustom }
        }
        return bouquetViewModel.bouquets.filter { bouquet in
            !bouquet.isCustom && (
                bouquet.name.localizedCaseInsensitiveContains(searchText) ||
                bouquet.description?.localizedCaseInsensitiveContains(searchText) ?? false
            )
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    if !selectedLocationTitle.isEmpty{
                        Text("Delivery Address: " + selectedLocationTitle)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .lineLimit(1)
                    }else { NavigationLink(destination: AddAddress(showBackButton: true, requestedpage: "home"), isActive: $showAddAddress) {
                        //   LocationSearchActivation()
                        HStack{
                            Image(systemName: "plus")
                            //.fill(Color.black)
                                .frame(width: 8, height: 8)
                                .foregroundColor(Color(.darkGray))
                                .padding(.horizontal)
                            Text("Add Delivery Location")
                                .foregroundColor(Color(.darkGray))
                                .onTapGesture {
                                    showAddAddress = true
                                }
                            Spacer()
                            
                        }
                        .frame(width: UIScreen.main.bounds.width - 20, height: 50)
                    }
                    }
                    // CustomCrousel(content: [
                    //     Image("flower6")
                    //         .resizable()
                    //         .aspectRatio(contentMode: .fill)
                    //         .cornerRadius(15) ,
                    //     Image("flower1")
                    //         .resizable()
                    //         .aspectRatio(contentMode: .fill)
                    //         .cornerRadius(15),
                    //     Image("flower3")
                    //         .resizable()
                    //         .aspectRatio(contentMode: .fill)
                    //         .cornerRadius(15)
                    // ])
                    // .frame(height: 200)
                    
                    LazyVStack(spacing: 16) {
                        ForEach(filteredBouquets, id: \.id) { bouquet in
                            NavigationLink(destination: ProductDetailsView(bouquet: bouquet)) {
                                BouquetCard(bouquet: bouquet)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .onAppear {
                    if let location = locationViewModel.selectedUserLocation {
                        selectedLocationTitle = location.title
                    }
                    bouquetViewModel.loadBouquets()
                }
            }
            .navigationTitle("Bliss")
            .searchable(text: $searchText, prompt: "Search bouquets...")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AIChatBotView()) {
                        Label("Bliss Assistant", systemImage: "wand.and.stars")
                            .symbolRenderingMode(.multicolor)
                    }
                }
            }
            .sheet(isPresented: $showCustomBouquetView) {
                CustomBouquetView(existingBouquet: nil)
            }
        }
    }
}

struct CategoryView<Destination: View>: View {
    var image: String
    var text: String
    var themeColor: Color = .blue
    var destination: Destination
    
    @State private var isImageLoaded = false
    @State private var isButtonPressed = false
    
    var body: some View {
        NavigationLink(destination: destination) {
            VStack(alignment: .center, spacing: 15) {
                if image.hasPrefix("http") {
                    AsyncImage(url: URL(string: image)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 300)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 300)
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                        case .failure:
                            Image(systemName: "photo")
                                .imageScale(.large)
                                .frame(height: 300)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 300)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                }
                
                Text(text)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .padding(.top, 8)
                    .background(Color(.systemBackground).opacity(0.9))
                
                Text("Explore \(text)")
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(themeColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .scaleEffect(isButtonPressed ? 0.95 : 1.0)
                    .shadow(color: themeColor.opacity(0.3), radius: 5, x: 0, y: 4)
                    .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isButtonPressed)
                    .padding(.horizontal, 20)
            }
            .padding(10)
            .background(Color(.systemBackground).opacity(0.95))
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 8)
        }
        .buttonStyle(.plain)
    }
}
// Placeholder Views for each category
struct SeasonalBouquetsView: View {
    var body: some View {
        Text("Seasonal Bouquets Page")
            .font(.largeTitle)
            .padding()
    }
}

struct BirthdayBouquetsView: View {
    var body: some View {
        Text("Birthday Bouquets Page")
            .font(.largeTitle)
            .padding()
    }
}

struct RomanticBouquetsView: View {
    var body: some View {
        Text("Romantic Bouquets Page")
            .font(.largeTitle)
            .padding()
    }
}

struct SympathyBouquetsView: View {
    var body: some View {
        Text("Sympathy and Funeral Bouquets Page")
            .font(.largeTitle)
            .padding()
    }
}

// New BouquetCard component
struct BouquetCard: View {
    let bouquet: Bouquet
    @StateObject private var savedManager = SavedBouquetsManager()
    @State private var isSaved = false
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: bouquet.imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .clipped()
                    case .failure:
                        Image(systemName: "photo")
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                    @unknown default:
                        EmptyView()
                    }
                }
                .cornerRadius(8)
                
                // Save Button
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
                        .font(.title3)
                        .foregroundColor(isSaved ? .red : .white)
                        .padding(8)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                        .symbolEffect(.bounce, value: isSaved)
                }
                .padding(8)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(bouquet.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(bouquet.price.currencyFormat())
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 4)
            .padding(.vertical, 8)
        }
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
        .task {
            isSaved = await savedManager.isBouquetSaved(bouquet)
        }
    }
}

#Preview {
    Home(selectedLocationTitle: "")
}
