//
//  LocationSearchView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-02.
//

import SwiftUI

struct LocationSearchView: View {
    @State private var locationText = ""
    @Binding var showLoactionSearchView: Bool
    var body: some View {
        VStack{
            //header view
            HStack {
                TextField("Current Location", text: $locationText)
                    .padding(10)
                    .background(Color(.systemGray4))
                    .cornerRadius(8)
                    .frame(height: 35)

                // Cancel button
                Button(action: {
                    showLoactionSearchView.toggle()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .font(.system(size: 20))
                }
                .padding(.trailing, 8)
            }
            .padding(.leading)
            Divider()
                .padding(.vertical)
            
            //list view
            ScrollView{
                VStack(alignment: .leading){
                    ForEach(0 ..< 15, id: \.self) { _ in
                        LocationSearchResultCell()
                    }
                }
            }
        }
        .padding(.top, 64)
        .background(.white)
    }
}

#Preview {
    LocationSearchView(showLoactionSearchView: .constant(true))
}
