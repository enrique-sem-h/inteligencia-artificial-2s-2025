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
    
    @State private var isLoading = false

    var body: some View {
        HStack(spacing: 12) {
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white.opacity(0.6))
                
                TextField("Insert a ticker", text: $searchText)
                    .foregroundStyle(.white)
                    .autocapitalization(.allCharacters)
            }
            .padding()
            .background(.white.opacity(0.1))
            .cornerRadius(14)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(.white.opacity(0.2), lineWidth: 1)
            )
            
            Button(action: search) {
                if isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.system(size: 35))
                        .foregroundStyle(.black)
                        .symbolEffect(.bounce, value: isLoading)
                }
            }
        }
    }

    func search() {
        guard !searchText.isEmpty else { return }
        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            viewModel.fetchNews(ticker: searchText)
            isLoading = false
        }
    }
}


#Preview {
    SearchView(viewModel: .constant(NewsViewModel()))
}
