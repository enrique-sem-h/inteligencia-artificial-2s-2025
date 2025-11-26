//
//  SearchView.swift
//  Project_Hercules
//
//  Created by Enrique Carvalho on 26/11/25.
//
import SwiftUI

struct SearchView: View {
    @State var searchText: String = ""
    @Binding var viewModel: NewsViewModel
    
    var body: some View {
        HStack {
            TextField("Insert a ticker", text: $searchText)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(lineWidth: 2)
                }
                .padding()
                .frame(maxWidth: 1000)
            Button {
                viewModel.fetchNews(ticker: searchText)
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 30))
                    .bold()
                    .tint(Color.black)
            }
        }
    }
}

#Preview {
    SearchView(viewModel: .constant(NewsViewModel()))
}
