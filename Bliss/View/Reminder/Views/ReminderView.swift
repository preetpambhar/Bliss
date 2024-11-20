//
//  ReminderView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-11-14.
//

import SwiftUI

struct ReminderView: View {
    @ObservedObject var reminderManager: ReminderManager
    @Binding var isPresented: Bool
    
    @State private var name: String = ""
    @State private var subtitle: String = ""
    @State private var birthDate = Date()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Add a Reminder")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            TextField("Person's Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            TextField("Subtitle (e.g., Friend, Family)", text: $subtitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            DatePicker("Select Birth Date", selection: $birthDate, displayedComponents: .date)
                .padding(.horizontal)

            Button(action: {
                Task {
                    await reminderManager.addReminder(name, subtitle: subtitle, birthDate: birthDate)
                    isPresented = false
                }
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
    ReminderView(reminderManager: ReminderManager(), isPresented: .constant(true))
}
