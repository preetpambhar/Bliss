//
//  ContentView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-09-23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @AppStorage("isFirstTime") private var isfirsttime : Bool = true
    @State private var activeTab: Tab = .home
    var body: some View {
        TabView(selection: $activeTab){
            Home()
                .tag(Tab.home)
                .tabItem { Tab.home.tabContent }
            
            Flowers()
                .tag(Tab.flowers)
                .tabItem { Tab.flowers.tabContent }
            
            Cart()
                .tag(Tab.cart)
                .tabItem { Tab.cart.tabContent }
            
            Profile()
                .tag(Tab.profile)
                .tabItem { Tab.profile.tabContent }
        }
        .tint(appTint)
        .overlay( SplashScreen())
    }
}


#Preview {
    ContentView()
}
