//
//  NewsService.swift
//  Project_Hercules
//
//  Created by ChustrupFx on 25/11/25.
//
import Foundation

class NewsService {
    
    private var API_KEY = Bundle.main.object(forInfoDictionaryKey: "API_KEY")
    private let url = URL(string: "https://api.massive.com/v2/reference")
    var ticker = "AMZN"
    
    public func getNews() -> [News] {
        guard let API_KEY else { return [] }
        guard let url else { return [] }
        var news = [News]()
        
        var urlRequest = URLRequest(url: url.appending(component: "/news?ticker=\(ticker)&order=desc&limit=10&sort=published_utc"))
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(API_KEY)"]
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                print(error.localizedDescription)
            }
            
            if let res = response as? HTTPURLResponse {
                if res.statusCode != 200 {
                    print("Error: Status Code is \(res.statusCode)")
                }
            }
            
            if let data {
                do {
                    let decoder = JSONDecoder()
                    news = try decoder.decode([News].self, from: data)
                } catch {
                    fatalError("Error while parsing data")
                }
            }
        }.resume()
        
        return news
    }
    
}
