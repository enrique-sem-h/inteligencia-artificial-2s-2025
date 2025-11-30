//
//  News.swift
//  Project_Hercules
//
//  Created by ChustrupFx on 25/11/25.
//

import Foundation

enum FeelingEnum: String {
    case Positive
    case Neutral
    case Negative
}

struct Feeling {
    var feeling: FeelingEnum
    var percentage: Float
}

struct News: Identifiable, Decodable {
    var id: String
    var headline: String
    var description: String
    var date: Date
    var feeling: Feeling?
    
    enum CodingKeys: String, CodingKey {
        case headline = "title"
        case date = "published_utc"
        
        case id
        case description
    }
    
}
