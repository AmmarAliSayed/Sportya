//
//  FavoriteLeaguesViewController.swift
//  SportsApp
//
//  Created by Macbook on 26/03/2021.
//

import UIKit
import  SDWebImage
import Reachability

class FavoriteLeaguesViewController: UIViewController {
    
    let network = NetworkManager.sharedInstance
    
    var league:AllLeagueInfo?
    
    var viewModel : FavoriteLeaguesViewModel? {
        didSet {
            viewModel?.getFavoriteLeaguesFromCoreData = {[weak self] viewModel in
                DispatchQueue.main.async {
                    self?.tabelView.reloadData()
                }
            }
        }
    }
    
    @IBOutlet weak var tabelView: UITableView!{
        didSet{
            tabelView.delegate=self
            tabelView.dataSource=self
            
            tabelView.register(UINib(nibName: "FavoriteLeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: String(describing: FavoriteLeaguesTableViewCell.self))
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FavoriteLeaguesViewModel()
        network.reachability.whenUnreachable = { reachability in
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        viewModel?.callFuncToFetchDataFromCoreData()
        
        tabelView.reloadData()
    }
    
    
    
}
extension FavoriteLeaguesViewController :  UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        return viewModel?.favoriteLeaguesCoreData?.count ?? 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FavoriteLeaguesTableViewCell.self), for: indexPath) as? FavoriteLeaguesTableViewCell else {
            return UITableViewCell()
        }
        cell.favoriteLeagueNameImageView.sd_setImage(with: URL(string: (viewModel?.favoriteLeaguesCoreData![indexPath.row].value(forKey: "favoriteLeagueImg") as? String ?? "")) ,  placeholderImage: UIImage(named: "sports"))
        cell.favoriteLeagueNameLabel.text =
            viewModel?.favoriteLeaguesCoreData![indexPath.row].value(forKey: "favoriteLeagueName") as? String
        
        
        cell.favYouTubeDelgate = self
        //make pic circular
        cell.favoriteLeagueNameImageView.layer.borderWidth = 1.0
        cell.favoriteLeagueNameImageView.layer.masksToBounds = false
        cell.favoriteLeagueNameImageView.layer.borderColor = UIColor.black.cgColor
        cell.favoriteLeagueNameImageView.layer.cornerRadius = cell.favoriteLeagueNameImageView.frame.size.width/2
        cell.favoriteLeagueNameImageView.clipsToBounds=true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        NetworkManager.isUnreachable { _ in
            self.showInternetMessage(message: "Cannot Load Favorites",index: indexPath.row)
        }
        NetworkManager.isReachable { (NetworkManager) in
            self.performSegue(withIdentifier: "fromFavToLeagueDetail", sender: indexPath)
        }
       
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromFavToLeagueDetail"{
            guard let selectedIndexPath = sender as? NSIndexPath else{ return }
            let detailLeagueViewController = segue.destination as! DetailLeagueViewController
            let leagueItem = viewModel?.favoriteLeaguesCoreData![selectedIndexPath.row]
            let league = AllLeagueInfo(leagueImg: leagueItem?.value(forKey: "favoriteLeagueImg") as! String, leagueYoutubeUrl: leagueItem?.value(forKey: "favoriteLeagueYoutubeUrl") as! String, leagueId: leagueItem?.value(forKey: "favoriteLeagueId") as! String, leagueName: leagueItem?.value(forKey: "favoriteLeagueName") as! String, leagueSportType: "")
            let leagueDetail = LatestEventsViewModel(league: league)
            let allTeamInfo = AllTeamsInLeagueViewModel(league: league)
            
            detailLeagueViewController.latestViewModel = leagueDetail
            detailLeagueViewController.allTeamsInLeagueViewModel = allTeamInfo
            
        }
    }
    
    func showInternetMessage(message: String,index: Int) {
        
        let actionsheet = UIAlertController(title: message, message: "It seems that you are not connected with the internet please reconnect to get all Favorites data", preferredStyle: .actionSheet)
        
        actionsheet.addAction(UIAlertAction(title: "Retry", style: .default, handler: {
            action in
            
            self.performSegue(withIdentifier: "fromFavToLeagueDetail", sender: index)

            
        }))
        
        
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionsheet, animated: true, completion: nil)
    }
}

extension FavoriteLeaguesViewController: FavoriteYouTubeDelegate {
    
    func didPressYouTubeButton(cell: FavoriteLeaguesTableViewCell) {
        
        NetworkManager.isUnreachable { _ in
            let alert = UIAlertController(title: "Can't load league video", message: "It seems that you are not connected with the internet please reconnect and retry later", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        NetworkManager.isReachable { [self] (NetworkManager) in
            guard let indexPath = self.tabelView.indexPath(for: cell) else {return}
            
         guard let webSiteUrl = URL(string: "https://\(viewModel?.favoriteLeaguesCoreData![indexPath.row].value(forKey: "favoriteLeagueYoutubeUrl") as? String ?? "")") else {return}
            if UIApplication.shared.canOpenURL(webSiteUrl) {
               UIApplication.shared.open(webSiteUrl, options: [:])
            }
        }
        
        
        
      
    }
    
    
    
    
}
