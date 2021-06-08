//
//  TeamsViewController.swift
//  SportsApp
//
//  Created by Mahmoud Morsy on 23/03/2021.
//

import UIKit
import SDWebImage
import KRProgressHUD


class TeamDetailsViewController: UIViewController {
    
    @IBOutlet weak var webSiteButton: UIButton!
    @IBOutlet weak var faceBookButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var faceBookButtonFull: UIButton!
    @IBOutlet weak var instagramButtonFull: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var twitterButtonFull: UIButton!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stadiumNameLabel: UILabel!
    @IBOutlet weak var foundedYearLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamLogoImageView: UIImageView!
    @IBOutlet weak var stadiumImagView: UIImageView!
    @IBOutlet weak var backGroundImage: UIImageView!
    
    
    var teamsViewModel: TeamsViewModel? {
        didSet {
            teamsViewModel?.callFuncToGetTeamDetail(teamId: (teamsViewModel?.selectedTeam?.teamId)!, completionHandler: {(isFinished) in
                if !isFinished {
                    KRProgressHUD.show()
                } else {
                       KRProgressHUD.dismiss()
                }
            })
            
            teamsViewModel?.getTeamDetail = {[weak self] vm in
                self?.teamNameLabel.text = self?.teamsViewModel?.selectedTeam?.teamName
                self?.leagueName.text = self?.teamsViewModel?.selectedTeam?.league
                self?.countryNameLabel.text = self?.teamsViewModel?.selectedTeam?.country
                self?.foundedYearLabel.text = self?.teamsViewModel?.selectedTeam?.birthYear
                self?.stadiumNameLabel.text = self?.teamsViewModel?.selectedTeam?.stadiumName
                self?.descriptionLabel.text = self?.teamsViewModel?.selectedTeam?.description
                self?.webSiteButton.setTitle(self?.teamsViewModel?.selectedTeam?.website, for: .normal)
                self?.faceBookButtonFull.setTitle(self?.teamsViewModel?.selectedTeam?.facebook, for: .normal)
                self?.instagramButtonFull.setTitle(self?.teamsViewModel?.selectedTeam?.instagram, for: .normal)
                self?.twitterButtonFull.setTitle(self?.teamsViewModel?.selectedTeam?.twitter, for: .normal)
                
                if let image = self?.teamsViewModel?.selectedTeam?.stadiumImgURL {
                    self?.stadiumImagView.sd_setImage(with: URL(string: (image)), placeholderImage: UIImage(named: "sports"))
                }
                if let image = self?.teamsViewModel?.selectedTeam?.imgURL {
                    self?.teamLogoImageView.sd_setImage(with: URL(string: (image)), placeholderImage: UIImage(named: "sports"))
                }
                
                if let image = self?.teamsViewModel?.selectedTeam?.teamBanner {
                    self?.backGroundImage.sd_setImage(with: URL(string: (image)), placeholderImage: UIImage(named: "sports"))
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = teamsViewModel?.selectedTeam?.teamName
    }
    
    @IBAction func webSite1Tapped(_ sender: Any) {
        guard let webSiteUrl = URL(string: "https://\(teamsViewModel?.selectedTeam?.website! ?? "")") else {return}
        if UIApplication.shared.canOpenURL(webSiteUrl) {
           UIApplication.shared.open(webSiteUrl, options: [:])
        }
    }
    
    
    @IBAction func webSite2Tapped(_ sender: Any) {
        guard let webSiteUrl = URL(string: "https://\(teamsViewModel?.selectedTeam?.website! ?? "")") else {return}
        if UIApplication.shared.canOpenURL(webSiteUrl) {
           UIApplication.shared.open(webSiteUrl, options: [:])
        }
    }
    
    @IBAction func faceBook1Tapped(_ sender: Any) {
        guard let facbookUrl = URL(string: "https://\(teamsViewModel?.selectedTeam?.facebook! ?? "")") else {return}
        if UIApplication.shared.canOpenURL(facbookUrl) {
           UIApplication.shared.open(facbookUrl, options: [:])
        }
    }
    
    @IBAction func faceBook2Tapped(_ sender: Any) {
        guard let facbookUrl = URL(string: "https://\(teamsViewModel?.selectedTeam?.facebook! ?? "")") else {return}
        if UIApplication.shared.canOpenURL(facbookUrl) {
           UIApplication.shared.open(facbookUrl, options: [:])
        }
    }
    
    @IBAction func instagram1Tapped(_ sender: Any) {
        guard let instgramUrl = URL(string: "https://\(teamsViewModel?.selectedTeam?.instagram! ?? "")") else {return}
        if UIApplication.shared.canOpenURL(instgramUrl) {
           UIApplication.shared.open(instgramUrl, options: [:])
        }
    }
    
    @IBAction func instagram2Tapped(_ sender: Any) {
        guard let instgramUrl = URL(string: "https://\(teamsViewModel?.selectedTeam?.instagram! ?? "")") else {return}
        if UIApplication.shared.canOpenURL(instgramUrl) {
           UIApplication.shared.open(instgramUrl, options: [:])
        }
    }
    
    @IBAction func twitter1Tapped(_ sender: Any) {
        guard let twitterUrl = URL(string: "https://\(teamsViewModel?.selectedTeam?.twitter! ?? "")") else {return}
        if UIApplication.shared.canOpenURL(twitterUrl) {
           UIApplication.shared.open(twitterUrl, options: [:])
        }
    }
    @IBAction func twittrt2Tapped(_ sender: Any) {
        guard let twitterUrl = URL(string: "https://\(teamsViewModel?.selectedTeam?.twitter! ?? "")") else {return}
        if UIApplication.shared.canOpenURL(twitterUrl) {
           UIApplication.shared.open(twitterUrl, options: [:])
        }
    }
}
