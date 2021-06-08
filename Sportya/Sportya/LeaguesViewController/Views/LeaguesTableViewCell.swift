//
//  LeaguesTableViewCell.swift
//  SportsApp
//
//  Created by Macbook on 19/03/2021.
//

import UIKit

protocol YouTubeDelegate: class {
    func didPressYouTubeButton(cell: LeaguesTableViewCell)
}

class LeaguesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var leagueImageView: UIImageView!
    weak var youTubeDelgate: YouTubeDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func showLeagueChanel(_ sender: Any) {
        self.youTubeDelgate?.didPressYouTubeButton(cell: self)
    }
}
