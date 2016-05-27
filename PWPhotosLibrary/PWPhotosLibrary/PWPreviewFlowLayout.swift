//
//  PWPreviewFlowLayout.swift
//  PWPhotosLibrary
//
//  Created by 王炜程 on 16/5/26.
//  Copyright © 2016年 weicheng wang. All rights reserved.
//

import UIKit

class PWPreviewFlowLayout: UICollectionViewFlowLayout {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        itemSize = CGSizeMake(ScreenWidth, ScreenHeight)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .Horizontal
        sectionInset = UIEdgeInsetsZero
    }
    
}
