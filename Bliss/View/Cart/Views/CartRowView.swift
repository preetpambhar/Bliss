//
//  CartRowView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-22.
//

import SwiftUI
import Foundation

struct CartRowView: View {
    @EnvironmentObject var cartManager: CartManager
    var product: Product
    var body: some View {
        HStack(spacing: 20){
            //Image(product.image)
            AsyncImageView(imageURL: product.image)
                //.resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60)
                .cornerRadius(10)
           
            VStack(alignment: .leading, spacing:10){
                Text(product.title)
                    .bold()
                Text("\(product.price)$")
                    .font(.caption)
            }
            Spacer()
            
            Image(systemName: "trash")
                .foregroundColor(.red)
                .onTapGesture {
                    cartManager.removeFromCart(product: product)
                }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
//        .onAppear(){
//            print("Image URL: \(product.image)")
//            ForEach(cartManager.products, id: \.id) { product in
//                CartRowView(product: product)
//            }
//        }
    }
}


#Preview {
    CartRowView(product: Product.dummy)
        .environmentObject(CartManager())
}
