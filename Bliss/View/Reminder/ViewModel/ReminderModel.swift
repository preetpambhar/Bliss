//
//  ReminderModel.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-11-14.
//

import Foundation

struct Reminder: Identifiable {
    let id = UUID()
    let name: String
    let subtitle: String
    let birthDate: Date
    
}

