//
//  CartItem.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-14.
//
import Foundation

struct CartItem: Codable, Identifiable {
    let id: String
    let cartId: String
    let bouquetId: String?
    let flowerId: String?
    let quantity: Int
    let createdAt: String
    
    // Joined data
    var bouquet: Bouquet?
    var flower: Flower?
    
    enum CodingKeys: String, CodingKey {
        case id
        case cartId = "cart_id"
        case bouquetId = "bouquet_id"
        case flowerId = "flower_id"
        case quantity
        case createdAt = "created_at"
        case bouquet, flower
    }
    
    var itemName: String {
        if let bouquet = bouquet {
            return bouquet.name
        } else if let flower = flower {
            return flower.name
        }
        return "Unknown Item"
    }
    
    var itemPrice: Double {
        if let bouquet = bouquet {
            return bouquet.price
        } else if let flower = flower {
            return flower.price
        }
        return 0.0
    }
    
    var imageUrl: String {
        if let bouquet = bouquet {
            return bouquet.imageUrl
        } else if let flower = flower {
            return flower.imageUrl
        }
        return ""
    }
}
