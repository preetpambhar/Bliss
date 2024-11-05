//
//  Queries.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-04.
//
import Foundation
import Supabase

class Queries {
    let client: SupabaseClient
    
    init(client: SupabaseClient) {
        self.client = client
    }
    
    func fetchAvailableFlowers() async throws -> [Flower] {
        return try await client
            .from("flowers")
            .select()
            .eq("status", value: "active")
            .gt("stock", value: 0)
            .order("name")
            .execute()
            .value
    }
    
    func fetchSeasonalFlowers() async throws -> [Flower] {
        return try await client
            .from("flowers")
            .select()
            .eq("status", value: "seasonal")
            .gt("stock", value: 0)
            .order("name")
            .execute()
            .value
    }
    
    func fetchBouquets() async throws -> [Bouquet] {
        return try await client
            .from("bouquets")
            .select()
            .eq("status", value: "active")
            .eq("is_custom", value: false)
            .order("name")
            .execute()
            .value
    }
    
    func fetchBouquetDetails(bouquetId: UUID) async throws -> BouquetWithFlowers {
        let query = """
        bouquets!inner(id, name, description, image_url, price),
        bouquet_flowers!inner(quantity),
        flowers!inner(name:flower_name, price:flower_price)
        """
        
        return try await client
            .from("bouquets")
            .select(query)
            .eq("id", value: bouquetId)
            .single()
            .execute()
            .value
    }
    
    func searchBouquets(withTag tag: String) async throws -> [Bouquet] {
        return try await client
            .from("bouquets")
            .select("*, search_metadata!inner(*)")
            .contains("search_metadata.image_tags", value: [tag])
            .eq("status", value: "active")
            .execute()
            .value
    }
    
    func fetchBouquetsInPriceRange(min: Decimal, max: Decimal) async throws -> [Bouquet] {
        return try await client
            .from("bouquets")
            .select()
            .gte("price", value: String(describing: min))
            .lte("price", value: String(describing: max))
            .eq("status", value: "active")
            .order("price")
            .execute()
            .value
    }
}

