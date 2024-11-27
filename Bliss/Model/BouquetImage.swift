//
//  BouquetImage.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-27.
//
import Foundation

struct BouquetImage: Codable, Identifiable {
    let id: String
    let imageUrl: String
    let isPrimary: Bool
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "image_url"
        case isPrimary = "is_primary"
        case createdAt = "created_at"
    }
}
