//
//  ProductView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-11.
//

import SwiftUI

struct ProductView: View {
    
    let viewmodel = ProductViewModel()
    var body: some View {
        NavigationStack{
            List(viewmodel.product){ product in
                NavigationLink {
                    //Destination, which can navigate
                    ProductDetailsView(product: product)
                } label: {
                    
                    //UI Tabel row
                    ProductRowView(product: product)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Products")
        }
        .task{
            await viewmodel.fetchProducts()
        }
    }
}

#Preview {
    ProductView()
}
