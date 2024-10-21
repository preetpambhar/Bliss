//
//  AuthView.swift
//  Bliss
//
//  Created by Anirudh Atodaria on 2024-10-07.
//

import SwiftUI
import Supabase

struct AuthView: View {
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var isLoading = false
    @State var result: Result<Void, Error>?
    @State var isSignInMode = true

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Email")) {
                    TextField("Enter your email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }

                Section(header: Text("Password")) {
                    SecureField("Enter your password", text: $password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)

                    if !isSignInMode {
                        SecureField("Confirm your password", text: $confirmPassword)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                }

                Section {
                    Button(action: signInButtonTapped) {
                        HStack {
                            Spacer()
                            Text(isSignInMode ? "Sign In" : "Sign Up")
                                .fontWeight(.bold)
                            Spacer()
                        }
                    }
                    .disabled(isLoading)
                }

                if isLoading {
                    Section {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    }
                }

                if let result = result {
                    Section {
                        switch result {
                        case .success:
                            Text("Success!")
                                .foregroundColor(.green)
                        case .failure(let error):
                            Text("Error: \(error.localizedDescription)")
                                .foregroundColor(.red)
                        }
                    }
                }

                Section {
                    Button(action: {
                        isSignInMode.toggle()
                    }) {
                        HStack {
                            Spacer()
                            Text(isSignInMode ? "Don't have an account? Sign Up" : "Already have an account? Sign In")
                                .foregroundColor(.blue)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle(isSignInMode ? "Sign In" : "Sign Up")
        }
    }

    func signInButtonTapped() {
        Task {
            isLoading = true
            defer { isLoading = false }

            // Input Validation
            guard !email.isEmpty, !password.isEmpty else {
                result = .failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Email and password cannot be empty."]))
                return
            }

            if !isSignInMode {
                guard password == confirmPassword else {
                    result = .failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Passwords do not match."]))
                    return
                }
            }

            do {
                if isSignInMode {
                    // Sign In
                    _ = try await supabaseClient.auth.signIn(email: email, password: password)
                } else {
                    // Sign Up
                    _ = try await supabaseClient.auth.signUp(email: email, password: password)
                }
                result = .success(())
            } catch {
                result = .failure(error)
            }
        }
    }
}
