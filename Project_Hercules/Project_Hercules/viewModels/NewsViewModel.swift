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
    
    public func fetchNews(ticker: String) -> Void {
        newsService.ticker = ticker
        news = newsService.getNews()
        news = classifyNews(news: news)
    }
    
    private func classifyNews(news: [News]) -> [News] {
        guard let model = try? projetoHercules(configuration: .init()) else { return [] }
        
        do {
            let classifiedNews: [News] = try news.map { news in
                var mutableNews = news
                let output = try model.prediction(text: mutableNews.headline)
                
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
