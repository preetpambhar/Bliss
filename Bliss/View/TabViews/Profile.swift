//
//  Profile.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-09-27.
//

import SwiftUI
import _PhotosUI_SwiftUI


struct Profile: View {
    // Navigation states
    @State private var navigateToOrders = false
    @State private var navigateToAddresses = false
    @State private var navigateToSavedBouquet = false
    @State private var navigateToRemindMe = false
    @State private var navigateToOnlineSupport = false
    @State private var navigateToPrivacyPolicy = false
    @State private var navigateToAboutUs = false
    @State private var navigateToSettings = false
    @State private var isLoading = false
    @State private var isEditingProfile = false
    
    // Profile data
    @State private var username:String? = "Cameron Williamson"
    @State private var contact:String? = "307-555-0133"
    @State private var avatar: UIImage? = UIImage(named: "bouquet1")
    
    var appVersion: String = "1.0.0"
    var buildNumber: String = "1"
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                
                VStack(spacing: 10) {
                    if let avatar = avatar {
                        SwiftUI.Image(uiImage: avatar)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 120, height: 120)
                                                .clipShape(Circle())
                                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                                .shadow(radius: 5)
                                        } else {
                                            SwiftUI.Image("bouquet1")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 120, height: 120)
                                                .clipShape(Circle())
                                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                                .shadow(radius: 5)
                                        }

                    if let username = username {
                        Text(username)
                            .font(.headline)
                            .foregroundColor(.black)
                    }else{
                        Text("Cameron Williamson")
                            .font(.headline)
                            .foregroundColor(.black)
                    }

                    if let contact = contact {
                        Text("\(contact)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    else {
                        Text("(307) 555-0133")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Button("Edit Profile") {
                         isEditingProfile = true
                        }
                        .padding(.top, 10)
                        .foregroundColor(.blue)                }
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
                                SwiftUI.Image(systemName: "cart")
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
                                SwiftUI.Image(systemName: "location")
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
                    NavigationLink(destination: SavedProduct(), isActive: $navigateToSavedBouquet) {
                        Button(action: {
                            navigateToSavedBouquet = true
                            print("Address view")
                        }) {
                            HStack {
                                SwiftUI.Image(systemName: "heart")
                                    .font(.system(size: 20))
                                    .foregroundColor(.blue)
                                Text("Saved Bouquet")
                            }
                        }
                    }
                    
                        NavigationLink(destination: ReminderHomeView(), isActive: $navigateToRemindMe) {
                            Button(action: {
                                navigateToRemindMe = true
                            }) {
                                HStack {
                                    SwiftUI.Image(systemName: "bell")
                                        .font(.system(size: 20))
                                        .foregroundColor(.purple)
                                    Text("Remind me")
                                }
                            }
                        }
                    
                    NavigationLink(destination: ContactUs(), isActive: $navigateToOnlineSupport) {
                        Button(action: {
                            navigateToOnlineSupport = true
                        }) {
                            HStack {
                                SwiftUI.Image(systemName: "person.crop.circle")
                                    .font(.system(size: 20))
                                    .foregroundColor(.orange)
                                Text("Online Support")
                            }
                        }
                    }
                    
                        NavigationLink(destination: PrivacyPolicyView(), isActive: $navigateToPrivacyPolicy) {
                        Button(action: {
                            navigateToPrivacyPolicy = true
                        }) {
                           HStack {
                               SwiftUI.Image(systemName: "lock.shield")
                                    .font(.system(size: 20))
                                    .foregroundColor(.gray)
                                Text("Privacy Policy")
                            }                        }
                    }
                }
                NavigationLink(destination: AboutUs(), isActive: $navigateToAboutUs) {
                                        Button(action: {
                                            navigateToAboutUs = true
                                            }) {
                                               HStack {
                                                   SwiftUI.Image(systemName: "person.2")
                                                        .font(.system(size: 20))
                                                        .foregroundColor(.green)
                                                    Text("About Us")
                                                }
                                            }
                                        }
                .padding(.top, 30)

                Spacer()
                HStack(alignment: .center) {
                                     Text("Version")
                                     Text("\(appVersion) (\(buildNumber))")
                                        .foregroundColor(.gray)
                                        .font(.callout)
                                }
                Spacer()
                Spacer()
            }
            .padding(20)
            .navigationTitle("Profile")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading){
                    Button("Sign out", role: .destructive) {
                        Task {
                            try? await supabaseClient.auth.signOut()
                        }
                    }
                }
            })
            .sheet(isPresented: $isEditingProfile) {
                           EditProfileView(username: $username, contact: $contact, avatar: $avatar)
            }
        }
    }
}

struct AddressesView: View {
    var body: some View {
        Text("Addresses View")
            .navigationBarTitle("Addresses")
    }
}

struct EditProfileView: View {
    @Binding var username: String?
    @Binding var contact: String?
    @Binding var avatar: UIImage?
    
    @State private var tempUsername: String
    @State private var tempContact: String
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var inputImage: UIImage? = nil
    
    @Environment(\.dismiss) var dismiss
    
    init(username: Binding<String?>, contact: Binding<String?>, avatar: Binding<UIImage?>) {
           _username = username
           _contact = contact
           _avatar = avatar
           _tempUsername = State(initialValue: username.wrappedValue ?? "")
           _tempContact = State(initialValue: contact.wrappedValue ?? "")
       }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Picture")) {
                    VStack {
                        if let avatar = avatar {
                            SwiftUI.Image(uiImage: avatar)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        
                        PhotosPicker(selection: $selectedImage, matching: .images, photoLibrary: .shared()) {
                            Text("Select New Image")
                                .foregroundColor(.blue)
                        }
                        .onChange(of: selectedImage) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self),
                                   let uiImage = UIImage(data: data) {
                                    avatar = uiImage
                                }
                            }
                        }
                    }
                }
                
                Section(header: Text("Details")) {
                    TextField("Name", text: $tempUsername)
                    TextField("Contact", text: $tempContact)
                        .keyboardType(.phonePad)
                }
            }
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()  // Dismiss edit view
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        username = tempUsername  // Save updated username
                        contact = tempContact    // Save updated contact
                        dismiss() // Save changes and dismiss
                    }
                }
            }
        }
    }
}

#Preview {
    Profile()
}
