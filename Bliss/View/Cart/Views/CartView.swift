//
//  CartView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-11.
//

import SwiftUI

struct CartView: View {
    var cart: CartModel = CartModel.dummy
    let cartItems: [CartModel] = [CartModel.dummy, CartModel.dummy1]
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView{
                    //cart.isEmpty ? emptyView() : cartView()
                    if cart.price == 0 {
                        emptyView()
                    } else  {
                        cartView()
                           // .padding(.bottom, 80)
                        Spacer()
                        HStack (alignment: .bottom){
                            Button(action: {
                                
                            }) {
                                Text("Continue Payment")
                                    .fontWeight(.bold)
                                    .frame(width: UIScreen.main.bounds.width - 50)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .navigationTitle("Cart")
            }
        }
    }
    
    
    @ViewBuilder
    func emptyView() -> some View{
        Text("Your Cart Is Empty")
            .font(.title)
            .padding()
            .foregroundColor(.gray)
    }

    
    @ViewBuilder
    func cartView() -> some View{
            ForEach(cartItems) { item in
                HStack() {
                    AsyncImageView(imageURL: item.image)
//                        .resizable()
                       .aspectRatio(contentMode: .fill)
                       .frame(width: 75, height: 75)
                        .cornerRadius(15)
                        .clipped()
                    
                    VStack(alignment: .leading) {
                        Text("Product \(item.title)")
                            .font(.title2)
                        Text("price: \(item.price.currencyFormat())")
                            .font(.title3)
                }
                    Spacer()
            }
             .padding()
        }
    }
}

#Preview {
    CartView()
}
