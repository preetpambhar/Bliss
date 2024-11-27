//
//  Flower.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-04.
//
import Foundation

struct Flower: Identifiable, Codable {
    let id: String
    let name: String
    let description: String?
    let imageUrl: String
    let price: Double
    let stock: Int
    let status: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case imageUrl = "image_url"
        case price, stock, status
        case createdAt = "created_at"
    }
}
