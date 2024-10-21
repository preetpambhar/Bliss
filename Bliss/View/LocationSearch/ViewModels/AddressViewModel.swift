//
//  AddressViewModel.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-05.
//

import SwiftUI

struct Address: Identifiable {
    let id = UUID()  // Unique identifier
    var province: String
    var city: String
    var address: String
    var appNo: String
    var floor: String
    var message: String
}

class AddressViewModel: ObservableObject {
    // Observable array to store the addresses
    @Published var savedAddresses: [Address] = []
    
    // Temporary variables to hold current input
    @Published var province: String = "" 
    @Published var city: String = ""
    @Published var address: String = ""
    @Published var appNo: String = ""
    @Published var floor: String = ""
    @Published var message: String = ""
    
    // Function to save the current address to the array
    func saveCurrentAddress() {
        let newAddress = Address(province: province, city: city, address: address, appNo: appNo, floor: floor, message: message)
        savedAddresses.append(newAddress)
        print("Address saved: \(newAddress)")
        
        // Optionally clear the fields after saving
        clearFields()
    }
    
    // Function to clear the input fields
    private func clearFields() {
        province = ""
        city = ""
        address = ""
        appNo = ""
        floor = ""
        message = ""
    }
}
