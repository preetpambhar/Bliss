//
//  SettingView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-11-23.
//

import SwiftUI

struct PrivacyPolicyView: View {
   
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView{
                    VStack(alignment: .leading, spacing: 16) {
                                       Text("Privacy Policy")
                                           .font(.title)
                                           .bold()
                                           .padding(.bottom, 8)
                                       
                                       Text("Effective Date: November 23, 2024")
                                           .font(.subheadline)
                                           .foregroundColor(.gray)
                                       
                                       Divider()
                                       
                                       //Introduction
                                       Text("Introduction")
                                           .font(.headline)
                                           .padding(.bottom, 4)
                                       
                                       Text("""
                                       At Bliss, your privacy is our priority. This Privacy Policy explains how we collect, use, and share your personal information when you use our app.
                                       """)
                                           .font(.body)
                                           .foregroundColor(.secondary)
                                       
                                       Divider()
                                       
                                       Text("What Information We Collect")
                                           .font(.headline)
                                           .padding(.bottom, 4)
                                       
                                       Text("""
                                       - **Personal Information:** Your name, email, and other account details.
                                       - **Usage Data:** Information about how you use the app, including features accessed.
                                       - **Location Data:** If enabled, approximate or precise location for personalized features.
                                       """)
                                           .font(.body)
                                           .foregroundColor(.secondary)
                                       
                                       Divider()
                                       
                                       Text("How We Use Your Information")
                                           .font(.headline)
                                           .padding(.bottom, 4)
                                       
                                       Text("""
                                       Your data is used to provide and improve app functionality, respond to your inquiries, and ensure a secure experience.
                                       """)
                                           .font(.body)
                                           .foregroundColor(.secondary)
                                       
                                       Divider()
                                       
                                       Text("Your Rights")
                                           .font(.headline)
                                           .padding(.bottom, 4)
                                       
                                       Text("""
                                       You have the right to access, update, or delete your data. To exercise these rights, contact us at support@bliss.com.
                                       """)
                                           .font(.body)
                                           .foregroundColor(.secondary)
                                       
                                       Spacer()
                                }
                    .padding()
                }
            }
            .navigationTitle("Setting")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    PrivacyPolicyView()
}
