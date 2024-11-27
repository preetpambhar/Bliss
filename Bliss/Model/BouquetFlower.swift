//
//  BouquetFlower.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-04.
//
import Foundation

struct BouquetFlower: Codable, Identifiable {
    let bouquetId: String
    let flowerId: String
    let quantity: Int
    
    var id: String { flowerId }
    
    enum CodingKeys: String, CodingKey {
        case bouquetId = "bouquet_id"
        case flowerId = "flower_id"
        case quantity
    }
}
