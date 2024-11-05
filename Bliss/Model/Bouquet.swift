//
//  Bouquet.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-04.
//

import Foundation

struct Bouquet: Codable {
    let id: String
    let name: String
    let description: String?
    let imageUrl: String
    let price: Double
    let status: String
    let isCustom: Bool
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case imageUrl = "image_url"
        case price, status
        case isCustom = "is_custom"
        case createdAt = "created_at"
    }
}
