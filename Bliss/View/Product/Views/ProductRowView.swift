//
//  ProductRowView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-11.
//

import SwiftUI

struct ProductRowView: View {
    
    let product: Product
    var body: some View {
        HStack (spacing: 8){
            if let url = URL(string: product.image){
              productImage(url: url)
            }
            
            VStack(alignment: .leading, spacing: 8)
            {
                //Title
                Text(product.title)
                    .font(.headline)
                    .lineLimit(2)
                HStack{
                    //Category
                    Text(product.category)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    HStack{
                        Image(systemName: "star.fill")
                        Text(product.rating.rate.toString())
                    }
                    .fontWeight(.medium)
                    .foregroundStyle(.yellow)
                }
                //Description
                Text(product.description)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
                
                //Price and Buyt button
                HStack{
                    Text(product.price.currencyFormat())
                        .font(.title3)
                        .foregroundStyle(.indigo)
                    Spacer()
                    buyButton
                }
            }
        }.padding()
    }
    
    func productImage(url: URL) -> some View{
        AsyncImage(url: url) { image in
            image.resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 100, height: 100)
    }
    var buyButton: some View{
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            Text("Buy")
              
              .foregroundColor(.white)
              .padding(.horizontal)
              .padding(.vertical, 8)
              .background(.indigo)
              .clipShape(.capsule)
             
             
        })
    }
}

#Preview {
    ProductRowView(product: Product.dummy)
}
