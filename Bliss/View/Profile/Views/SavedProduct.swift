//
//  SavedProduct.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-11-06.
//

import SwiftUI

struct SavedProduct: View {
    var body: some View {
        VStack {
            ProductRowView(product: Product.dummy)
            Spacer()
        }
        .padding(15)
    }
}

#Preview {
    SavedProduct()
}
