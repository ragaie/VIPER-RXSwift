//
//  BannerCollectionViewCell.swift
//  DinDinn-task
//
//  Created by Ragaie Alfy on 11/20/20.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var bannerImage: UIImageView!
    
    func setImage(url : String){
        bannerImage.featchImage(urlString: url, imageName: "banner")
    }
}
