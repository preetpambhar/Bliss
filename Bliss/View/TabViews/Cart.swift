//
//  cart.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-09-27.
//

import SwiftUI

struct Cart: View {
    var cart: [Int] = [34,43]
    var body: some View {
        ScrollView{
            //cart.isEmpty ? emptyView() : cartView()
            if cart.isEmpty {
                emptyView()
            } else  {
                cartView()
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
            ForEach(cart, id: \.self) { item in
                HStack() {
                    Image(systemName: "cart")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 10)
                    
                    VStack(alignment: .leading) {
                        Text("Product \(item)")
                            .font(.title)
                        Text("price: $54")
                            .font(.title2)
                }
                    Spacer()
            }
             .padding()
        }
    }
}


#Preview {
    Cart()
}
