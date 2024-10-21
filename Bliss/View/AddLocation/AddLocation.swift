//
//  AddLocation.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-03.
//

import SwiftUI

struct AddLocation: View {
    var body: some View {
        VStack (){
            MapViewRepresentable()
                //.ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.width , height: 300)
            Spacer()
        }
        .padding(.top, 10)
        .frame(alignment: .top)
    }
}

#Preview {
    AddLocation()
}
