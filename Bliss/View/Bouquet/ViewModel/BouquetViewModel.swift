//
//  BouquetViewModel.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-04.
//

import Foundation
import Supabase

class BouquetViewModel: ObservableObject {
    private let queries: Queries
    @Published var bouquets: [Bouquet] = []
    @Published var error: Error?
    @Published var isLoading = false
    
    init(client: SupabaseClient) {
        self.queries = Queries(client: client)
    }
    
    @MainActor
    func loadBouquets() {
        isLoading = true
        Task {
            do {
                bouquets = try await queries.fetchBouquets()
            } catch {
                self.error = error
            }
            isLoading = false
        }
    }
}
