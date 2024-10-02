//
//  home.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-09-27.
//

import SwiftUI

struct Home: View {
    @State private var searchText: String = ""
    var body: some View {
        
     //   Base view
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Good Morning")
                            .font(.title)
                        
                        LocationSearchActivation()
                        
                        HStack {
                            CustomCrousel(content: [
                                                    Image("flowers")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .cornerRadius(15) ,
                                                    Image("bliss")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .cornerRadius(15),
                                                    Image("flowers")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .cornerRadius(15)
                                                ])
                            .frame(height: 200)
                        }
                        
                        Image("flowers")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 380)
                        .cornerRadius(15)
                    }
                    .padding()
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    Home()
}
