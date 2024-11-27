//
//  OrderView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-11-11.
//

import SwiftUI

struct OrdersView: View {
    @StateObject private var orderManager = OrderManager()
    
    var body: some View {
        NavigationView {
            Group {
                if orderManager.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(orderManager.orders, id: \.id) { order in
                                NavigationLink(destination: OrderDetailsView(order: order)) {
                                    OrderRowView(order: order)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Orders")
        }
        .task {
            await orderManager.loadOrders()
        }
    }
}

#Preview {
    OrdersView()
}
