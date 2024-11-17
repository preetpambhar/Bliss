//
//  Bouquet.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-04.
//

import Foundation

struct Bouquet: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let description: String?
    let imageUrl: String
    let price: Double
    let status: String
    let isCustom: Bool
    let createdAt: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Bouquet, rhs: Bouquet) -> Bool {
        lhs.id == rhs.id
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case imageUrl = "image_url"
        case price
        case status
        case isCustom = "is_custom"
        case createdAt = "created_at"
    }
}
