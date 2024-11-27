//
//  ReminderHomeView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-11-14.
//

import SwiftUI

struct ReminderHomeView: View {
    @StateObject private var reminderManager = ReminderManager()
    @State private var isAddingReminder = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if reminderManager.isLoading {
                    ProgressView()
                } else {
                    VStack {
                        if reminderManager.reminders.isEmpty {
                            EmptyReminderView()
                        } else {
                            List(reminderManager.reminders) { reminder in
                                ReminderRow(reminder: reminder, reminderManager: reminderManager)
                            }
                        }
                        
                        AddReminderButton(isAddingReminder: $isAddingReminder)
                    }
                }
            }
            .navigationTitle("Reminders")
            .sheet(isPresented: $isAddingReminder) {
                ReminderView(reminderManager: reminderManager, isPresented: $isAddingReminder)
            }
            .alert("Error", isPresented: .constant(reminderManager.error != nil)) {
                Button("OK") { reminderManager.error = nil }
            } message: {
                Text(reminderManager.error?.localizedDescription ?? "")
            }
            .task {
                await reminderManager.loadReminders()
            }
        }
    }
}

// Empty state view
struct EmptyReminderView: View {
    var body: some View {
        VStack(spacing: 20) {
            SwiftUI.Image(systemName: "bell.badge")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No Reminders")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Add reminders for important dates")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

// Add reminder button
struct AddReminderButton: View {
    @Binding var isAddingReminder: Bool
    
    var body: some View {
        Button(action: {
            isAddingReminder = true
        }) {
            HStack {
                SwiftUI.Image(systemName: "plus.circle.fill")
                    .font(.title)
                Text("Add Reminder")
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
            .padding()
        }
    }
}

struct ReminderRow: View {
    let reminder: Reminder
    let reminderManager: ReminderManager
    @State private var showingDeleteAlert = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(reminder.name)
                    .font(.headline)
                Text(reminder.subtitle)
                    .font(.subheadline)
                Text("Birthday: \(formatDate(reminder.birthDate))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 4)
            
            Spacer()
            
            Button {
                showingDeleteAlert = true
            } label: {
                SwiftUI.Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .alert("Delete Reminder", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                Task {
                    await reminderManager.deleteReminder(reminder)
                }
            }
        } message: {
            Text("Are you sure you want to delete this reminder for \(reminder.name)?")
        }
    }
    
    private func formatDate(_ dateString: String) -> String {
        guard let date = ISO8601DateFormatter().date(from: dateString) else {
            return dateString
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    ReminderHomeView()
}
