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
    let images: [BouquetImage]
    let price: Double
    let stock: Int
    let status: String
    let createdAt: String
    
    var primaryImage: String {
        images.first { $0.isPrimary }?.imageUrl ?? 
        images.first?.imageUrl ?? 
        "default_flower_image_url"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case images = "flower_images"
        case price, stock, status
        case createdAt = "created_at"
    }
}
