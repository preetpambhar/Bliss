//
//  SettingView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-11-23.
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
    SettingView()
}
