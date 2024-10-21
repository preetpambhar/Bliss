//
//  Double+Extention.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-11.
//

import Foundation

extension Double{
    func toString() -> String{
        return String(format: "%.1f",self)
    }
    func currencyFormat() -> String{
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
