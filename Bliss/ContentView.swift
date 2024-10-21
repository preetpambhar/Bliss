//
//  ContentView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-09-23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var isAuthenticated = false
    
    @AppStorage("isFirstTime") private var isfirsttime : Bool = true
    @State private var activeTab: Tab = .home
    @State private var isAddAddressActive = false
    
    var body: some View {
        Group {
          if isAuthenticated {
              TabView(selection: $activeTab){
                  Home(selectedLocationTitle: "")
                      .tag(Tab.home)
                      .tabItem { Tab.home.tabContent }
                  
                  Flowers(selectedLocationTitle: "")
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
          } else {
            AuthView()
          }
        }.task {
            for await state in supabaseClient.auth.authStateChanges {
              if [.initialSession, .signedIn, .signedOut].contains(state.event) {
                isAuthenticated = state.session != nil
              }
            }
        }
    }
}


#Preview {
    ContentView()
}
