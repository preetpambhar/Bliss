//
//  ProductDetailsView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-11.
//
import SwiftUI

struct ProductDetailsView: View {
    @State private var addOnQuantities: [UUID: Int] = [:] // Store quantity for each add-on
    @EnvironmentObject var cartManager: CartManager
    @State private var totalPrice: Double
    @StateObject private var savedManager = SavedBouquetsManager()
    @State private var isSaved = false
    let bouquet: Bouquet
    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    @State private var showingCustomizeSheet = false
    
    init(bouquet: Bouquet) {
        self.bouquet = bouquet
        self._totalPrice = State(initialValue: bouquet.price) // Initialize total price with bouquet price
    }
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    VStack(spacing: 16) {
                        AsyncImage(url: URL(string: bouquet.primaryImage)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(height: 300)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 300)
                            case .failure:
                                SwiftUI.Image(systemName: "photo")
                                    .frame(height: 300)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        
                        Text(bouquet.name)
                            .font(.headline)
                        
                        if let description = bouquet.description {
                            Text(description)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                        
                        Button {
                            showingCustomizeSheet = true
                        } label: {
                            HStack {
                                SwiftUI.Image(systemName: "wand.and.stars")
                                Text("Customize This Bouquet")
                                Spacer()
                                SwiftUI.Image(systemName: "chevron.right")
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(10)
                            .shadow(radius: 1)
                        }
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                        
                        // Rating section
                        HStack {
                            HStack {
                                SwiftUI.Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text("4.5 Rating") // Placeholder rating
                            }
                            .font(.callout)
                            
                            Spacer()
                            
                            circalImage
                            Text("4.6K Reviews")
                            
                            Spacer()
                            
                            circalImage
                            Text("4K Sold")
                        }
                        .foregroundColor(.secondary)
                        .font(.callout)
                        
                        Spacer()
                        
                        // New Section: Add-On Options with quantity controls
                        //                        if let addOnOptions = product.addOnOptions, !addOnOptions.isEmpty {
                        //                            Text("Add-On Options")
                        //                                .font(.headline)
                        //                                .padding(.bottom)
                        //
                        //                            LazyVGrid(columns: gridItems, spacing: 20) {
                        //                                ForEach(addOnOptions, id: \.self) { addOn in
                        //                                    VStack(alignment: .center) {
                        //
                        //                                        Image("flower5")
                        //                                            .resizable()
                        //                                            .scaledToFit()
                        //                                            .frame(width: 100, height: 75)
                        //                                        HStack {
                        //                                            Image(systemName: "plus.circle")
                        //                                                .foregroundColor(.green)
                        //                                                .onTapGesture {
                        //                                                    increaseAddOnQuantity(addOn)
                        //                                                }
                        //
                        //                                            Spacer()
                        //
                        //                                            Text("\(addOnQuantities[addOn] ?? 0)")
                        //                                                .font(.headline)
                        //
                        //                                            Spacer()
                        //
                        //                                            Image(systemName: "minus.circle")
                        //                                                .foregroundColor(.red)
                        //                                                .onTapGesture {
                        //                                                    decreaseAddOnQuantity(addOn)
                        //                                                }
                        //
                        //                                        }
                        //                                        .padding(.bottom, 5)
                        //
                        //                                        Text(addOn)
                        //                                            .font(.subheadline)
                        //                                            .foregroundColor(.primary)
                        //                                            .lineLimit(1)
                        //                                            .truncationMode(.tail)
                        //                                            .frame(maxWidth: .infinity, alignment: .leading)
                        //                                    }
                        //                                    .padding()
                        //                                    .background(RoundedRectangle(cornerRadius: 10)
                        //                                        .fill(Color.white)
                        //                                        .shadow(radius: 2))
                        //                                }
                        //                            }
                        //                        }
                        //         if let addOnOptions = product.addOnOptions, !addOnOptions.isEmpty {
                        //                                  Text("Add-On Options")
                        //                                      .font(.headline)
                        //                                      .padding(.bottom)
                        
                        //                                  LazyVGrid(columns: gridItems, spacing: 20) {
                        //                                      ForEach(addOnOptions) { addOn in
                        //                                          VStack(alignment: .center) {
                        //                                              AsyncImage(url: URL(string: addOn.imageURL)) { image in
                        //                                                  image
                        //                                                      .resizable()
                        //                                                      .scaledToFit()
                        //                                                      .frame(width: 100, height: 75) // Adjust size
                        //                                              } placeholder: {
                        //                                                  //ProgressView() // Placeholder while loading
                        //                                                  Image("flower1")
                        //                                                   .resizable()
                        //                                                   .scaledToFit()
                        //                                                   .frame(width: 100, height: 75)
                        //                                              }
                        
                        //                                              HStack {
                        //                                                  Image(systemName: "plus.circle")
                        //                                                      .foregroundColor(.green)
                        //                                                      .onTapGesture {
                        //                                                          increaseAddOnQuantity(addOn.id)
                        //                                                      }
                        
                        //                                                  Spacer()
                        
                        //                                                  Text("\(addOnQuantities[addOn.id] ?? 0)")
                        //                                                      .font(.headline)
                        
                        //                                                  Spacer()
                        
                        //                                                  Image(systemName: "minus.circle")
                        //                                                      .foregroundColor(.red)
                        //                                                      .onTapGesture {
                        //                                                          decreaseAddOnQuantity(addOn.id)
                        //                                                      }
                        //                                              }
                        //                                              .padding(.bottom, 5)
                        
                        //                                              Text(addOn.name) // Display the flower name
                        //                                                  .font(.subheadline)
                        //                                                  .foregroundColor(.primary)
                        //                                                  .lineLimit(1)
                        //                                                  .truncationMode(.tail)
                        //                                                  .frame(maxWidth: .infinity, alignment: .center)
                        
                        //                                              Text("$\(addOn.price, specifier: "%.2f")") // Display the price
                        //                                                  .font(.footnote)
                        //                                                  .foregroundColor(.secondary)
                        //                                          }
                        //                                          .padding()
                        //                                          .background(RoundedRectangle(cornerRadius: 10)
                        //                                              .fill(Color.white)
                        //                                              .shadow(radius: 2))
                        //                                      }
                        //                                  }
                        //                              }
                    }
                    .padding()
                }
                
                // Fixed Bottom Price Section
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Total Price")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text(totalPrice.currencyFormat())
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.indigo)
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    HStack(spacing: 12) {
                        // Customize button
                        Button {
                            showingCustomizeSheet = true
                        } label: {
                            SwiftUI.Image(systemName: "wand.and.stars")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .padding(10)
                                .background(Color.white)
                                .clipShape(Circle())
                                .foregroundColor(.indigo)
                        }
                        
                        // Existing Add to Cart button
                        Button {
                            addToCart()
                        } label: {
                            HStack {
                                SwiftUI.Image(systemName: "cart.fill.badge.plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                
                                Text("Add To Cart")
                                    .font(.headline)
                                    .fontWeight(.bold)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .foregroundColor(.white)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: .indigo, location: 0.0),
                                        .init(color: .indigo, location: 0.3),
                                        .init(color: Color(UIColor.darkGray), location: 0.3),
                                        .init(color: Color(UIColor.darkGray), location: 1.0)
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    )
                    .padding(.trailing)
                }
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
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
        .sheet(isPresented: $showingCustomizeSheet) {
            CustomBouquetView(existingBouquet: bouquet)
        }
    }
    
