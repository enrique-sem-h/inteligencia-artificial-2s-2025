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
    
    public func fetchNews(text: String) -> Void {
        
        if (text.count > 4) {
            
            Task {
                let newNew = News(id: "FUCK", headline: text, description: text, date: .now)
            
                news = classifyNews(news: [newNew])
            }
                      
            
        } else {
            newsService.ticker = text
            Task {
                news = await newsService.getNews()
                news = classifyNews(news: news)
            }
        }
        
        
    
    }
    
    private func classifyNews(news: [News]) -> [News] {
        guard let model = try? projetoHerculesV2(configuration: .init()) else { return [] }
      
        do {
            let classifiedNews: [News] = try news.map { news in
                var mutableNews = news
                print(mutableNews)
                let output = try model.prediction(text: mutableNews.description)
                
                switch output.label {
                case "positive":
                    mutableNews.feeling = Feeling(feeling: .Positive, percentage: 100)
                case "negative":
                    mutableNews.feeling = Feeling(feeling: .Negative, percentage: 100)
                default:
                    mutableNews.feeling = Feeling(feeling: .Neutral, percentage: 100)
                }
                
                return mutableNews
            }
            return classifiedNews
        } catch {
            fatalError("Coudn't predict news headlines")
        }
    }
    
}
