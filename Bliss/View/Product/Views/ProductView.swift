//
//  ProductView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-11.
//

import SwiftUI

struct ProductView: View {
    
    let viewmodel = ProductViewModel()
    @State private var selectedProduct: Product? = nil // State to hold the selected product
        @State private var navigate = false // State for manual navigation
    
    var body: some View {
        NavigationStack{
            List(viewmodel.product){ product in
                //code with navigation arrow
//                NavigationLink {
//                    //Destination, which can navigate
//                    ProductDetailsView(product: product)
//                } label: {
//                    //UI Tabel row
//                    ProductRowView(product: product)
//                }
                ProductRowView(product: product)
                                   .contentShape(Rectangle()) // Makes the entire row tappable
                                   .onTapGesture {
                                       selectedProduct = product
                                       navigate = true
                                   }
            }
            .listStyle(.plain)
            .navigationTitle("Products")
            .navigationDestination(isPresented: $navigate) {
                            if let selectedProduct = selectedProduct {
                                ProductDetailsView(product: selectedProduct) // Navigate to ProductDetailsView
                            }
                        }
        }
        .task{
            await viewmodel.fetchProducts()
          }
     }
}

#Preview {
    ProductView()
}
