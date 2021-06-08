//
//  SportsViewController.swift
//  SportsApp
//
//  Created by Mahmoud Morsy on 19/03/2021.
//

import UIKit
import SDWebImage
import KRProgressHUD
import Reachability
class SportsViewController: UIViewController {
    
    let network: NetworkManager = NetworkManager.sharedInstance
    
    @IBOutlet weak var sportsCollectionView: UICollectionView! {
        didSet {
            sportsCollectionView.delegate = self
            sportsCollectionView.dataSource = self
            sportsCollectionView.register(UINib(nibName: "SportsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: String(describing: SportsCollectionViewCell.self))
        }
    }
    
    var sportsViewModel: SportsViewModel? {
        didSet {
            sportsViewModel?.callFuncToGetAllSports(completionHandler: {(isFinished) in
                if !isFinished {
                    KRProgressHUD.show()
                }else {
                    KRProgressHUD.dismiss()
                }
                
            })
            sportsViewModel?.getSports = {[weak self] vm in
                DispatchQueue.main.async {
                    self?.sportsCollectionView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sportsViewModel = SportsViewModel()
        NetworkManager.isUnreachable { _ in
            self.showInternetMessage(message: "Cannot Load Sports")
        }
        
    
    }
    
    
    func showInternetMessage(message: String) {
        
        let actionsheet = UIAlertController(title: message, message: "It seems that you are not connected with the internet please reconnect to get all sports or go to your favorite leagues", preferredStyle: .actionSheet)
        
        actionsheet.addAction(UIAlertAction(title: "Retry", style: .default, handler: {
            action in
            self.sportsViewModel?.callFuncToGetAllSports(completionHandler: { (isFinished) in
                if !isFinished {
                    KRProgressHUD.show()
                }else {
                    KRProgressHUD.dismiss()
                }
               
            })
            self.showInternetMessage(message: "Cannot Load Sports")
            
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Go to favourite", style: .default, handler: {
            action in
            self.tabBarController?.selectedIndex = 1
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionsheet, animated: true, completion: nil)
    }
}


extension SportsViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsViewModel?.sportData?.sports.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = sportsCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SportsCollectionViewCell.self), for: indexPath) as? SportsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.sportName.text = sportsViewModel?.sportData?.sports[indexPath.row].sportName
        
        if let image = sportsViewModel?.sportData?.sports[indexPath.row].sportImage {
            cell.sportImage.sd_setImage(with: URL(string: (image)), placeholderImage: UIImage(named: "sports"))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "sportToLeagues", sender: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.frame.size.width - 30) / 2
        return CGSize(width: size, height: size)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sportToLeagues"{
            guard let selectedIndexPath = sender as? NSIndexPath else{ return }
              let leaguesViewController = segue.destination as! LeaguesTableViewController
            leaguesViewController.leaguesViewModel = self.sportsViewModel?.getLeaguesViewModel(for: selectedIndexPath.row)
          }
    }
}

