//
//  PWImagePickerController.swift
//  PWPhotosLibrary
//
//  Created by 王炜程 on 16/5/26.
//  Copyright © 2016年 weicheng wang. All rights reserved.
//

import UIKit
import Photos

extension UICollectionView {
    func updateItem(indexPath : NSIndexPath, animated : Bool) {
        let layout = collectionViewLayout as! PWCollectionViewFlowLayout
        if animated {
            UIView.animateWithDuration(2.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: .CurveEaseInOut, animations: {
                self.performBatchUpdates({

                    layout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight)
                    layout.minimumLineSpacing = 0
                    layout.minimumInteritemSpacing = 0
                    layout.scrollDirection = .Horizontal
                    layout.sectionInset = UIEdgeInsetsZero
                    }, completion: { (finished) in
                        
                })
                }, completion: { (finished) in
                    
            })
        }
    }
}


class PWPhotoViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: PWCollectionViewFlowLayout!
    
    var assetCollection : PHAssetCollection?
    
    private var assetArray = [PHAsset]()
    private var preview : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerNib(UINib(nibName: "PWAlbumCell", bundle: nil), forCellWithReuseIdentifier: ideAlbumCell)
        
        guard let assetCollection = assetCollection else {
            PWPhotosManager.cameraRollPhotos { (a) in
                self.step(a)
            }
            return
        }
        PWPhotosManager.assets(assetCollection: assetCollection) { (assetArr) in
            self.assetArray += assetArr
            self.collectionView.reloadData()
        }
        
    }

    func step(a : AnyObject) {
        PWPhotosManager.assets(assetCollection: a as! PHAssetCollection, completion: { (assets) in
            self.assetArray += assets
            self.collectionView.reloadData()
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: self.assetArray.count-1, inSection: 0), atScrollPosition: .Bottom, animated: false)
        })
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return preview  // 如果是预览的话，就隐藏
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
        
        cell.setImage(asset: assetArray[indexPath.row], preview: preview)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        preview = !preview
        
        flowLayout.reLayout(preview)
        navigationController?.setNavigationBarHidden(preview, animated: true)
        prefersStatusBarHidden()    // 隐藏状态栏
        
        collectionView.reloadData()
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: false)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
