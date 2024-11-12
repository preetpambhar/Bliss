//
//  OrderDetailsView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-11-12.
//

import SwiftUI

struct OrderDetailsView: View {
    let order : Order
    var body: some View {
        ZStack{  VStack {
            ScrollView {
                VStack(spacing: 16) {
                    AsyncImageView(imageURL: order.productImage)
                        .scaledToFit()
                        .frame(height: 300)
                        .cornerRadius(8)
                        .background(Color(.systemGray6))
                    
                    
                    Text(order.productname)
                        .font(.headline)
                    
                    Text(order.productname)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    
                    // Rating section
                    HStack {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("\(order.rating.rate.toString()) Rating")
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
                    
                    VStack(alignment: .leading, spacing: 5){
                        HStack{
                            Text("Delivery Date")
                                
                            Text(order.date)
                        }.font(.headline)
                        
                        Divider()
                        Text("Delivery Details")
                            .font(.title2)
                        VStack(alignment: .leading){
                            Text("Cotact Person")
                            Text("Delivery Address Delivery Address Delivery Address Delivery Address Delivery Address Delivery Address Delivery Address Delivery Address")
                        }.font(.callout)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                }
                .padding()
            }
            
            // Fixed Bottom Price Section
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Total Price")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text(order.price.currencyFormat())
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.indigo)
                }
                .padding(.leading)
                
                Spacer()
                
                HStack {
                    Button {
                        //cartManager.addToCart(product: product)
                    } label: {
                        Image(systemName: "xmark.bin.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color.red)
                            .frame(width: 30, height: 30)
                        
                        Text("Cancel Order")
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
                                    Gradient.Stop(color: .black.opacity(1), location: 0.0),
                                    Gradient.Stop(color: .black.opacity(0.9), location: 0.25),
                                    Gradient.Stop(color: Color(UIColor.black), location: 0.3),
                                    Gradient.Stop(color: Color(UIColor.black), location: 1.0)
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
     }

    
var circalImage: some View {
    Image(systemName: "circle.fill")
        .resizable()
        .frame(width: 8, height: 8)
 }


#Preview {
    OrderDetailsView(order: .dummyOrder)
}
