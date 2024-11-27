//
//  CreateBouquetRequest.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-26.
//
import Foundation

struct CreateBouquetRequest: Encodable {
    let id: String
    let name: String
    let description: String?
    let price: Double
    let status: String
    let isCustom: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case status
        case isCustom = "is_custom"
    }
}

struct CreateBouquetFlowerRequest: Encodable {
    let bouquetId: String
    let flowerId: String
    let quantity: Int
    
    enum CodingKeys: String, CodingKey {
        case bouquetId = "bouquet_id"
        case flowerId = "flower_id"
        case quantity
    }
}
