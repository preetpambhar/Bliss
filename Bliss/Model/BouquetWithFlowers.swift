//
//  BouquetWithFlowers.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-04.
//
import Foundation

struct BouquetWithFlowers: Codable {
    let id: String
    let name: String
    let description: String?
    let imageUrl: String
    let price: Double
    let flowers: [BouquetFlower]
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case imageUrl = "image_url"
        case price, flowers
    }
}
