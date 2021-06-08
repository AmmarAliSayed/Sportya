//
//  TeamsViewModel.swift
//  SportsApp
//
//  Created by Mahmoud Morsy on 28/03/2021.
//

import Foundation

protocol TeamsProtocol {
    
    init(team: Team)
    func callFuncToGetTeamDetail(teamId: String,completionHandler: @escaping (Bool)->Void)
    var getTeamDetail: ((TeamsProtocol) -> Void)? {get}
    var teamDetailData: Teams? {get set}
    var selectedTeam: Team? {get set}
}

class TeamsViewModel: TeamsProtocol {
    required init(team: Team) {
        self.selectedTeam = team
    }
    let apiService = APIClient()
    
    func callFuncToGetTeamDetail(teamId: String,completionHandler: @escaping (Bool)->Void) {
        completionHandler(false)
        apiService.fetchData(endPoint: "lookupteam.php?id=\(teamId)", responseClass: Teams.self) {[weak self] (response) in
            switch response {
            case .success(let teamDetail):
                self?.teamDetailData = teamDetail
            case .failure(let error):
                print(error)
            }
            completionHandler(true)
        }
    }
    
    var getTeamDetail: ((TeamsProtocol) -> Void)?
    
    var teamDetailData: Teams? {
        didSet {
            getTeamDetail!(self)
        }
    }
    
    var selectedTeam: Team?
}
