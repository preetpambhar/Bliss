//
//  home.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-09-27.
//

import SwiftUI

struct Home: View {
    @State private var showLocationSearchView = false
    var body: some View {
        
     //   Base view
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                    VStack(alignment: .leading, spacing: 20) {
//                        Text("Good Morning")
//                            .font(.title)
                        
//                        if showLocationSearchView {
//                            LocationSearchView(locationSearchView: $showLocationSearchView, showLoactionSearchView: $showLocationSearchView)
//                                } else {
//                                    LocationSearchActivation()
//                                        .onTapGesture {
//                                            withAnimation(.spring()){
//                                                showLocationSearchView.toggle()
//                                            }
//                                        }
//                                }
                        NavigationLink(destination: AddAddress(showBackButton: true)) {
//                                               LocationSearchActivation()
                            HStack{
                                Image(systemName: "plus")
                                    //.fill(Color.black)
                                    .frame(width: 8, height: 8)
                                    .foregroundColor(Color(.darkGray))
                                    .padding(.horizontal)
                                Text("Add Location")
                                    .foregroundColor(Color(.darkGray))
                                
                                Spacer()
                            }
                            .frame(width: UIScreen.main.bounds.width - 20, height: 50)
                                           }
                                          // .buttonStyle(PlainButtonStyle())
                    
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
          //  .navigationTitle("Home")
        }
    }
}

#Preview {
    Home()
}
