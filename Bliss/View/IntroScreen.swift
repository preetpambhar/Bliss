//
//  IntroScreen .swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-09-25.
//

import SwiftUI

struct IntroScreen: View {
    @AppStorage("isFirstTime") private var isfirsttime : Bool = true
    var body: some View {
        VStack{
            Text("What's New in the \n Bliss ")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding(.top, 65)
                .padding(.bottom, 35)
            
            
            //Points View
            VStack (alignment: .leading, spacing: 2, content: {
                PointView(symbol: "gift", title: "Gift", subtitle: "Surprice your loved onces with fragrence .")
                
                PointView(symbol: "cart", title: "Shopping", subtitle: "Order fresh boutique.")
                
                PointView(symbol: "rectangle.and.text.magnifyingglass", title: "Advance AI Suggestions", subtitle: "Find the Better suit product by inegrated AI assistent.")
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 15)
            
            Spacer(minLength: 10)
            Button(action: {
                isfirsttime = false
            }, label: {
                Text("Continue")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,14)
                    .background(appTint.gradient, in: .rect(cornerRadius: 12))
                    .contentShape(.rect)
            })
        }
        .padding(15)
    }
    
    
    
    @ViewBuilder
    func PointView(symbol: String, title: String, subtitle: String) -> some View {
        HStack(spacing: 20) {
            Image(systemName: symbol)
                .font(.largeTitle)
                .foregroundStyle(appTint.gradient)
                .frame(width: 45)
            
            VStack(alignment: .leading, spacing: 6, content: {
                
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(subtitle)
                    .foregroundStyle(.gray)
            })
        }
    }
}

#Preview {
    IntroScreen()
}
