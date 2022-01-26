//
//  Guide.swift
//  ChallengeApp
//
//  Created by Daven Morris on 1/25/22.
//

import Foundation

struct Guide: Codable {
    let data: [GuideInfo]
}

struct GuideInfo: Codable {
    let startDate, endDate, name, url: String
    let objType: String
    let icon: String
}

class GuideSection {
    let date: String
    var data: [GuideInfo]
    
    init(date: String, data: [GuideInfo]) {
        self.date = date
        self.data = data
    }
}
