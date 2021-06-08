//
///LeaguesViewModel.swift
// SportsApp
//
// Created by Mahmoud Morsy on 26/03/2021.
//

import Foundation

protocol LeaguesProtocol {

    func callFuncToGetAllLeagues(completionHandler:@escaping (Bool) -> Void)
    var getLeagues: ((LeaguesProtocol)->Void)? {get}
    var leaguesData: AllLeagues? {get set}
    var selectedSport: AllSports? {get set}
    func getMoreInfoLeague()
    var moreInfoArray: leagueInfo? {get set}
    init (sport: AllSports)
}


class LeaguesViewModel: LeaguesProtocol {
    
    required init(sport: AllSports) {
        self.selectedSport = sport
    }
    var selectedSport: AllSports?

    
    var getLeagues: ((LeaguesProtocol) -> Void)?
    
    var leaguesData: AllLeagues? {
        didSet {

        }
    }
    var resultArray: leagueInfo? {
        didSet{
            self.moreInfoArray = self.resultArray
        }
        
    }
    var moreInfoArray: leagueInfo?{
        didSet {
            getLeagues!(self)
        }
    }
    
    let apiService = APIClient()
    
    func callFuncToGetAllLeagues(completionHandler:@escaping (Bool) -> Void) {
        completionHandler(false)
        apiService.fetchData(endPoint: "all_leagues.php", responseClass: AllLeagues.self) {[weak self] (response) in
            switch response {
            case .success(let leagues):
                self?.leaguesData = leagues
                self?.leaguesData?.leagues = (leagues?.leagues.filter({$0.leagueSportType == self?.selectedSport?.sportName}))!
                
                self?.getMoreInfoLeague()
            case .failure(let error):
                print(error)
            }
            completionHandler(true)
        }
    }
    
    func getMoreInfoLeague() {
        resultArray = leagueInfo(leagues: [])
        for item in self.leaguesData!.leagues {
            apiService.fetchData(endPoint: "lookupleague.php?id=\(item.leagueId)", responseClass: leagueInfo.self) {[weak self] (response) in

                switch response {
                case .success(let data):
                    self?.resultArray?.leagues.append((data!).leagues[0])
                    

                case .failure(let error):
                    print(error)
                }

            }
        }
        
    }
    
    func getMatchesViewModel(league: AllLeagueInfo) -> LatestEventsViewModel {
        return LatestEventsViewModel(league: league)
    }
   
    func getAllTeamsInLeagueViewModel(league: AllLeagueInfo) -> AllTeamsInLeagueViewModel {
        return AllTeamsInLeagueViewModel(league: league)
    }
    

}
