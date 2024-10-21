//
//  CustomCrousel.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-09-30.
//

import SwiftUI

struct CustomCrousel<Content: View>: View {
    var content: [Content]
   // @ViewBuilder var content: Content
    ///View Properties
    @State private var  scrollPosition: Int?
    var body: some View {
        GeometryReader{
            let size = $0.size
            ScrollView(.horizontal){
                HStack(spacing: 0){
                    ForEach(0..<content.count, id: \.self) { index in
                            content[index]
                            .frame(width: size.width, height: size.height)
                            .cornerRadius(15)
                            .id(index)
                    }
                }
               //.padding(.horizontal, 10)
            }
            .frame(height: size.height)
            .scrollTargetBehavior(.paging)
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    ContentView()
}
