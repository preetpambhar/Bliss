//
//  Order.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-16.
//
import Foundation

struct Order: Codable {
    let id: String
    let userId: String
    let status: String
    let subtotal: Double
    let tax: Double
    let shippingFee: Double
    let totalPrice: Double
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case status
        case subtotal
        case tax
        case shippingFee = "shipping_fee"
        case totalPrice = "total_price"
        case createdAt = "created_at"
    }
}
