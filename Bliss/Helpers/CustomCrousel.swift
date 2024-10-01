//
//  CustomCrousel.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-09-30.
//

import SwiftUI

struct CustomCrousel<Content: View>: View {
    @ViewBuilder var content: Content
    ///View Properties
    @State private var  scrollPosition: Int?
    var body: some View {
        GeometryReader{
            let size = $0.size
            ScrollView(.horizontal){
                HStack(spacing: 0){
                    Groupc(subviews: content) { collection in
                        ForEach(collection.indices, id: \.self){item in
                            
                        }
                    }c
                }
            }
            .scrollTargetBehavior(.paging)
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    ContentView()
}
