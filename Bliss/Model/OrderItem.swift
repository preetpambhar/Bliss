//
//  OrderItem.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-16.
//
import Foundation

struct OrderItem: Codable, Identifiable {
    let id: String
    let orderId: String
    let bouquetId: String?
    let flowerId: String?
    let quantity: Int
    let unitPrice: Double
    let totalPrice: Double
    let createdAt: String
    var bouquet: Bouquet?
    var flower: Flower?
    
    enum CodingKeys: String, CodingKey {
        case id
        case orderId = "order_id"
        case bouquetId = "bouquet_id"
        case flowerId = "flower_id"
        case quantity
        case unitPrice = "unit_price"
        case totalPrice = "total_price"
        case createdAt = "created_at"
        case bouquet, flower
    }
}
