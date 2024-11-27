//
//  CartView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-11.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var animateTruck = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                if cartManager.isLoading {
                    LoadingView()
                } else if cartManager.paymentSuccess {
                    OrderSuccessView(animateTruck: $animateTruck)
                } else if cartManager.cartItems.isEmpty {
                    EmptyCartView()
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            // Cart Items
                            VStack(spacing: 12) {
                                ForEach(cartManager.cartItems) { item in
                                    CartRowView(item: item)
                                }
                            }
                            .padding(.horizontal)
                            
                            // Order Summary
                            OrderSummaryCard(total: cartManager.total)
                                .padding(.horizontal)
                            
                            // Checkout Button
                            CheckoutButton(action: cartManager.pay)
                                .padding(.horizontal)
                                .padding(.top, 10)
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Cart")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $cartManager.shouldNavigateToOrders) {
                OrdersView()
                    .navigationBarBackButtonHidden(true)
            }
            .alert("Error", isPresented: .constant(cartManager.error != nil)) {
                Button("OK") { cartManager.error = nil }
            } message: {
                Text(cartManager.error?.localizedDescription ?? "")
            }
        }
    }
}

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 20) {
            ProgressView()
            Text("Loading your cart...")
                .foregroundColor(.secondary)
        }
    }
}

struct EmptyCartView: View {
    var body: some View {
        VStack(spacing: 24) {
            SwiftUI.Image(systemName: "cart")
                .font(.system(size: 64))
                .foregroundColor(.gray.opacity(0.7))
            
            Text("Your cart is empty")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Add some beautiful flowers or bouquets to get started")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            NavigationLink(destination: Home(selectedLocationTitle: "")) {
                Text("Browse Bouquets")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
                    .padding(.horizontal, 40)
            }
        }
        .padding()
    }
}

struct OrderSuccessView: View {
    @Binding var animateTruck: Bool
    
    var body: some View {
        VStack(spacing: 32) {
            SwiftUI.Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.green)
            
            VStack(spacing: 16) {
                Text("Thank you for your order!")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Your beautiful flowers will be delivered soon")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            DeliveryTruckAnimation(animate: $animateTruck)
                .padding(.top, 20)
        }
        .padding()
    }
}

struct DeliveryTruckAnimation: View {
    @Binding var animate: Bool
    
    var body: some View {
        SwiftUI.Image(systemName: "box.truck.fill")
            .font(.system(size: 48))
            .foregroundColor(.blue)
            .rotationEffect(.degrees(animate ? 5 : -5))
            .offset(x: animate ? 10 : -10)
            .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animate)
            .onAppear { animate = true }
    }
}

struct OrderSummaryCard: View {
    let total: Double
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Order Summary")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            HStack {
                Text("Subtotal")
                    .foregroundColor(.secondary)
                Spacer()
                Text("$\(total, specifier: "%.2f")")
                    .fontWeight(.medium)
            }
            
            HStack {
                Text("Delivery")
                    .foregroundColor(.secondary)
                Spacer()
                Text("Free")
                    .fontWeight(.medium)
                    .foregroundColor(.green)
            }
            
            Divider()
            
            HStack {
                Text("Total")
                    .font(.headline)
                Spacer()
                Text("$\(total, specifier: "%.2f")")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct CheckoutButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text("Proceed to Checkout")
                    .font(.headline)
                SwiftUI.Image(systemName: "arrow.right")
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(16)
        }
    }
}

#Preview {
    CartView()
        .environmentObject(CartManager())
}
