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
    @EnvironmentObject var cartManager: CartManager
   // var product: Product
    var body: some View {
//        NavigationStack {
//            VStack {
//                ScrollView{
//                    //cart.isEmpty ? emptyView() : cartView()
//                    if cart.price == 0 {
//                        emptyView()
//                    } else  {
//                        cartView()
////                        productRow()
////                            .padding(.horizontal)
////                            .frame(maxWidth: .infinity, alignment: .leading)
//                           // .padding(.bottom, 80)
//                        Spacer()
//                        HStack (alignment: .bottom){
//                            Button(action: {
//                                
//                            }) {
//                                Text("Continue Payment")
//                                    .fontWeight(.bold)
//                                    .frame(width: UIScreen.main.bounds.width - 50)
//                                    .padding()
//                                    .background(Color.blue)
//                                    .foregroundColor(.white)
//                                    .cornerRadius(10)
//                            }
//                        }
//                    }
//                }
//                .navigationTitle("Cart")
//            }
//        }
        
        ScrollView{
            if cartManager.paymentSuccess{
                Text("Thanks for your purchase! You will get super cool car toy soon! You'll also recive an email confirmation shortly.")
                    .padding()
            }else{
                if cartManager.products.count > 0{
                    ForEach(cartManager.products, id: \.id){product in
                        CartRowView(product: product)
                    }
                    
                    HStack{
                        Text("You cart total is")
                        Spacer()
                        Text("$\(cartManager.total).00")
                            .bold()
                    }
                    .padding()
                    PaymentButton(action: cartManager.pay)
                        .padding()
                    
                }else{
                    Text("Your cart is empty")
                }
            }
        }
        .navigationTitle("My Cart")
        .padding(.top)
        .onDisappear{
            if cartManager.paymentSuccess{
                cartManager.paymentSuccess = false
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

//    @ViewBuilder
//    func productRow()-> some View{
//        @EnvironmentObject var cartManager: CartManager
//        var product: Product
//        
//            HStack(spacing: 20){
//                Image(product.image)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 50)
//                    .cornerRadius(10)
//                
//                VStack(alignment: .leading, spacing:10){
//                    Text(product.title)
//                        .bold()
//                    Text("\(product.price)$")
//                        .font(.caption)
//                }
//                Spacer()
//                
//                Image(systemName: "trash")
//                    .foregroundColor(.red)
//                    .onTapGesture {
//                        cartManager.removeFromCart(product: product)
//                    }
//            }
//            .padding(.horizontal)
//            .frame(maxWidth: .infinity, alignment: .leading)
//      }
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
        .environmentObject(CartManager())
}
