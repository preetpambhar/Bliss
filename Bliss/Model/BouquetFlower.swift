//
//  BouquetFlower.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-04.
//
import Foundation

struct BouquetFlower: Codable {
    let flowerName: String
    let quantity: Int
    let flowerPrice: Double
    
    enum CodingKeys: String, CodingKey {
        case flowerName = "flower_name"
        case quantity
        case flowerPrice = "flower_price"
    }
}
