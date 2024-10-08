//
//  LocationSearchView.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-10-02.
//

import SwiftUI

struct LocationSearchView: View {
    //@State private var locationText = ""
    @Binding var locationSearchView: Bool
    @Binding var showLoactionSearchView: Bool
    @State private var mapState = MapViewState.noInput
    @EnvironmentObject var viewModel : LocationSearchViewModel
    var body: some View {
        VStack{
            //header view
            HStack {
                TextField("Enter Location", text: $viewModel.queryFragment)
                    .padding(10)
                    .background(Color(.systemGray4))
                    .cornerRadius(8)
                    .frame(height: 35)

                // Cancel button
                Button{
                    withAnimation(.spring()){
                        showLoactionSearchView.toggle()
                    }
                } label: {
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
            if !viewModel.results.isEmpty {
                ScrollView{
                    VStack(alignment: .leading){
                        ForEach(viewModel.results, id: \.self) { result in
                            LocationSearchResultCell(title: result.title, subtitle: result.subtitle)
                                .onTapGesture {
                                    viewModel.selectedLocation(result)
                                    showLoactionSearchView.toggle()
                                }
                        }
                    }
                }
            }
        }
        .padding(.top, 5)
        .background(.white)
    }
}

#Preview {
    LocationSearchView(locationSearchView: .constant(false), showLoactionSearchView: .constant(true))
}
