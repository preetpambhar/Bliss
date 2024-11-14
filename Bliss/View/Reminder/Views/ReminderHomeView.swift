//
//  ReminderHomeView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-11-14.
//

import SwiftUI

struct ReminderHomeView: View {
    @State private var reminders: [Reminder] = [] // Array to store reminders
    @State private var isAddingReminder = false   // State to control Add Reminder screen
    
    var body: some View {
        NavigationStack {
            VStack {
                // List of reminders
                List(reminders) { reminder in
                    VStack(alignment: .leading) {
                        Text(reminder.name)
                            .font(.headline)
                        Text(reminder.subtitle)
                            .font(.subheadline)
                        Text("Birthday: \(reminder.birthDate, style: .date)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                // Button to add a new reminder
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
            .navigationTitle("Reminders")
            .sheet(isPresented: $isAddingReminder) {
                ReminderView(reminders: $reminders, isPresented: $isAddingReminder)  // Display ReminderView when adding a new reminder
            }
        }
    }
}

#Preview {
    ReminderHomeView()
}
