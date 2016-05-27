//
//  PWPhotoGroupCell.swift
//  PWPhotosLibrary
//
//  Created by 王炜程 on 16/5/26.
//  Copyright © 2016年 weicheng wang. All rights reserved.
//

import UIKit
import Photos

let idePhotoGroupCell = "PWPhotoGroupCellIdentifier"

class PWPhotoGroupCell: UITableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        accessoryType = .DisclosureIndicator
    }

    
    func setResult(assetCollection : PHAssetCollection) {
        
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let fetchResult = PHAsset.fetchAssetsInAssetCollection(assetCollection, options: options)
        
        guard let asset = (fetchResult.firstObject) as? PHAsset else {
            return
        }
        titleLabel.text = assetCollection.localizedTitle
        countLabel.text = "(\(fetchResult.count))"
        
        PWPhotosManager.photo(asset: asset, size: CGSizeMake(80, 80)) { (image, info) in
            self.headImageView.image = image
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
