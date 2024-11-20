//
//  ReminderManager.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-11-19.
//
import Foundation

@MainActor
class ReminderManager: ObservableObject {
    @Published private(set) var reminders: [Reminder] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private let supabase = supabaseClient
    
    func loadReminders() async {
        isLoading = true
        do {
            let response: [Reminder] = try await supabase
                .from("reminders")
                .select()
                .order("birth_date")
                .execute()
                .value
            
            self.reminders = response
            self.isLoading = false
        } catch {
            self.error = error
            self.isLoading = false
        }
    }
    
    func addReminder(_ name: String, subtitle: String, birthDate: Date) async {
        do {
            guard let userId = try? await supabase.auth.session.user.id.uuidString else { return }
            
            let reminderRequest = ReminderRequest(
                userId: userId,
                name: name,
                subtitle: subtitle,
                birthDate: ISO8601DateFormatter().string(from: birthDate),
                notificationSent: false
            )
            
            try await supabase
                .from("reminders")
                .insert(reminderRequest)
                .execute()
            
            await loadReminders()
        } catch {
            self.error = error
        }
    }
    
    func deleteReminder(_ reminder: Reminder) async {
        do {
            try await supabase
                .from("reminders")
                .delete()
                .eq("id", value: reminder.id)
                .execute()
            
            await loadReminders()
        } catch {
            self.error = error
        }
    }
}
