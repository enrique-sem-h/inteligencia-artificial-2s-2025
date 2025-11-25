//
//  NewsViewModel.swift
//  Project_Hercules
//
//  Created by ChustrupFx on 25/11/25.
//

import SwiftUI


@Observable class NewsViewModel {
    
    let newsService = NewsService()
    
    var news: [News] = []
    
    public func fetchNews() -> Void {
        news = [
            News(id: "asdasd", headline: "asdasd", description: "asdawd", date: Date.now),
            News(id: "2", headline: "asdasd", description: "asdawd", date: Date.now),
            News(id: "3", headline: "asdasd", description: "asdawd", date: Date.now),
            News(id: "4", headline: "asdasd", description: "asdawd", date: Date.now)
        ]
        
    }
    
    public func classifyNews(news: [News]) -> Void {
        
    }
    
}
