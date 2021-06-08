//
//  LeaguesTableViewController.swift
//  SportsApp
//
//  Created by Macbook on 19/03/2021.
//

import UIKit
import SDWebImage
import KRProgressHUD


class LeaguesTableViewController: UITableViewController {
    
    
    var leaguesViewModel: LeaguesViewModel? {
        didSet {
            leaguesViewModel?.callFuncToGetAllLeagues(completionHandler: {(isFinished) in
                if !isFinished {
                    KRProgressHUD.show()
                }else {
                    KRProgressHUD.dismiss()
                }
            })
            leaguesViewModel?.getLeagues = {[weak self] viewModel in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //add register
        tableView.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: String(describing: LeaguesTableViewCell.self))
        self.title = leaguesViewModel?.selectedSport?.sportName
       
        
        
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leaguesViewModel?.moreInfoArray?.leagues.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        // Configure the cell...
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LeaguesTableViewCell.self), for: indexPath) as? LeaguesTableViewCell else {
            return UITableViewCell()
        }
        
        cell.leagueNameLabel.text = leaguesViewModel?.moreInfoArray?.leagues[indexPath.row].leagueName
        
        if let image = self.leaguesViewModel?.moreInfoArray?.leagues[indexPath.row].leagueImg {
            cell.leagueImageView.sd_setImage(with: URL(string: (image)), placeholderImage: UIImage(named: "sports"))
        }
        
        cell.youTubeDelgate = self
        
        //make pic circular
        cell.leagueImageView.layer.borderWidth = 1.0
        cell.leagueImageView.layer.masksToBounds = false
        cell.leagueImageView.layer.borderColor = UIColor.black.cgColor
        cell.leagueImageView.layer.cornerRadius = cell.leagueImageView.frame.size.width/2
        cell.leagueImageView.clipsToBounds=true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.performSegue(withIdentifier: "leagueToDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "leagueToDetail"{
            guard let selectedIndexPath = sender as? NSIndexPath else{ return }
              let detailLeagueViewController = segue.destination as! DetailLeagueViewController
            
            detailLeagueViewController.latestViewModel = self.leaguesViewModel?.getMatchesViewModel(league: (leaguesViewModel?.moreInfoArray?.leagues[selectedIndexPath.row])!)
            
            detailLeagueViewController.allTeamsInLeagueViewModel = self.leaguesViewModel?.getAllTeamsInLeagueViewModel(league: (leaguesViewModel?.moreInfoArray?.leagues[selectedIndexPath.row])!)
          }
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension LeaguesTableViewController: YouTubeDelegate {
    func didPressYouTubeButton(cell: LeaguesTableViewCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {return}
        
        guard let webSiteUrl = URL(string: "https://\(leaguesViewModel?.moreInfoArray?.leagues[indexPath.row].leagueYoutubeUrl ?? "")") else {return}
        if UIApplication.shared.canOpenURL(webSiteUrl) {
           UIApplication.shared.open(webSiteUrl, options: [:])
        }
    }
    
    
    
    
}
