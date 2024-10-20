//
//  Cart.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-11.
//

import Foundation

struct CartModel: Decodable, Identifiable {
    let id: Int
    let title, description, category, image: String
    let price: Double
    let rating: rate
    
    static var dummy: CartModel{
        return CartModel(id: 1, title: "Fjallraven - Foldsack No. 1 ", description: "Your perfect pack", category: "men's clothing", image: "https://images.unsplash.com/photo-1597075337043-9d54b66d0b8f?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDMxfHx8ZW58MHx8fHx8", price:109.95 , rating: rate(rate:3.9 , count: 120))
    }
    static var dummy1: CartModel {
        return CartModel(id: 2,
                         title: "Flower set",
                         description: "Stylish and attractive flower set for your loved once.",
                         category: "womens's special",
                         image: "https://images.unsplash.com/photo-1602195053633-4a85496a8cd2?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                         price: 49.99,
                         rating: rate(rate: 4.5, count: 85))
    }

}
