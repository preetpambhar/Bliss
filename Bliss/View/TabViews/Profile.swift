//
//  Profile.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-09-27.
//

import SwiftUI

struct Profile: View {
    @State var isLoading = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text(supabaseClient.auth.currentSession?.user.email ?? "No email")
                }
            }
            .navigationTitle("Profile")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading){
                    Button("Sign out", role: .destructive) {
                        Task {
                            try? await supabaseClient.auth.signOut()
                        }
                    }
                }
            })
        }
    }
}

#Preview {
    Profile()
}
