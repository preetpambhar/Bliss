//
//  ContactUs.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-15.
//

import SwiftUI

struct ContactUs: View {
    @State private var name: String = ""
      @State private var email: String = ""
      @State private var message: String = ""
    @State private var showToast: Bool = false
    @State private var showAlert: Bool = false
      
      let helplineNumber = "+1 123-123-1234"
      let contactEmail = "support@blissflowers.com"
      
    var body: some View {
        ZStack{
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                TextField("Your Name", text: $name)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                // Email Input Field
                TextField("Your Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                // Message Input Field
                TextEditor(text: $message)
                    .frame(height: 150)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                // Submit Button
                Button(action: {
                    // Validation: Check if the message is empty
                    guard !message.trimmingCharacters(in:.whitespacesAndNewlines).isEmpty else {
                        showAlert = true // Show alert if message is empty
                        return
                    }
                    
                    // clear user inputs
                    name = ""
                    email = ""
                    message = ""
                    
                    withAnimation {
                        showToast = true
                    }
                    
                    // Hide toast after 2 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            showToast = false
                        }
                    }
                }) {
                    Text("Send Message")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text("Need Immediate Help?")
                        .font(.headline)
                    
                    // Helpline Number
                    HStack {
                        SwiftUI.Image(systemName: "phone.fill")
                        Text("Helpline: ")
                        Link(helplineNumber, destination: URL(string: "tel://\(helplineNumber)")!)
                    }
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    
                    // Email Address
                    HStack {
                        SwiftUI.Image(systemName: "envelope.fill")
                        Text("Email: ")
                        Link(contactEmail, destination: URL(string: "mailto:\(contactEmail)")!)
                    }
                    .font(.subheadline)
                    .foregroundColor(.blue)
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
            // .padding()
            .navigationBarTitle("Contact Us")
        }
        // Toast message
        if showToast {
            VStack {
                Spacer()
                Text("Message sent successfully!")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.bottom, 50)
            }
            .transition(.opacity)
        }
    }
              .alert(isPresented: $showAlert) {
                         Alert(
                             title: Text("Validation Error"),
                             message: Text("Please enter a message before sending."),
                             dismissButton: .default(Text("OK"))
                         )          }
      }
}

#Preview {
    ContactUs()
}
