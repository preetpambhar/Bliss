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
//            Rectangle()
//                .fill(Color.black)
            Image(systemName: "magnifyingglass")
                .frame(width: 8, height: 8)
                .padding(.horizontal)
                .foregroundColor(Color(.darkGray))
            Text("Search delivery address")
                .foregroundColor(Color(.darkGray))
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 20, height: 50)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: .black, radius: 5)
        )
    }
}

#Preview {
    LocationSearchActivation()
}
