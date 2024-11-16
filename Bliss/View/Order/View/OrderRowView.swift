//
//  OrderRowView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-11-11.
//

import SwiftUI

struct OrderRowView: View {
    var order: Order
    var body: some View {
        HStack(alignment: .top) {
            Image("flower5")
                .resizable()
                .frame(width: 110, height: 110)
                .cornerRadius(8)
                .background(Color(.systemGray6)) // Light background color
                .padding(.trailing, 10) // Spacing between image and text
            
            VStack(alignment: .leading, spacing: 6) {
//                Text(order.productname)
//                    .fontWeight(.semibold)
//                    .font(.headline)
                Text("\(order.totalPrice.currencyFormat())")
                    .fontWeight(.light)
                    .font(.subheadline)
                
//                Text("Delivery Date: \(order.date)")
//                    .font(.callout)
                Text("Status: \(order.status)")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading) // Forces HStack to align content to the leading side
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
//    OrderRowView(order: Order.dummyOrder)
}
