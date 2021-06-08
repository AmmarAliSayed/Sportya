//
//  AllTeamsInLeagueViewModel.swift
//  SportsApp
//
//  Created by Mahmoud Morsy on 28/03/2021.
//

import Foundation

protocol AllTeamsInLeagueProtocol {
    init(league: AllLeagueInfo)
    func callAllTeamsInLeague(leagueId: String,completionHandler: @escaping (Bool)->Void)
    var getAllTeamsInLeagueData: ((AllTeamsInLeagueProtocol) -> Void)? {get}
    var teamDetailData: Teams? {get set}
    var selectedLeague: AllLeagueInfo? {get set}
    var twoTeams: [[Team]]? {get set}
}

class AllTeamsInLeagueViewModel: AllTeamsInLeagueProtocol {
    var twoTeams: [[Team]]?
    
    
    
    required init(league: AllLeagueInfo) {
        self.selectedLeague = league
    }
    
    let apiService = APIClient()
    
    func callAllTeamsInLeague(leagueId: String,completionHandler: @escaping (Bool)->Void) {
        completionHandler(false)
        apiService.fetchData(endPoint: "lookup_all_teams.php?id=\(leagueId)", responseClass: Teams.self) {[weak self] (response) in
            switch response {
            case .success(let allLeagueTeams):
                self?.teamDetailData = allLeagueTeams
            case .failure(let error):
                print(error)

            }
            completionHandler(true)
        }
    }
    
    var getAllTeamsInLeagueData: ((AllTeamsInLeagueProtocol) -> Void)?
    
    var teamDetailData: Teams? {
        didSet {
            getAllTeamsInLeagueData!(self)
        }
    }
    var selectedLeague: AllLeagueInfo?
    
    func getSelectedTeam(team: Team) -> TeamsViewModel {
        return TeamsViewModel(team: team)
    }
    
    func getTeamsForLatestMatches(teams: Teams, arrayOfEvents: LatestEvents) {
        guard teams.teams != nil , arrayOfEvents.events != nil else {
                return
            }
            twoTeams = []
            for item in arrayOfEvents.events! {
                guard let homeTeamId = item.homeTeamId , let awayTeamId = item.awayTeamId else {
                    return
                }
                guard (teams.teams?.filter({$0.teamId == homeTeamId}).count)! > 0 else {return}
                guard (teams.teams?.filter({$0.teamId == awayTeamId}).count)! > 0 else {return}
                guard let homeTeam = teams.teams?.filter({$0.teamId == homeTeamId})[0],
                      let awayTeam = teams.teams?.filter({$0.teamId == awayTeamId})[0] else {
                    return
                }
                twoTeams?.append([homeTeam,
                                  awayTeam
                                 ])
        }
    }

}

