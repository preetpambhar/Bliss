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
    let images: [BouquetImage]
    let price: Double
    let status: String
    let isCustom: Bool
    let createdAt: String
    
    var primaryImage: String {
        images.first { $0.isPrimary }?.imageUrl ?? 
        images.first?.imageUrl ?? 
        "default_bouquet_image_url"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Bouquet, rhs: Bouquet) -> Bool {
        lhs.id == rhs.id
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case images = "bouquet_images"
        case price, status
        case isCustom = "is_custom"
        case createdAt = "created_at"
    }
}
