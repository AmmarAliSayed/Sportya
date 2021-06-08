//
//  TeamsTableViewCell.swift
//  SportsApp
//
//  Created by Mahmoud Morsy on 22/03/2021.
//

import UIKit
import SDWebImage

protocol CollectionCellDelegate: class {
    func selectedItem(team: Team)
}

class TeamsTableViewCell: UITableViewCell {
    
    weak var delegate: CollectionCellDelegate?

    @IBOutlet weak var teamsCollectionView: UICollectionView! {
        didSet {
            teamsCollectionView.delegate = self
            teamsCollectionView.dataSource = self
        }
    }
    
    var allTeamsInLeague: AllTeamsInLeagueViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.teamsCollectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TeamsTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allTeamsInLeague?.teamDetailData?.teams?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = teamsCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TeamsCollectionViewCell.self) , for: indexPath) as? TeamsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let image = self.allTeamsInLeague?.teamDetailData?.teams?[indexPath.row].imgURL {
            cell.teamImage.sd_setImage(with: URL(string: (image)), placeholderImage: UIImage(named: "sports"))
        }

        
        cell.contentView.layer.borderWidth = 3
        cell.contentView.layer.masksToBounds = false
        cell.contentView.layer.borderColor = UIColor.gray.cgColor
        cell.contentView.layer.cornerRadius = cell.teamImage.frame.size.width / 2
        cell.contentView.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        teamsCollectionView.deselectItem(at: indexPath, animated: true)
        self.delegate?.selectedItem(team: (self.allTeamsInLeague?.teamDetailData?.teams?[indexPath.row])!)
    }
}

