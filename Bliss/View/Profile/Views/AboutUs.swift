//
//  AboutUs.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-12-04.
//


import SwiftUI

struct AboutUs: View {


    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading, spacing: 20) {
                    // App Name and Introduction
                    Text("Welcome to Bliss")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)

                    Text("""
                                At Bliss, we believe that every moment deserves a touch of beauty. Whether you're celebrating a milestone, expressing love, or simply making someone smile, our mission is to help you create memories with thoughtfully curated flower arrangements.
                                """)
                    .font(.body)
                    .foregroundColor(.secondary)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Our Mission")
                            .font(.headline)
                            .fontWeight(.semibold)

                        Text("""
                                    To bring joy and convenience to flower gifting by providing a seamless, user-friendly platform that caters to your unique needs. We strive to deliver the freshest, most stunning flower arrangements tailored to any occasion.
                                    """)
                        .font(.body)
                        .foregroundColor(.secondary)
                    }

                    // Features
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Why Choose Bliss?")
                            .font(.headline)
                            .fontWeight(.semibold)

                        Text("""
                                    • **Customized Arrangements:** Personalize flower sets to match your preferences and the recipient's style.\n
                                    • **AI-Powered Recommendations:** Get the perfect bouquet suggestions based on your needs and occasions.\n
                                    • **Virtual Preview:** Visualize flower arrangements with our augmented reality feature.\n
                                    • **Eco-Friendly Options:** We’re committed to sustainability and offer eco-conscious packaging.
                                    """)
                        .font(.body)
                        .foregroundColor(.secondary)
                    }


                    VStack(alignment: .leading, spacing: 10) {
                        Text("Thank You")
                            .font(.headline)
                            .fontWeight(.semibold)

                        Text("""
                                    Thank you for choosing Bliss as your trusted partner in creating unforgettable moments. We're excited to be a part of your celebrations and look forward to delivering happiness, one bouquet at a time.
                                    """)
                        .font(.body)
                        .foregroundColor(.secondary)
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("About Us")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    AboutUs()
}
