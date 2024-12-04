//
//  ImageSearchViewModel.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-27.
//

import SwiftUI

class ImageSearchViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var searchResults: [SearchResult] = []
    @Published var isLoading = false
    @Published var hasSearched = false
    @Published var showError = false
    @Published var errorMessage = ""
    
    private let apiService = APIService()
    
    func performSearch(type: SearchType) async {
        guard let image = selectedImage else { return }
        
        await MainActor.run { isLoading = true }
        
        do {
            let results = try await apiService.searchSimilar(
                image: image,
                searchType: type
            )
            
            await MainActor.run {
                self.searchResults = results
                self.hasSearched = true
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.showError = true
                self.isLoading = false
            }
        }
    }
}
