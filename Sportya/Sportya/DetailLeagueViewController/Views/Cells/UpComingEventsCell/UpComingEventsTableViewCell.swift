//
//  UpComingEventsTableViewCell.swift
//  SportsApp
//
//  Created by Mahmoud Morsy on 22/03/2021.
//

import UIKit

class UpComingEventsTableViewCell: UITableViewCell {
    
    @IBOutlet var upComingCollectionView: UICollectionView!{
        didSet {
            upComingCollectionView.delegate = self
            upComingCollectionView.dataSource = self
        }
    }
    
    var latestViewModel: LatestEventsViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.upComingCollectionView.reloadData()
            }
            
        }
    }
    
    var allTeamsInLeague: AllTeamsInLeagueViewModel? {
        didSet{
            DispatchQueue.main.async {
                self.upComingCollectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}

extension UpComingEventsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return latestViewModel?.latestEventsData?.events?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = upComingCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UpComingCollectionViewCell.self) , for: indexPath) as? UpComingCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if allTeamsInLeague != nil && allTeamsInLeague?.twoTeams != nil && (allTeamsInLeague?.twoTeams!.count)! > 0 {
            cell.homeTeamImage.sd_setImage(with: URL(string: (allTeamsInLeague?.twoTeams?[indexPath.row][0].imgURL ?? "")), placeholderImage: UIImage(named: "sports"))
            
            cell.awayTeamImage.sd_setImage(with: URL(string: (allTeamsInLeague?.twoTeams?[indexPath.row][1].imgURL) ?? ""), placeholderImage: UIImage(named: "sports"))
            
        }
        
        cell.homeTeamLabel.text = latestViewModel?.latestEventsData?.events?[indexPath.row].homeTeam
        cell.awayTeamLabel.text = latestViewModel?.latestEventsData?.events?[indexPath.row].awayTeam
                
        cell.dateDay.text = latestViewModel?.latestEventsData?.events?[indexPath.row].dateEvent
        cell.timeToStart.text = latestViewModel?.latestEventsData?.events?[indexPath.row].time
    
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 2
        cell.contentView.layer.borderColor = UIColor.gray.cgColor
        
        
        
        return cell
    }
    
    
}
