//
//  ProductViewModel.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-11.
//

import Foundation

@Observable class ProductViewModel {
    
    var product: [Product] = []
    private let manager = APIManager()
    
    func fetchProducts () async{
        do{
            product = try await manager.request(url: "https://fakestoreapi.com/products")
            print(product)
        }catch{
            print("Fetch Product Error:", error)
        }
    }
}
