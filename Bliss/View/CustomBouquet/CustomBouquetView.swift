//
//  CustomBouquetView.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-26.
//
import SwiftUI

struct CustomBouquetView: View {
    @StateObject private var viewModel = CustomBouquetViewModel()
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var cartManager: CartManager
    @State private var navigateToCart = false
    
    let existingBouquet: Bouquet?
    
    @State private var bouquetName = ""
    @State private var bouquetDescription = ""
    @State private var selectedFlowers: [String: Int] = [:]
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var showingSuccessToast = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    BouquetDetailsSection(
                        bouquetName: $bouquetName,
                        bouquetDescription: $bouquetDescription
                    )
                    
                    SelectedFlowersSection(
                        flowers: viewModel.selectedFlowerDetails,
                        selectedFlowers: selectedFlowers,
                        onIncrease: incrementFlower,
                        onDecrease: decrementFlower
                    )
                    
                    AvailableFlowersSection(
                        flowers: viewModel.availableFlowers,
                        selectedFlowers: selectedFlowers,
                        onTap: toggleFlower
                    )
                }
            }
            .navigationTitle(existingBouquet == nil ? "Create Bouquet" : "Customize Bouquet")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveCustomBouquet()
                    }
                    .disabled(!isValidBouquet)
                }
            }
            .overlay {
                if showingSuccessToast {
                    VStack {
                        Text("Added to cart!")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                            .transition(.move(edge: .top))
                    }
                    .animation(.spring(), value: showingSuccessToast)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top)
                }
            }
            .task {
                await viewModel.loadFlowers()
                if let bouquet = existingBouquet {
                    await loadExistingBouquet(bouquet)
                }
            }
            .alert("Error", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
        .navigationDestination(isPresented: $navigateToCart) {
            CartView()
                .navigationBarBackButtonHidden(true)
        }
    }
    
    private var isValidBouquet: Bool {
        !bouquetName.isEmpty && !selectedFlowers.isEmpty
    }
    
    private func toggleFlower(_ flower: Flower) {
        if selectedFlowers[flower.id] != nil {
            selectedFlowers.removeValue(forKey: flower.id)
            viewModel.selectedFlowerDetails.removeAll { $0.id == flower.id }
        } else {
            selectedFlowers[flower.id] = 1
            viewModel.selectedFlowerDetails.append(flower)
        }
    }
    
    private func incrementFlower(_ flower: Flower) {
        selectedFlowers[flower.id, default: 0] += 1
    }
    
    private func decrementFlower(_ flower: Flower) {
        guard let quantity = selectedFlowers[flower.id], quantity > 0 else { return }
        if quantity == 1 {
            selectedFlowers.removeValue(forKey: flower.id)
            viewModel.selectedFlowerDetails.removeAll { $0.id == flower.id }
        } else {
            selectedFlowers[flower.id] = quantity - 1
        }
    }
    
    private func loadExistingBouquet(_ bouquet: Bouquet) async {
        // First load the bouquet details
        bouquetName = "\(bouquet.name) (Custom)"
        bouquetDescription = bouquet.description ?? ""
        
        // Load flowers first
        await viewModel.loadFlowers()
        
        // Then load bouquet flowers
        await viewModel.loadBouquetFlowers(bouquetId: bouquet.id)
        
        // Update selected flowers
        selectedFlowers = Dictionary(uniqueKeysWithValues: viewModel.bouquetFlowers.map { ($0.flowerId, $0.quantity) })
        
        // Debug prints
        print("Loaded bouquet name: \(bouquetName)")
        print("Selected flowers count: \(selectedFlowers.count)")
        print("Selected flower details count: \(viewModel.selectedFlowerDetails.count)")
    }
    
    private func saveCustomBouquet() {
        Task {
            do {
                let bouquet = try await viewModel.saveCustomBouquet(
                    name: bouquetName,
                    description: bouquetDescription,
                    flowers: selectedFlowers
                )
                await cartManager.addToCart(bouquet: bouquet)
                showingSuccessToast = true
                // Delay dismissal to show the toast
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    dismiss()
                }
            } catch {
                alertMessage = error.localizedDescription
                showingAlert = true
            }
        }
    }
}
