//
//  PrivacyPolicyView.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-12-04.
//


import SwiftUI

struct PrivacyPolicyView: View {


    var body: some View {
        NavigationStack {
            ZStack {
              Text("Hello")

            }
            .navigationTitle("Setting")
            .navigationBarTitleDisplayMode(.inline)
//            .navigationDestination(isPresented: $cartManager.shouldNavigateToOrders) {
//                OrdersView()
//                    .navigationBarBackButtonHidden(true)
//            }
        }
    }
}


#Preview {
//    SettingView()
}
