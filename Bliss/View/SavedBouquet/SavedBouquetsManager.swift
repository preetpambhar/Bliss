//
//  SavedBouquetsManager.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-17.
//
import Foundation

@MainActor
class SavedBouquetsManager: ObservableObject {
    @Published private(set) var savedBouquets: [Bouquet] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private let supabase = supabaseClient
    
    func loadSavedBouquets() async {
        isLoading = true
        do {
            guard let userId = try? await supabase.auth.session.user.id.uuidString else {
                isLoading = false
                return
            }
            
            let response: [SavedBouquetResponse] = try await supabase
                .from("saved_bouquets")
                .select("""
                    bouquet_id,
                    bouquet:bouquets(*)
                    """)
                .eq("user_id", value: userId)
                .execute()
                .value
            
            self.savedBouquets = response.compactMap { $0.bouquet }
            self.isLoading = false
        } catch {
            self.error = error
            self.isLoading = false
        }
    }
    
    func saveBouquet(_ bouquet: Bouquet) async {
        do {
            guard let userId = try? await supabase.auth.session.user.id.uuidString else { return }
            
            try await supabase
                .from("saved_bouquets")
                .insert(["user_id": userId, "bouquet_id": bouquet.id])
                .execute()
            
            await loadSavedBouquets()
        } catch {
            self.error = error
        }
    }
    
    func removeSavedBouquet(_ bouquet: Bouquet) async {
        do {
            guard let userId = try? await supabase.auth.session.user.id.uuidString else { return }
            
            try await supabase
                .from("saved_bouquets")
                .delete()
                .eq("user_id", value: userId)
                .eq("bouquet_id", value: bouquet.id)
                .execute()
            
            await loadSavedBouquets()
        } catch {
            self.error = error
        }
    }
    
    func isBouquetSaved(_ bouquet: Bouquet) async -> Bool {
        do {
            guard let userId = try? await supabase.auth.session.user.id.uuidString else { return false }
            
            let response: [SavedBouquetResponse] = try await supabase
                .from("saved_bouquets")
                .select("bouquet_id")
                .eq("user_id", value: userId)
                .eq("bouquet_id", value: bouquet.id)
                .execute()
                .value
            
            return !response.isEmpty
        } catch {
            return false
        }
    }
}

private struct SavedBouquetResponse: Codable {
    let bouquetId: String
    let bouquet: Bouquet?
    
    enum CodingKeys: String, CodingKey {
        case bouquetId = "bouquet_id"
        case bouquet
    }
}
