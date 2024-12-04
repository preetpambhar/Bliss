//
//  APIService.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-27.
//
import Foundation
import UIKit

enum SearchType: String, Codable {
    case bouquets
    case flowers
}

struct SearchResult: Codable, Identifiable {
    let id: String
    let name: String
    let description: String?
    let price: Double
    let imageUrl: String
    let similarity: Double
    var type: SearchType
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case imageUrl = "image_url"
        case similarity
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        price = try container.decode(Double.self, forKey: .price)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        similarity = try container.decode(Double.self, forKey: .similarity)
        type = .bouquets // Default value, will be updated by the API service
    }
    
    func toBouquet() -> Bouquet {
        Bouquet(
            id: id,
            name: name,
            description: description,
            images: [
                BouquetImage(
                    id: UUID().uuidString,
                    imageUrl: imageUrl,
                    isPrimary: true,
                    createdAt: Date().ISO8601Format()
                )
            ],
            price: price,
            status: "active",
            isCustom: false,
            createdAt: Date().ISO8601Format()
        )
    }
    
    func toFlower() -> Flower {
        Flower(
            id: id,
            name: name,
            description: description,
            images: [
                BouquetImage(
                    id: UUID().uuidString,
                    imageUrl: imageUrl,
                    isPrimary: true,
                    createdAt: Date().ISO8601Format()
                )
            ],
            price: price,
            stock: 1,
            status: "active",
            createdAt: Date().ISO8601Format()
        )
    }
}

class APIService {
    private let baseURL = "http://0.0.0.0:8989"
    
    func searchSimilar(image: UIImage, searchType: SearchType) async throws -> [SearchResult] {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to process image"])
        }
        
        // Create URL with query parameters
        var urlComponents = URLComponents(string: "\(baseURL)/search-similar")!
        urlComponents.queryItems = [
            URLQueryItem(name: "search_type", value: searchType.rawValue),
            URLQueryItem(name: "limit", value: "10")
        ]
        
        guard let url = urlComponents.url else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        
        print("Request URL: \(url.absoluteString)")  // Debug print
        
        let boundary = "Boundary-\(UUID().uuidString)"
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        // Add the image file
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n")
        body.append("Content-Type: image/jpeg\r\n\r\n")
        body.append(imageData)
        body.append("\r\n")
        
        // Add the final boundary
        body.append("--\(boundary)--\r\n")
        
        request.httpBody = body
        
        // Debug prints
        print("Request headers: \(request.allHTTPHeaderFields ?? [:])")
        print("Search type: \(searchType.rawValue)")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response status code: \(httpResponse.statusCode)")
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Response data: \(jsonString)")
            }
            
            let decoder = JSONDecoder()
            let searchResponse = try decoder.decode(SearchResponse.self, from: data)
            return searchResponse.results.map { result in
                var mutableResult = result
                mutableResult.type = searchType
                return mutableResult
            }
        } catch {
            print("Error during API call: \(error)")
            throw error
        }
    }
}

struct SearchResponse: Codable {
    let results: [SearchResult]
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
