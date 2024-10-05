//
//  SearchView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-05.
//

import SwiftUI

struct SearchView: View {
  //  @Environment(\.presentationMode) var presentationMode
    @State private var showLocationSearchView = false
    @State private var navigateToAddAddress = false
    var body: some View {
        VStack{
            if showLocationSearchView {
                LocationSearchView(locationSearchView: $showLocationSearchView, showLoactionSearchView: $showLocationSearchView)
                    } else {
                        LocationSearchActivation()
                            .onTapGesture {
                                withAnimation(.spring()){
                                    showLocationSearchView.toggle()
                                }
                            }
                    }
            
                MapViewRepresentable()
                    //.ignoresSafeArea()
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.top, 5)
                //Spacer()
            Button(action: {
                navigateToAddAddress = true
            }, label: {
              Text("Confirm")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,14)
                    .background(appTint.gradient, in: .rect(cornerRadius: 12))
                    .contentShape(.rect)
            })
            .padding(10)
            .frame(width: UIScreen.main.bounds.width)
            .navigationTitle("Get Direction")
            
            NavigationLink(destination: AddAddress(showBackButton: false), isActive: $navigateToAddAddress) {
                EmptyView()
            }
        }
    }
}

#Preview {
    SearchView()
}
