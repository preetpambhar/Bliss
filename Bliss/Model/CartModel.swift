//
//  CartModel.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-14.
//

import Foundation

struct CartModel: Codable, Identifiable {
    let id: String
    let userId: String
    let createdAt: String
    let lastModified: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case createdAt = "created_at"
        case lastModified = "last_modified"
    }
}
