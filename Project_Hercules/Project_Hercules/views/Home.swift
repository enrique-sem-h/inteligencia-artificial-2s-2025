//
//  Home.swift
//  Project_Hercules
//
//  Created by ChustrupFx on 25/11/25.
//

import SwiftUI

struct Home: View {
    @State var viewModel = NewsViewModel()
    
    var body: some View {
        ScrollView {
            SearchView(viewModel: $viewModel)
            if !viewModel.news.isEmpty {
                
            }
        }.disabled(viewModel.news.isEmpty)
    }
}

#Preview {
    Home()
}
