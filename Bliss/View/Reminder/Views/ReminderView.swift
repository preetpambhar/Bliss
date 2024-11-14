//
//  ReminderView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-11-14.
//

import SwiftUI

struct ReminderView: View {
    @Binding var reminders: [Reminder]         // Binding to the reminders array in ReminderHomeView
    @Binding var isPresented: Bool
    
    @State private var name: String = ""
    @State private var subtitle: String = ""
    @State private var birthDate = Date()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Add a Reminder")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Input fields
            TextField("Person's Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            TextField("Subtitle (e.g., Friend, Family)", text: $subtitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            // Date picker for birth date
            DatePicker("Select Birth Date", selection: $birthDate, displayedComponents: .date)
                .padding(.horizontal)

            // Set Reminder button
            Button(action: {
                // Logic to save the reminder
                let newReminder = Reminder(name: name, subtitle: subtitle, birthDate: birthDate)
                reminders.append(newReminder)   // Add the new reminder to the list
                isPresented = false
            }) {
                Text("Set Reminder")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.blue)
                    )
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ReminderView(reminders: .constant([]), isPresented: .constant(true))
}
