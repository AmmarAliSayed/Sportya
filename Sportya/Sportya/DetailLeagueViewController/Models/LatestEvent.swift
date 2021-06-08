//
//  LatestEvent.swift
//  SportsApp
//
//  Created by Mahmoud Morsy on 28/03/2021.
//

import Foundation

struct LatestEvents: Codable {
    var events: [Latest]?
    
}

struct Latest:Codable {
    
    let homeTeam: String?
    let awayTeam: String?
    let scoreHomeTeam: String?
    let scoreAwayTeam: String?
    let dateEvent: String?
    let time: String?
    let homeTeamId: String?
    let awayTeamId: String?
    let eventImgURL: String?
    
    enum CodingKeys: String, CodingKey {
        case homeTeam = "strHomeTeam"
        case awayTeam = "strAwayTeam"
        case scoreHomeTeam = "intHomeScore"
        case scoreAwayTeam = "intAwayScore"
        case dateEvent = "dateEvent"
        case time = "strTimeLocal"
        case homeTeamId = "idHomeTeam"
        case awayTeamId = "idAwayTeam"
        case eventImgURL = "strThumb"
    }
}
