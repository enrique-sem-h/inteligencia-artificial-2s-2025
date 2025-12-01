//
//  NewsService.swift
//  Project_Hercules
//
//  Created by ChustrupFx on 25/11/25.
//
import Foundation

class NewsService {
    
    private var API_KEY: String? = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    private let url = URL(string: "https://api.massive.com/v2/reference/news?")
    var ticker = "AMZN"
    
    public func getNews() async -> [News] {
        guard let API_KEY else { return [] }
        guard let url else { return [] }
        var news = [News]()
        
        let bearer = "Bearer \(API_KEY)"
        let searchItem = URLQueryItem(name: "ticker", value: ticker)
        let order = URLQueryItem(name: "order", value: "desc")
        let limit = URLQueryItem(name: "limit", value: "10")
        let sort = URLQueryItem(name: "sort", value: "published_utc")
                
        
        var urlRequest = URLRequest(url: url.appending(queryItems: [searchItem, order, limit, sort]))
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(bearer, forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            if let res = response as? HTTPURLResponse {
                if res.statusCode != 200 {
                    print("Error: Status Code is \(res.statusCode)")
                }
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let dataResponse = try decoder.decode(NewsResponseWrapper.self, from: data)
            news = dataResponse.results
        } catch {
            fatalError("Error while parsing data \(error)")
        }
        
        return news
    }
    
}
