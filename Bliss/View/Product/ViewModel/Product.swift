//
//  Product.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-11.
//

import Foundation

struct Product: Decodable, Identifiable {
    let id: Int
    let title, description, category, image: String
    let price: Double
    let rating: rate
    let addOnOptions: [AddOnOption]?
    
    static var dummy: Product{
        return Product(id: 1, title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops", description: "Your perfect pack", category: "men's clothing", image: "https://images.unsplash.com/photo-1597075337043-9d54b66d0b8f?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDMxfHx8ZW58MHx8fHx8", price:109.95 , rating: rate(rate:3.9 , count: 120),addOnOptions: [AddOnOption(name: "Rose", imageURL: "flower1", price: 5.0),
                                     AddOnOption(name: "Tulip", imageURL: "flower2", price: 3.0),
                                     AddOnOption(name: "Lily", imageURL: "flower3", price: 4.0)])
    }
}


struct rate: Decodable{
    let rate: Double
    let count: Int
}

struct AddOnOption: Decodable, Identifiable {
    let id: UUID = UUID() // Unique identifier for each option
    let name: String
    let imageURL: String
    let price: Double
}

