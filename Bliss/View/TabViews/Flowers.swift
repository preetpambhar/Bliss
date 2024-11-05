//
//  flowers.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-09-27.
//

import SwiftUI

struct Flowers: View {
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    @EnvironmentObject var viewModel : LocationSearchViewModel
    @State var selectedLocationTitle: String
    @State private var showAddAddress = false
    let viewmodel = ProductViewModel()
    @State private var selectedProduct: Product? = nil // State to hold the selected product
    @State private var navigate = false // State for manual navigation
    
    @State private var selectedCategory: String? = nil
    @State private var showProductView = false
    let categories = ["Roses", "Tulips", "Orchids", "Lilies", "Sunflowers"]
    
    var body: some View {
        NavigationStack{
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading, spacing: 20) {
                    if !selectedLocationTitle.isEmpty{
                        Text("Delivery Address: " + selectedLocationTitle)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }else {
                        NavigationLink(destination: AddAddress(showBackButton: true, requestedpage: "product"), isActive: $showAddAddress) {
                                                   Text("Please Select Your Address")
                                                       .font(.title)
                                                       .fontWeight(.bold)
                                                       .foregroundColor(.gray)
                                                       .onTapGesture {
                                                           showAddAddress = true // Set state to true to navigate
                                                       }
                                               }
                    }
                    //Text("Your Picked Address")
                    //ProductView()
                    
                    // Category sections
                    ForEach(categories, id: \.self) { category in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(category)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Spacer()
                                Button("View More") {
                                    selectedCategory = category
                                    showProductView = true
                                }
                                .font(.subheadline)
                                .foregroundColor(.blue)
                            }
                            
//                            ScrollView(.horizontal, showsIndicators: false) {
//                                HStack(spacing: 15) {
//                                    ForEach(viewmodel.product) { product in                                        ProductRowView(product: product)
//                                            .frame(width: 150)
//                                            .onTapGesture {
//                                                selectedProduct = product
//                                                navigate = true
//                                            }
//                                    }
//                                }
//                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                                           HStack(spacing: 15) {
                                                               ForEach(0..<4) { _ in
                                                                   VStack(alignment: .leading) {
                                                                       Image("flower1") // Replace with actual product images
                                                                           .resizable()
                                                                           .aspectRatio(contentMode: .fill)
                                                                           .frame(width: 142, height: 110)
                                                                           .cornerRadius(15)
                                                                           .clipped()
                                                                       
                                                                       Text("Flowers Flowers")
                                                                           .font(.headline)
                                                                       
                                                                       Text("$22")
                                                                           .font(.body)
                                                                   }
                                                                   .frame(width: 142) // Fix the width of each product card
                                                                   .onTapGesture {
                                                                       // Handle product selection here
                                                                       // selectedProduct = product // Uncomment when you have product data
                                                                       // navigate = true // Uncomment when you want to navigate
                                                                   }
                                                               }
                                                           }
                                                       }
                        }
                        .padding(.vertical)
                    }
                    
                    
                }
                .onAppear {
                    if let location = locationViewModel.selectedUserLocation {
                        selectedLocationTitle = location.title
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Flowers")
        .navigationBarTitleDisplayMode(.large)
        .navigationDestination(isPresented: $navigate) {
                        if let selectedProduct = selectedProduct {
                            ProductDetailsView(product: selectedProduct) // Navigate to ProductDetailsView
                        }
                    }
    }
}

#Preview {
    Flowers(selectedLocationTitle: "")
       // .environmentObject(LocationSearchViewModel())
}
