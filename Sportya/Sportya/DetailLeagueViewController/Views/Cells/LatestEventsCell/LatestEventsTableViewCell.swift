//
//  LatestEventsTableViewCell.swift
//  SportsApp
//
//  Created by Mahmoud Morsy on 23/03/2021.
//

import UIKit
import SDWebImage
import KRProgressHUD

class LatestEventsTableViewCell: UITableViewCell {
    
    var latestViewModel: LatestEventsViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.latestEventCollectionView.reloadData()
            }
            
        }
    }
    
    var allTeamsInLeague: AllTeamsInLeagueViewModel? {
        didSet{
            DispatchQueue.main.async {
                self.latestEventCollectionView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var latestEventCollectionView: UICollectionView! {
        didSet {
            latestEventCollectionView.delegate = self
            latestEventCollectionView.dataSource = self
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension LatestEventsTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return latestViewModel?.latestEventsData?.events?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = latestEventCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LatestEventsCollectionViewCell.self) , for: indexPath) as? LatestEventsCollectionViewCell else {
            return UICollectionViewCell()
        }
        if allTeamsInLeague != nil && allTeamsInLeague?.twoTeams != nil && (allTeamsInLeague?.twoTeams!.count)! > 0 {
            cell.homeTeamImage.sd_setImage(with: URL(string: (allTeamsInLeague?.twoTeams?[indexPath.row][0].imgURL ?? "")), placeholderImage: UIImage(named: "sports"))
            
            cell.awayTeamImage.sd_setImage(with: URL(string: (allTeamsInLeague?.twoTeams?[indexPath.row][1].imgURL) ?? ""), placeholderImage: UIImage(named: "sports"))
            
        }
        
        cell.homeTeamName.text = latestViewModel?.latestEventsData?.events?[indexPath.row].homeTeam
        cell.awayTeamName.text = latestViewModel?.latestEventsData?.events?[indexPath.row].awayTeam
                
        cell.dateLabel.text = latestViewModel?.latestEventsData?.events?[indexPath.row].dateEvent
        cell.homeTeamScoreLabel.text = latestViewModel?.latestEventsData?.events?[indexPath.row].scoreHomeTeam
        cell.awayTeamScoreLabel.text = latestViewModel?.latestEventsData?.events?[indexPath.row].scoreAwayTeam
        
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 2
        cell.contentView.layer.borderColor = UIColor.gray.cgColor
        
        
        
        return cell
    }
}
