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
        Button {
            viewModel.fetchNews()
        } label: {
            Text("Clique")
        }
        
        ForEach(viewModel.news, id: \.id) { new in
            Text(new.headline)
        }
        
        

    }
}

#Preview {
    Home()
}
