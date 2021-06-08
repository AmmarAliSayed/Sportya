//
//  FavoriteLeague.swift
//  SportsApp
//
//  Created by Macbook on 28/03/2021.
//

import Foundation

//struct FavoriteLeagueModel  {
//    var favoriteLeagueId : String
//    var favoriteLeagueImg:String
//    var favoriteLeagueName :String
//    var  favoriteLeagueYoutubeUrl :String
//}

struct FavoriteleagueInfo : Codable{
    var leagues : [AllFavoriteLeagueInfo]
}

struct AllFavoriteLeagueInfo : Codable{
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
