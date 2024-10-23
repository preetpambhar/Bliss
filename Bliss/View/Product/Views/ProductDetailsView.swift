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
    let product: Product
    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    init(product: Product) {
           self.product = product
           self._totalPrice = State(initialValue: product.price) // Initialize total price with product price
     }
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    VStack(spacing: 16) {
                        AsyncImageView(imageURL: product.image)
                            .scaledToFit()
                            .frame(height: 300)
                        
                        Text(product.title)
                            .font(.headline)
                        
                        Text(product.description)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        
                        // Rating section
                        HStack {
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text("\(product.rating.rate.toString()) Rating")
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
                        if let addOnOptions = product.addOnOptions, !addOnOptions.isEmpty {
                                                 Text("Add-On Options")
                                                     .font(.headline)
                                                     .padding(.bottom)
                                                 
                                                 LazyVGrid(columns: gridItems, spacing: 20) {
                                                     ForEach(addOnOptions) { addOn in
                                                         VStack(alignment: .center) {
                                                             AsyncImage(url: URL(string: addOn.imageURL)) { image in
                                                                 image
                                                                     .resizable()
                                                                     .scaledToFit()
                                                                     .frame(width: 100, height: 75) // Adjust size
                                                             } placeholder: {
                                                                 //ProgressView() // Placeholder while loading
                                                                 Image("flower1")
                                                                  .resizable()
                                                                  .scaledToFit()
                                                                  .frame(width: 100, height: 75)
                                                             }

                                                             HStack {
                                                                 Image(systemName: "plus.circle")
                                                                     .foregroundColor(.green)
                                                                     .onTapGesture {
                                                                         increaseAddOnQuantity(addOn.id)
                                                                     }
                                                                 
                                                                 Spacer()
                                                                 
                                                                 Text("\(addOnQuantities[addOn.id] ?? 0)")
                                                                     .font(.headline)
                                                                 
                                                                 Spacer()
                                                                 
                                                                 Image(systemName: "minus.circle")
                                                                     .foregroundColor(.red)
                                                                     .onTapGesture {
                                                                         decreaseAddOnQuantity(addOn.id)
                                                                     }
                                                             }
                                                             .padding(.bottom, 5)
                                                             
                                                             Text(addOn.name) // Display the flower name
                                                                 .font(.subheadline)
                                                                 .foregroundColor(.primary)
                                                                 .lineLimit(1)
                                                                 .truncationMode(.tail)
                                                                 .frame(maxWidth: .infinity, alignment: .center)
                                                             
                                                             Text("$\(addOn.price, specifier: "%.2f")") // Display the price
                                                                 .font(.footnote)
                                                                 .foregroundColor(.secondary)
                                                         }
                                                         .padding()
                                                         .background(RoundedRectangle(cornerRadius: 10)
                                                             .fill(Color.white)
                                                             .shadow(radius: 2))
                                                     }
                                                 }
                                             }
                                         
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
                
                        HStack {
                          Button {
                              cartManager.addToCart(product: product)
                       } label: {
                           Image(systemName: "cart.fill.badge.plus")
                               .resizable()
                               .scaledToFit()
                               .frame(width: 30, height: 30)
                           
                           Text("Add To Cart")
                               .font(.headline)
                               .fontWeight(.bold)
                               .frame(height: 100)
                            }
                        }
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .padding(.horizontal)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(stops: [
                                            Gradient.Stop(color: .indigo, location: 0.30),
                                            Gradient.Stop(color: .indigo, location: 0.1),
                                            Gradient.Stop(color: Color(UIColor.darkGray), location: 0.1),
                                            Gradient.Stop(color: Color(UIColor.darkGray), location: 0.5)
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
            .ignoresSafeArea(.keyboard, edges: .bottom) // In case of keyboard interaction
    }

    // Increase the quantity for a specific add-on
    private func increaseAddOnQuantity(_ addOn: UUID) {
        addOnQuantities[addOn, default: 0] += 1
        updateTotalPrice(for: addOn, increase: true)
    }

    // Decrease the quantity for a specific add-on
    private func decreaseAddOnQuantity(_ addOn: UUID) {
        if let currentQuantity = addOnQuantities[addOn], currentQuantity > 0 {
            addOnQuantities[addOn] = currentQuantity - 1
            updateTotalPrice(for: addOn, increase: false)
        }
    }
    
    private func updateTotalPrice(for addOn: UUID, increase: Bool) {
           if let addOnOption = product.addOnOptions?.first(where: { $0.id == addOn }) {
               let priceChange = addOnOption.price
               totalPrice += increase ? priceChange : -priceChange
           }
     }

    var circalImage: some View {
        Image(systemName: "circle.fill")
            .resizable()
            .frame(width: 8, height: 8)
    }
}

#Preview {
    ProductDetailsView(product: Product.dummy)
        .environmentObject(CartManager())
}
