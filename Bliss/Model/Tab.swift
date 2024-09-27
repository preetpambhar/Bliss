//
//  Tab.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-09-27.
//

import SwiftUI

enum Tab: String{
    case home = "Home"
    case flowers =  "Flowers"
    case cart = "Cart"
    case profile = "Profile"
    
    @ViewBuilder
    var tabContent: some View{
        switch self {
        case .home:
            Image(systemName: "house")
            Text(self.rawValue)
        case .flowers:
            Image(systemName: "leaf")
            Text(self.rawValue)
        case .cart:
            Image(systemName: "cart")
            Text(self.rawValue)
        case .profile:
            Image(systemName: "person")
            Text(self.rawValue)
        }
    }
}

