//
//  AIChatBotView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-30.
//

import SwiftUI
import GoogleGenerativeAI

struct AIChatBotView: View {
    let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
    
    @State var userPrompt = ""
    @State var response: LocalizedStringKey = "How can i help you today?"
    @State var loding = false
    var body: some View {
        VStack {
        Text("Welcome To Bliss AI Bot")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.indigo)
                .padding(.top, 40)
            
            ZStack{
                ScrollView{
                    Text(response)
                        .font(.title)
                }
                if loding{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .indigo))
                        .scaleEffect(2)
                    
                }
            }
            HStack {
                TextField("Ask anything...", text: $userPrompt, axis: .vertical)
                    .lineLimit(5)
                    .font(.title)
                    .padding()
                    .background(Color.indigo.opacity(0.2), in: Capsule())
                    .disableAutocorrection(true)
                    .onSubmit {
                        generateResponse()
                    }
                
                
                Button(action: {
                    generateResponse()
                }) {
                    SwiftUI.Image(systemName: "paperplane.fill")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.indigo, in: Circle())
                }
                .padding(.trailing, 5)
                .disabled(userPrompt.isEmpty)
            }
                    }
        
        .padding()
    }
    func generateResponse(){
        loding = true
        response = ""
        
        Task {
            do {
                let result = try await model.generateContent(userPrompt)
                loding = false
                response = LocalizedStringKey(result.text ?? "No Response Found")
                userPrompt = ""
            }catch {
                response = "Something Went Wrong\n\(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    AIChatBotView()
}

