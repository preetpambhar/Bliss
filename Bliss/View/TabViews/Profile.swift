//
//  Profile.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-09-27.
//

import SwiftUI


struct Profile: View {
    // Navigation states
    @State private var navigateToOrders = false
    @State private var navigateToAddresses = false
    @State private var navigateToSavedBouquet = false
    @State private var navigateToRemindMe = false
    @State private var navigateToOnlineSupport = false
    @State private var navigateToSettings = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                
                VStack(spacing: 10) {
                    Image("bouquet1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 5)
                    
                    Text("Cameron Williamson")
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Text("(307) 555-0133")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(20)
                .frame(width: UIScreen.main.bounds.width - 30, height: 240)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 10)
                
                // HStack for Orders and Addresses Buttons
                HStack(spacing: 30) {
                    NavigationLink(destination: OrdersView(), isActive: $navigateToOrders) {
                        Button(action: {
                            navigateToOrders = true
                        }) {
                            VStack {
                                Image(systemName: "cart")
                                    .font(.system(size: 30))
                                Text("Orders")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    }
                    
                    NavigationLink(destination: AddressesView(), isActive: $navigateToAddresses) {
                        Button(action: {
                            navigateToAddresses = true
                        }) {
                            VStack {
                                Image(systemName: "location")
                                    .font(.system(size: 30))
                                Text("Addresses")
                               
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    }
                }
                

                VStack(alignment: .leading, spacing: 20) {
                    Button(action: {
                        navigateToSavedBouquet = true
                        print("Address view")
                    }) {
                        HStack {
                            Image(systemName: "heart")
                                .font(.system(size: 20))
                                .foregroundColor(.blue)
                            Text("Saved Bouquet")
                        }
                    }
                    
                    Button(action: {
                        navigateToRemindMe = true
                    }) {
                        HStack {
                            Image(systemName: "bell")
                                .font(.system(size: 20))
                                .foregroundColor(.purple)
                            Text("Remind me")
                        }
                    }
                    
                    NavigationLink(destination: ContactUs(), isActive: $navigateToOnlineSupport) {
                        Button(action: {
                            navigateToOnlineSupport = true
                        }) {
                            HStack {
                                Image(systemName: "person.crop.circle")
                                    .font(.system(size: 20))
                                    .foregroundColor(.orange)
                                Text("Online Support")
                            }
                        }
                    }
                    
                    Button(action: {
                        navigateToSettings = true
                    }) {
                        HStack {
                            Image(systemName: "gear")
                                .font(.system(size: 20))
                                .foregroundColor(.gray)
                            Text("Setting")
                        }
                    }
                }
                .padding(.top, 30)
                
                Spacer()
            }
            .padding(20)
        .navigationBarTitle("Profile")
        }
    }
}

struct OrdersView: View {
    var body: some View {
        OrderView()
            .navigationBarTitle("Orders")
    }
}

struct AddressesView: View {
    var body: some View {
        Text("Addresses View")
            .navigationBarTitle("Addresses")
    }
}

#Preview {
    Profile()
}
