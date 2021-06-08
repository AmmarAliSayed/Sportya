//
//  SportsCollectionViewCell.swift
//  SportsApp
//
//  Created by Mahmoud Morsy on 19/03/2021.
//

import UIKit
import CoreImage




class SportsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var sportName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = .black
        contentView.layer.borderWidth = 3
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = contentView.frame.size.width / 4
        sportName.textColor = .white
    }

}
/*
extension UIImage {
    func adjustGamma() -> UIImage {
        let filter = CIFilter(name: "CIGammaAdjust", parameters: [
            "inputImage" : CIImage(image: self)!,
            "inputPower" : 8
        ])!
        return fromCIImageToImage(ciImage: filter.outputImage!)
    }
    
    func adjustVibrance() -> UIImage {
        let filter = CIFilter(name: "CIVibrance", parameters: [
            "inputImage" : CIImage(image: self)!,
            "inputAmount" : -0.3
        ])!
        return fromCIImageToImage(ciImage: filter.outputImage!)
    }
    
    func adjustBlur() -> UIImage {
        let filter = CIFilter(name: "CIGaussianBlur", parameters: [
            "inputImage" : CIImage(image: self)!,
            "inputRadius" : 2
        ])!
        return fromCIImageToImage(ciImage: filter.outputImage!)
    }
}

func fromCIImageToImage(ciImage: CIImage) -> UIImage {
    
    let ciContext = CIContext()
    let cgImage = ciContext.createCGImage(ciImage, from: (ciImage.extent))
    return UIImage(cgImage: cgImage!)
}
 */


