//
//  OrderView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-11-11.
//

import SwiftUI

struct OrderView: View {
    @State private var selectedProduct: Product? = nil
    @State private var navigate = false
    var body: some View {
        NavigationStack{
        ScrollView{
            OrderRowView(order: .dummyOrder).onTapGesture {
                OrderDetailsView(order: .dummyOrder)
            }
            OrderRowView(order: .dummyOrder)
            OrderRowView(order: .dummyOrder)
            OrderRowView(order: .dummyOrder)
            NavigationLink(destination: OrderDetailsView(order: .dummyOrder)) {
                OrderRowView(order: .dummyOrder)
              }
           }
        }
    }
}

#Preview {
    OrderView()
}
