//
//  News.swift
//  Project_Hercules
//
//  Created by ChustrupFx on 25/11/25.
//

import Foundation

enum FeelingEnum {
    case Positive
    case Neutral
    case Negative
}

struct Feeling {
    var feeling: FeelingEnum
    var percentage: Float
}

struct News: Identifiable {
    var id: String
    var headline: String;
    var description: String;
    var date: Date
    var feeling: Feeling?;
}
