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
            Group {
                if reminderManager.isLoading {
                    ProgressView()
                } else {
                    VStack {
                        List {
                            ForEach(reminderManager.reminders) { reminder in
                                ReminderRow(reminder: reminder, reminderManager: reminderManager)
                            }
                        }
                        
                        Button(action: {
                            isAddingReminder = true
                        }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
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
                Image(systemName: "trash")
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
