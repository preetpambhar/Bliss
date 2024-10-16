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
      
      let helplineNumber = "+1 123-123-1234"
      let contactEmail = "support@blissflowers.com"
      
      var body: some View {
          NavigationView {
              VStack(alignment: .leading, spacing: 20) {
                  
                  Text("Contact Us")
                      .font(.largeTitle)
                      .fontWeight(.bold)
                      .padding(.bottom, 20)
                  
                  // Name Input Field
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
                      // Handle send message action here
                      print("Message sent: \(name), \(email), \(message)")
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
                  
                  //Spacer()
                  
                  VStack(alignment: .leading, spacing: 10) {
                      Text("Need Immediate Help?")
                          .font(.headline)
                      
                      // Helpline Number
                      HStack {
                          Image(systemName: "phone.fill")
                          Text("Helpline: ")
                          Link(helplineNumber, destination: URL(string: "tel://\(helplineNumber)")!)
                      }
                      .font(.subheadline)
                      .foregroundColor(.blue)
                      
                      // Email Address
                      HStack {
                          Image(systemName: "envelope.fill")
                          Text("Email: ")
                          Link(contactEmail, destination: URL(string: "mailto:\(contactEmail)")!)
                      }
                      .font(.subheadline)
                      .foregroundColor(.blue)
                  }
                  .padding(.horizontal)
                  .padding(.top, 10)
                  
                  
                  // Social Media Links
                  HStack {
                      Spacer()
                      VStack {
                          Text("Follow Us:")
                              .font(.headline)
                              .padding(.bottom, 5)
                          
                          HStack(spacing: 20) {
                              Image(systemName: "phone.fill")
                              Image(systemName: "envelope.fill")
                              Image(systemName: "globe")
                          }
                          .font(.largeTitle)
                          .foregroundColor(.blue)
                      }
                      Spacer()
                  }
                  .padding(.top, 10)
                  
              }
              .padding(.top, 40)
              .navigationBarTitle("Contact Us", displayMode: .inline)
          }
      }
}

#Preview {
    ContactUs()
}
