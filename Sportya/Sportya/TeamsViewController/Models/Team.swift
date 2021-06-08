//
//  Team.swift
//  SportsApp
//
//  Created by Mahmoud Morsy on 28/03/2021.
//

import Foundation

struct Teams: Codable {
    var teams: [Team]?
}

struct Team: Codable {
    let teamId: String?
    let teamName: String?
    let birthYear: String?
    var league: String?
    var stadiumName: String?
    var stadiumImgURL: String?
    var website: String?
    var facebook: String?
    var twitter: String?
    var instagram: String?
    var description: String?
    var country: String?
    var imgURL: String?
    var eventImgUrl: String?
    var teamBanner: String?
    
    enum CodingKeys: String, CodingKey {
        case teamId = "idTeam"
        case teamName = "strTeam"
        case birthYear = "intFormedYear"
        case league = "strLeague"
        case stadiumName = "strStadium"
        case stadiumImgURL = "strStadiumThumb"
        case website = "strWebsite"
        case facebook = "strFacebook"
        case twitter = "strTwitter"
        case instagram = "strInstagram"
        case description = "strDescriptionEN"
        case country = "strCountry"
        case imgURL = "strTeamBadge"
        case teamBanner = "strTeamFanart1"
    }
}
