//
//  FavoriteLeagueViewModel.swift
//  SportsApp
//
//  Created by Macbook on 28/03/2021.
//

import Foundation
import CoreData
import UIKit
protocol FavoriteLeaguesProtocol {
    func callFuncToAddNewFavoriteLeagueToCoreData(leagueName:String,leagueImg:String,leagueYoutube:String,leagueId:String)
    
    func callFuncToFetchDataFromCoreData()
    func checkLeagueExists (leagueId :String)-> Bool
    var getFavoriteLeaguesFromCoreData: ((FavoriteLeaguesProtocol)->Void)? {get set}
    var favoriteLeaguesCoreData :[NSManagedObject]? {get set}//array of leagues
    var selectedLeague: AllLeagueInfo? {get set}
   
}

class FavoriteLeaguesViewModel: FavoriteLeaguesProtocol {
    var selectedLeague: AllLeagueInfo?
    
    var getFavoriteLeaguesFromCoreData: ((FavoriteLeaguesProtocol) -> Void)?
    
    var favoriteLeaguesCoreData: [NSManagedObject]?{
        didSet{

        }
    }
    let manageContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func callFuncToAddNewFavoriteLeagueToCoreData(leagueName:String,leagueImg:String,leagueYoutube:String,leagueId:String){
        
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteLeague", in: manageContext)
        
        // 4 create manage object for movie entity
        
        let favoriteLeague = NSManagedObject(entity: entity!, insertInto: manageContext)
        
        //5 set values for the manage object
        
        favoriteLeague.setValue(leagueName, forKey: "favoriteLeagueName")
        favoriteLeague.setValue(leagueImg, forKey: "favoriteLeagueImg")
        favoriteLeague.setValue(leagueId, forKey: "favoriteLeagueId")
        favoriteLeague.setValue(leagueYoutube, forKey: "favoriteLeagueYoutubeUrl")
        
        do{
            try manageContext.save()
            favoriteLeaguesCoreData?.append(favoriteLeague)
        }catch let error{
            print(error)
        }
    }
    
    func callFuncToFetchDataFromCoreData() {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeague")
        
        do{
            favoriteLeaguesCoreData = try manageContext.fetch(fetchRequest)
        }catch let error{
            print(error)
        }
    }
    
    
    var results: [NSManagedObject] = []
    
    func checkLeagueExists (leagueId :String) -> Bool {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeague")
        
        let predicate = NSPredicate(format: "favoriteLeagueId == %@", leagueId)
        
        fetchRequest.predicate = predicate
        
        do {
            results = try manageContext.fetch(fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        return results.count > 0
    }
    
    func deleteFromCoreData(with leagueId: String) {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteLeague")
        let predicate = NSPredicate(format: "favoriteLeagueId == %@", leagueId)
        fetchRequest.predicate = predicate
        
        if let result = try? manageContext.fetch(fetchRequest) {
            for object in result {
                manageContext.delete(object)
                try? manageContext.save()
            }
        }
        
    }
    
    func getMatchesViewModel(league: AllLeagueInfo) -> LatestEventsViewModel {
        return LatestEventsViewModel(league: league)
    }
}




