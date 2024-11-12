//
//  OrderView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-11-11.
//

import SwiftUI

struct OrderView: View {
    var body: some View {
        ScrollView{
            OrderRowView(order: .dummyOrder).onTapGesture {
                OrderDetailsView(order: Order.dummyOrder)
            }
            OrderRowView(order: .dummyOrder)
            OrderRowView(order: .dummyOrder)
            OrderRowView(order: .dummyOrder)
        }
    }
}

#Preview {
    OrderView()
}
