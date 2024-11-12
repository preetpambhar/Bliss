//
//  OrderViewModel.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-11-12.
//
import Foundation

struct Order: Decodable, Identifiable{
    let id: UUID = UUID()
    let productImage: String
    let productname: String
    let description: String
    let price: Double
    let rating: ratings
    let date: String
    let status: String
    
    static var dummyOrder: Order {
        return
        Order(productImage: "https://images.unsplash.com/photo-1597075337043-9d54b66d0b8f?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDMxfHx8ZW58MHx8fHx8", productname: "Dirty Rose",description: "as as ", price: 25.99,rating: ratings(rate: 4.5, count: 123), date: "2024-11-24", status: "Processing")
    }
}

    
struct ratings: Decodable{
    let rate: Double
    let count: Int
}
