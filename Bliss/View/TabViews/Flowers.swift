//
//  flowers.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-09-27.
//

import SwiftUI

struct Flowers: View {
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .center, spacing: 20) {
                    Text("Your Picked Address")
                    
                    ForEach(0..<4){_ in
                        products()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Flowers")
        .navigationBarTitleDisplayMode(.large)
    }
    
    @ViewBuilder
    func products() -> some View {
       HStack(){
           HStack (spacing: 20){
               VStack(alignment:.leading) {
                   Image("flower1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 142, height: 110)
                            .cornerRadius(15)
                        .clipped()
                        //.animation(.snappy)
               }
               VStack(alignment: .leading) {
                   Text("Flowers Flowers ")
                       .font(.headline)
                   
                   Text("Flowers")
                       .font(.body)
                   
                   Text("Flowers")
                       .font(.callout)
                   HStack {
                       ForEach(0..<4) {_ in
                           Image(systemName: "star")
                       }
                       Text("4.5")
                           .font(.title3)
                   }
                   HStack {
                       Image(systemName: "info")
                           .foregroundColor(.black)
                           .background(.blue)
                           
                       
                       Text("40 - 45 Min")
                           .font(.callout)
                   }
               }
           }
           .frame(maxWidth: .infinity, alignment: .leading)
        }
       .padding(.top, 5)
    }
}

#Preview {
    Flowers()
}