    // Increase the quantity for a specific add-on
    private func increaseAddOnQuantity(_ addOn: UUID) {
        addOnQuantities[addOn, default: 0] += 1
        // @TODO - uncomment once we implement that logic
        //        updateTotalPrice(for: addOn, increase: true)
    }
    
    // Decrease the quantity for a specific add-on
    private func decreaseAddOnQuantity(_ addOn: UUID) {
        if let currentQuantity = addOnQuantities[addOn], currentQuantity > 0 {
            addOnQuantities[addOn] = currentQuantity - 1
            // @TODO - uncomment once we implement that logic
            //            updateTotalPrice(for: addOn, increase: false)
        }
    }
    
    // @TODO - uncomment once we implement custom logic
    //    private func updateTotalPrice(for addOn: UUID, increase: Bool) {
    //           if let addOnOption = product.addOnOptions?.first(where: { $0.id == addOn }) {
    //               let priceChange = addOnOption.price
    //               totalPrice += increase ? priceChange : -priceChange
    //           }
    //     }
    
    private func addToCart() {
        Task {
            await cartManager.addToCart(bouquet: bouquet)
        }
    }

    var circalImage: some View {
        SwiftUI.Image(systemName: "circle.fill")
            .resizable()
            .frame(width: 8, height: 8)
    }
}

#Preview {
    ProductDetailsView(bouquet: Bouquet(
        id: "1",
        name: "Sample Bouquet",
        description: "A beautiful bouquet",
        images: [BouquetImage(
            id: UUID().uuidString,
            imageUrl: "",
            isPrimary: true,
            createdAt: Date().ISO8601Format()
        )],
        price: 29.99,
        status: "active",
        isCustom: false,
        createdAt: Date().ISO8601Format()
    ))
    .environmentObject(CartManager())
}
