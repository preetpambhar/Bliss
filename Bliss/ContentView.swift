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
            home()
                .tag(Tab.home)
                .tabItem { Tab.home.tabContent }
            
            home()
                .tag(Tab.search)
                .tabItem { Tab.search.tabContent }
            
            home()
                .tag(Tab.charts)
                .tabItem { Tab.charts.tabContent }
            
            Profile()
                .tag(Tab.settings)
                .tabItem { Tab.settings.tabContent }
        }
        .tint(appTint)
        .overlay( SplashScreen())
    }
}


#Preview {
    ContentView()
}
