//
//  APIManager.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-11.
//

import Foundation

enum NetworkError: Error{
    case invalidURL
    case invalidResponse
}
//Error: Throw
//Response: Return
final class APIManager{
    func request <T: Decodable>(url : String) async throws -> T{
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
        
}
