//
//  Reminder.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-19.
//
import Foundation

struct Reminder: Identifiable, Codable {
    let id: String
    let userId: String
    let name: String
    let subtitle: String
    let birthDate: String
    var notificationSent: Bool
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case name
        case subtitle
        case birthDate = "birth_date"
        case notificationSent = "notification_sent"
        case createdAt = "created_at"
    }
}

struct ReminderRequest: Encodable {
    let userId: String
    let name: String
    let subtitle: String
    let birthDate: String
    let notificationSent: Bool
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name
        case subtitle
        case birthDate = "birth_date"
        case notificationSent = "notification_sent"
    }
}
