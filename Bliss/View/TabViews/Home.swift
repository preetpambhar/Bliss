//
//  home.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-09-27.
//

import SwiftUI

struct Home: View {
    @State private var showLocationSearchView = false
    @State var selectedLocationTitle: String
    @State private var showAddAddress = false
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    @StateObject private var bouquetViewModel = BouquetViewModel(client: supabaseClient)
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading, spacing: 20) {
                    if !selectedLocationTitle.isEmpty{
                        Text("Delivery Address: " + selectedLocationTitle)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .lineLimit(1)
                    } else {
                        NavigationLink(destination: AddAddress(showBackButton: true, requestedpage: "home"), isActive: $showAddAddress) {
                            HStack{
                                Image(systemName: "plus")
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
                    
                    HStack {
                        CustomCrousel(content: [
                            Image("flower6")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(15),
                            Image("flower1")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(15),
                            Image("flower3")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(15)
                        ])
                        .frame(height: 200)
                    }
                    
                    if bouquetViewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding()
                    } else {
                        VStack(spacing: 10) {
                            CategoryView(image: "bouquet1", text: "Seasonal Bouquets", destination: ProductView())
                            
                            ForEach(bouquetViewModel.bouquets.filter { $0.status == "active" }, id: \.id) { bouquet in
                                CategoryView(
                                    image: bouquet.imageUrl,
                                    text: bouquet.name,
                                    destination: BouquetDetailView(bouquet: bouquet)
                                )
                            }
                            
                            CategoryView(image: "bouquet2", text: "Birthday Bouquets", destination: BirthdayBouquetsView())
                            CategoryView(image: "weddingflower1", text: "Romantic Bouquets", destination: RomanticBouquetsView())
                            CategoryView(image: "weddingflower4", text: "Sympathy and Funeral Bouquets", destination: SympathyBouquetsView())
                        }
                    }
                }
                .padding()
                .onAppear {
                    if let location = locationViewModel.selectedUserLocation {
                        selectedLocationTitle = location.title
                    }
                    bouquetViewModel.loadBouquets()
                }
            }
          .navigationTitle("Home")
          .toolbar{
              NavigationLink{
                  AIChatBotView()
              } label: {
                  VStack {
                      Image(systemName: "sparkles.tv")
                          .foregroundStyle(.gray)
                      Text("Bliss Bot")
                          .foregroundStyle(.gray)
                  }
              }
          }
          //.navigationBarBackButtonHidden(true)
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

#Preview {
    Home(selectedLocationTitle: "")
}
