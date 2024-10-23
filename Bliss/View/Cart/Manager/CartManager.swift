//
//  cartManager.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-22.
//
import Foundation

class CartManager: ObservableObject{
    @Published private(set)var products: [Product] = []
    @Published private(set)var total:Double = 0
    
    let paymentHandler = PaymentHandler()
    @Published var paymentSuccess = false
    
    func addToCart(product: Product){
        products.append(product)
        total += product.price
    }
    
    func removeFromCart(product: Product){
        products = products.filter{ $0.id != product.id}
        total -= product.price
    }
    
    func pay(){
        paymentHandler.startPayment(products: products, total: total) { success in
            self.paymentSuccess = success
            self.products = []
            self.total = 0
        }
    }
}
