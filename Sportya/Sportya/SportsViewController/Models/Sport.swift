//
//  Sports.swift
//  SportsApp
//
//  Created by Mahmoud Morsy on 24/03/2021.
//

import Foundation

struct Sport: Codable {
    let sports: [AllSports]
}

struct AllSports: Codable {
    let id: String
    let sportName: String
    let sportFormat: String
    let sportImage: String
    
    
    enum CodingKeys: String, CodingKey {
        case id = "idSport"
        case sportName = "strSport"
        case sportFormat = "strFormat"
        case sportImage = "strSportThumb"
    }
}
