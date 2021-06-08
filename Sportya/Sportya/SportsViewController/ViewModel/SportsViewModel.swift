//
//  SportsViewModel.swift
//  SportsApp
//
//  Created by Mahmoud Morsy on 24/03/2021.
//

import Foundation

protocol SportsProtocol {
    func callFuncToGetAllSports(completionHandler:@escaping (Bool) -> Void)
    var getSports: ((SportsProtocol)->Void)? {get set}
    var sportData: Sport? {get set}
   
    
}

class SportsViewModel: SportsProtocol {
    
    func getLeaguesViewModel(for index: Int) -> LeaguesViewModel {
        return LeaguesViewModel(sport: (sportData?.sports[index])!)
    }
    
    private let apiService = APIClient()
    
    var getSports: ((SportsProtocol) -> Void)?
    
    var sportData: Sport? {
        didSet {
            getSports!(self)
        }
    }
    
    func callFuncToGetAllSports(completionHandler:@escaping (Bool) -> Void) {
        completionHandler(false)
        apiService.fetchData(endPoint: "all_sports.php", responseClass: Sport.self) {[weak self] (response) in
            switch response {
            case .success(let sports):
                self?.sportData = sports
                
                
//                self.sportsView?.fetchingDataSuccess()
//                self.sportsView?.hideIndicator()
            case .failure(let error):
                print(error)
            }
            completionHandler(true)
        }

    }
    
    
}
