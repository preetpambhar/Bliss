//
//  home.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-09-27.
//

import SwiftUI

struct Home: View {
    @State private var showLocationSearchView = false
    @State var selectedLocationTitle: String
    @State private var showAddAddress = false
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                    VStack(alignment: .leading, spacing: 20) {
                        if !selectedLocationTitle.isEmpty{
                            Text("Delivery Address: " + selectedLocationTitle)
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                                .lineLimit(1)
                        }else { NavigationLink(destination: AddAddress(showBackButton: true, requestedpage: "home"), isActive: $showAddAddress) {
                            //                                               LocationSearchActivation()
                            HStack{
                                Image(systemName: "plus")
                                //.fill(Color.black)
                                    .frame(width: 8, height: 8)
                                    .foregroundColor(Color(.darkGray))
                                    .padding(.horizontal)
                                Text("Add Location")
                                    .foregroundColor(Color(.darkGray))
                                    .onTapGesture {
                                        showAddAddress = true
                                    }
                                Spacer()
                                
                            }
                            .frame(width: UIScreen.main.bounds.width - 20, height: 50)
                           }
                        }
                        HStack {
                            CustomCrousel(content: [
                                                    Image("flower6")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .cornerRadius(15) ,
                                                    Image("flower1")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .cornerRadius(15),
                                                    Image("flower3")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .cornerRadius(15)
                                                ])
                            .frame(height: 200)
                        }
                        VStack(spacing: 10) {
                            CategoryView(image: "bouquet1", action: "Button tapped!", text: "Seasonal Bouquets")
                            CategoryView(image: "bouquet2", action: "Button tapped!", text: "Birthday Bouquets")
                            CategoryView(image: "weddingflower1", action: "Button tapped!", text: "Romantic Bouquets")
                            CategoryView(image: "weddingflower4", action: "Button tapped!", text: "Sympathy and Funeral Bouquets")
                        }
                        
                    }
                    .padding()
                    .onAppear {
                        if let location = locationViewModel.selectedUserLocation {
                            selectedLocationTitle = location.title
                        }
                    }
            }
          .navigationTitle("Home")
          //.navigationBarBackButtonHidden(true)
        }
    }
    
    @ViewBuilder
    func CategoryView(image: String, action: String, text: String) -> some View {
        VStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 300)
                .cornerRadius(15)
            Text(text)
                .background(Color(.systemBackground))
            
            Button(action: {
                print(action)
            }) {
                Text(text)
                    .fontWeight(.bold)
                //.frame(maxWidth: UIScreen.main.bounds.width - 15)
                    .frame(width: UIScreen.main.bounds.width - 85)
                    .padding()
                    .background(Color(.systemBackground))
                    .foregroundColor(themeColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                    .cornerRadius(10)
            }
        }
        .padding(6)
    }
}

#Preview {
    Home(selectedLocationTitle: "")
}
