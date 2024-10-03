//
//  LocationSearchActivation.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-02.
//

import SwiftUI

struct LocationSearchActivation: View {
    var body: some View {
        HStack{
            Rectangle()
                .fill(Color.black)
                .frame(width: 8, height: 8)
                .padding(.horizontal)
            Text("Search delivery address")
                .foregroundColor(Color(.darkGray))
            
            Spacer()
            

        }
        .frame(width: UIScreen.main.bounds.width - 20, height: 50)
        .background(
            Rectangle()
                .fill(Color.white)
                .shadow(color: .black, radius: 6)
        )
    }
}

#Preview {
    LocationSearchActivation()
}
