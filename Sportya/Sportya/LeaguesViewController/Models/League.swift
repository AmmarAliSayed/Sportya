//
//  League.swift
//  SportsApp
//
//  Created by Macbook on 25/03/2021.
//

import Foundation


struct leagueInfo : Codable{
    var leagues : [AllLeagueInfo]
}

struct AllLeagueInfo : Codable{
    var leagueImg :String
    var leagueYoutubeUrl :String
    var leagueId: String
    var leagueName :String
    var leagueSportType :String


    enum CodingKeys: String, CodingKey {
        case leagueImg = "strBadge"
        case leagueYoutubeUrl = "strYoutube"
        case leagueId = "idLeague"
        case leagueName = "strLeague"
        case leagueSportType = "strSport"
    }
}

struct AllLeagues: Codable {
    var leagues: [League]
}

struct League: Codable {
    var leagueId: String
    var leagueName :String
    var leagueSportType :String
    
    enum CodingKeys: String, CodingKey {
        case leagueId = "idLeague"
        case leagueName = "strLeague"
        case leagueSportType = "strSport"
    }
}


