//
//  AddAddress.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-05.
//

import SwiftUI
import MapKit

struct AddAddress: View {
    @EnvironmentObject var addressViewModel: AddressViewModel
    @State private var showLocationSearchView = false
    var showBackButton: Bool
    @EnvironmentObject var viewModel : LocationSearchViewModel
    
    @State private var province: String = ""
        @State private var city: String = ""
        @State private var address: String = ""
        @State private var appNo: String = ""
        @State private var floor: String = ""
        @State private var message: String = ""

    var body: some View {
        ScrollView {
            VStack{
                NavigationLink(destination: SearchView()) {
                        LocationSearchActivation()
                }
                //.isDetailLink(false)
              
                VStack (){
                    MapViewRepresentable()
                        //.ignoresSafeArea()
                        .frame(width: UIScreen.main.bounds.width - 15 , height: 300)
                    //Spacer()
                }
                .padding(.top, 10)
                .frame(alignment: .top)
                VStack(spacing: 20){
                    TextField("hint", text: $province)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(.background, in: .rect(cornerRadius: 10))
                    
                    HStack{
                        TextField("Province*", text: $province)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 8)
                            .background(.background, in: .rect(cornerRadius: 10))
                        TextField("City*", text: $city)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 8)
                            .background(.background, in: .rect(cornerRadius: 10))
                    }
                    
                    TextField("Address*", text: $address)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(.background, in: .rect(cornerRadius: 10))
                    
                    HStack{
                        TextField("App. No*", text: $appNo)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 8)
                            .background(.background, in: .rect(cornerRadius: 10))
                        TextField("Floor*", text: $floor)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 8)
                            .background(.background, in: .rect(cornerRadius: 10))
                    }
                            TextField("Message: Any relevant details", text: $message)
                                .frame(minHeight: 70, alignment: .topLeading)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 8)
                                .background(.background, in: .rect(cornerRadius: 10))
                    
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
                .padding(5)
                .navigationBarBackButtonHidden(!showBackButton)
                .navigationTitle("Add Address")
            }
        }
    }
    func saveAddress() {
            // Perform save logic here
            print("Saving address data...")
            print("Province: \(province), City: \(city), Address: \(address), App No: \(appNo), Floor: \(floor), Message: \(message)")
        }
}

#Preview {
    AddAddress(showBackButton: true)
        .environmentObject(AddressViewModel())
}
