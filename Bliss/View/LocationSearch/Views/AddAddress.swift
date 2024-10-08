//
//  AddAddress.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-05.
//

import SwiftUI
import MapKit

struct AddAddress: View {
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    @State private var showLocationSearchView = false
    var showBackButton: Bool
    @EnvironmentObject var viewModel : LocationSearchViewModel
    
    @State private var province: String = ""
        @State private var city: String = ""
        @State private var address: String = ""
        @State private var appNo: String = ""
        @State private var floor: String = ""
        @State private var message: String = ""

    @State private var selectedLocationTitle: String = ""
    @State private var selectedLocationSubTitle: String = ""
    
    var body: some View {
        ScrollView {
            VStack{
                NavigationLink(destination: SearchView()) {
                        LocationSearchActivation()
                }
                .padding()
                //.isDetailLink(false)
              
                VStack (){
                    MapViewRepresentable()
                        //.ignoresSafeArea()
                        .frame(width: UIScreen.main.bounds.width - 15 , height: 300)
                }
                .frame(alignment: .top)
                
                VStack(spacing: 20){
                  HStack{
                        TextField("Street address OR building name*", text: $selectedLocationTitle)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 8)
                            .frame(height: 50)
                            .background(.background, in:.rect(cornerRadius: 10))
                            .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 2)
                    }
                    
                    TextField("City, state/province & country*", text: $selectedLocationSubTitle)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .frame(height: 50)
                        .background(.background, in: .rect(cornerRadius: 10))
                        .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 2)
                    
                    TextField("Message: Any relevant details", text: $message)
                           .frame(minHeight: 70, alignment: .topLeading)
                           .padding(.horizontal, 15)
                           .padding(.vertical, 8)
                           .background(.background, in: .rect(cornerRadius: 10))
                           .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 2)
                    
                        Button(action: {
                            saveAddress()
                        }) {
                            Text("Save")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    
                }
                .shadow(color: Color(.darkGray), radius: 1)
                .padding(15)
                .navigationBarBackButtonHidden(!showBackButton)
                .navigationTitle("Add Address")
            }
            .onAppear {
                if let location = locationViewModel.selectedUserLocation {
                selectedLocationTitle = location.title
                    selectedLocationSubTitle = location.subtitle
                }
            }
            .onReceive(LocationManager.shared.$userLocation) {
                location in
                if let location = location {
                    viewModel.userLocation = location
                }
            }
        }
    }
    func saveAddress() {
            // Perform save logic here
            print("Saving address data...")
            print("Province: \(selectedLocationTitle), Address: \(selectedLocationSubTitle), Message: \(message)")
        }
}

#Preview {
    AddAddress(showBackButton: true)
        .environmentObject(AddressViewModel())
}
