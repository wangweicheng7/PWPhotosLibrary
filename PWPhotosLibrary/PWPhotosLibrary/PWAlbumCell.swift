//
//  PWAlbumCell.swift
//  PWPhotosLibrary
//
//  Created by 王炜程 on 16/5/26.
//  Copyright © 2016年 weicheng wang. All rights reserved.
//

import UIKit
import Photos

let ideAlbumCell = "PWAlbumCellIdentifier"


class PWAlbumCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var selectButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func selectButtonClicked(sender: AnyObject) {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
        
    func setImage(asset aAsset : PHAsset, preview : Bool) {
        if preview {
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            PWPhotosManager.originalPhoto(asset: aAsset, completion: { (image, info) in
                self.imageView.image = image
            })
        }else{
            imageView.contentMode = UIViewContentMode.ScaleAspectFill
            PWPhotosManager.photo(asset: aAsset, size: CGSizeMake(ScreenWidth/4-6, ScreenWidth/4-6)) { (image, info) in
                self.imageView.image = image
            }
        }
    }

}
