//
//  CustomBouquetViewModel.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-26.
//
import Foundation

@MainActor
class CustomBouquetViewModel: ObservableObject {
    @Published var availableFlowers: [Flower] = []
    @Published var bouquetFlowers: [BouquetFlower] = []
    @Published var selectedFlowerDetails: [Flower] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private let supabase = supabaseClient
    
    func loadFlowers() async {
        isLoading = true
        do {
            let response: [Flower] = try await supabase
                .from("flowers")
                .select("*")
                .eq("status", value: "active")
                .gt("stock", value: 0)
                .order("name")
                .limit(100)
                .execute()
                .value
            
            self.availableFlowers = response
            print("Loaded flowers count: \(response.count)")
        } catch {
            self.error = error
            print("Error loading flowers: \(error)")
        }
        isLoading = false
    }
    
    func loadBouquetFlowers(bouquetId: String) async {
        do {
            // Correct join query syntax for Supabase
            let query = """
            *, flowers(*)
            """
            
            let response: [BouquetFlowerWithDetails] = try await supabase
                .from("bouquet_flowers")
                .select(query)
                .eq("bouquet_id", value: bouquetId)
                .execute()
                .value
            
            await MainActor.run {
                self.bouquetFlowers = response.map { $0.toBouquetFlower() }
                self.selectedFlowerDetails = response.map { $0.flower }
                
                // Debug prints
                print("Loaded bouquet flowers count: \(response.count)")
                print("Selected flower details count: \(self.selectedFlowerDetails.count)")
                self.selectedFlowerDetails.forEach { flower in
                    print("Loaded flower: \(flower.name)")
                }
            }
        } catch {
            await MainActor.run {
                self.error = error
                print("Error loading bouquet flowers: \(error)")
            }
        }
    }
    
    private func loadSelectedFlowerDetails() async {
        let flowerIds = Set(bouquetFlowers.map { $0.flowerId })
        selectedFlowerDetails = availableFlowers.filter { flowerIds.contains($0.id) }
    }
    
    func saveCustomBouquet(name: String, description: String?, flowers: [String: Int]) async throws -> Bouquet {
        let totalPrice = calculateTotalPrice(flowers)
        let bouquetId = UUID().uuidString
        
        let defaultImageUrl = "https://images.unsplash.com/photo-1487530811176-3780de880c2d?q=80&w=2993&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" // Update this with your actual default image URL
        
        let bouquetRequest = CreateBouquetRequest(
            id: bouquetId,
            name: name,
            description: description,
            // imageUrl: defaultImageUrl,
            price: totalPrice,
            status: "active",
            isCustom: true
        )
        
        // Create new bouquet
        try await supabase
            .from("bouquets")
            .insert(bouquetRequest)
            .execute()
        
        // Create bouquet flowers requests
        let bouquetFlowersRequests = flowers.map { flowerId, quantity in
            CreateBouquetFlowerRequest(
                bouquetId: bouquetId,
                flowerId: flowerId,
                quantity: quantity
            )
        }
        
        // Add flowers to new bouquet
        try await supabase
            .from("bouquet_flowers")
            .insert(bouquetFlowersRequests)
            .execute()
        
        // Return the bouquet with the default image URL
        return Bouquet(
            id: bouquetId,
            name: name,
            description: description,
            imageUrl: defaultImageUrl,
            price: totalPrice,
            status: "active",
            isCustom: true,
            createdAt: ISO8601DateFormatter().string(from: Date())
        )
    }
    
    private func calculateTotalPrice(_ flowers: [String: Int]) -> Double {
        flowers.reduce(0) { total, item in
            let flower = availableFlowers.first { $0.id == item.key }
            return total + (flower?.price ?? 0) * Double(item.value)
        }
    }
}

// Add this new model to handle the joined response
struct BouquetFlowerWithDetails: Decodable {
    let bouquetId: String
    let flowerId: String
    let quantity: Int
    let flower: Flower
    
    enum CodingKeys: String, CodingKey {
        case bouquetId = "bouquet_id"
        case flowerId = "flower_id"
        case quantity
        case flower = "flowers"
    }
    
    func toBouquetFlower() -> BouquetFlower {
        BouquetFlower(
            bouquetId: bouquetId,
            flowerId: flowerId,
            quantity: quantity
        )
    }
}
