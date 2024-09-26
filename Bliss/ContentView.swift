//
//  ContentView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-09-23.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        //Base view
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading, spacing: 20) {
                    Text("Good Morning")
                        .font(.title)
                    
                    Image("flowers")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 480)
                    .cornerRadius(15)
                }
                .padding()
            }
            .navigationTitle("Home")
        }
        .overlay( SplashScreen())
    }
}


#Preview {
    ContentView()
}
