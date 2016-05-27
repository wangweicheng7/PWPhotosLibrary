//
//  PWImagePickerController.swift
//  PWPhotosLibrary
//
//  Created by 王炜程 on 16/5/26.
//  Copyright © 2016年 weicheng wang. All rights reserved.
//

import UIKit
import Photos

class PWImagePickerController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: PWCollectionViewFlowLayout!
    
    private var assetArray = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerNib(UINib(nibName: "PWAlbumCell", bundle: nil), forCellWithReuseIdentifier: ideAlbumCell)
        
        PWPhotosManager.cameraRollPhotos { (a) in
            self.step(a)
        }
    }

    func step(a : AnyObject) {
        PWPhotosManager.assets(fetchResult: a as! PHFetchResult, completion: { (assets) in
            self.assetArray += assets
            self.collectionView.reloadData()
        })
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assetArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ideAlbumCell, forIndexPath: indexPath) as! PWAlbumCell
        
        cell.setImage(asset: assetArray[indexPath.row])
        
        return cell
    }
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
