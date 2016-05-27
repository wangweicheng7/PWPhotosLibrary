//
//  PWPhotosManager.swift
//  PWPhotosLibrary
//
//  Created by 王炜程 on 16/5/26.
//  Copyright © 2016年 weicheng wang. All rights reserved.
//

import UIKit
import Photos

let ScreenWidth = UIScreen.mainScreen().bounds.width
let ScreenHeight = UIScreen.mainScreen().bounds.height

class PWPhotosManager: NSObject {
    
    var supportVideo = false  // 是否支持视频
    
    /**
     获取照片库 相机胶卷 相册
     
     - parameter completion: 获取成功将获取的相册集回传，失败则不传
     */
    class func cameraRollPhotos(completion : (PHAssetCollection) -> Void) {
        
        
        let smartAlbums = PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: .SmartAlbumUserLibrary, options: nil)
        
        smartAlbums.enumerateObjectsUsingBlock { (anyObj, index, stop) in

            let collection = anyObj as! PHAssetCollection
            // 如果匹配到 相机胶卷，回传，退出
            if collection.localizedTitle == "Camera Roll" || collection.localizedTitle == "相机胶卷" {

                completion(collection)
                stop.memory = true
            }
            
        }
        
    }
    
    class func album(completion : ([PHAssetCollection])->Void)  {

        // 支持视频
        var albumArr = [PHAssetCollection]()
        
        // 排序规则
        let smartAlbums = PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: .Any, options: nil)

        smartAlbums.enumerateObjectsUsingBlock { (anyObj, index, stop) in
            let collection = anyObj as! PHAssetCollection
            let options = PHFetchOptions()
            options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
            let fetchResult = PHAsset.fetchAssetsInAssetCollection(collection, options: options)
            
            if fetchResult.count > 0 {
                albumArr += [collection]
            }
        }
        
        completion(albumArr)
    }
    
    
    /**
     获取相册中照片的结果集
     
     - parameter aFetchResult: 相册集
     - parameter completion:   成功的回调，将照片结果集回传
     */
    class func assets(assetCollection aAssetCollection : PHAssetCollection, completion: ([PHAsset]) -> Void) {
        var assetArr = [PHAsset]()

        let fetchResult = PWPhotosManager.fetchResult(assetCollection: aAssetCollection)
        fetchResult.enumerateObjectsUsingBlock { (anyObj, index, stop) in

            assetArr.append(anyObj as! PHAsset)
        }
        completion(assetArr)
    }
    /**
     获取原图
     */
    class func originalPhoto(asset aAsset : PHAsset, completion : (UIImage,[NSObject:AnyObject]) -> Void) {
        PWPhotosManager.photo(asset: aAsset, size: PHImageManagerMaximumSize, completion: completion)
    }
    
    class func photo(asset aAsset : PHAsset,size aSize : CGSize, completion : (UIImage,[NSObject:AnyObject]) -> Void) {
        
        // 从图片的结果集请求图片，如果所给的宽高比未能匹配图片，将根据contentMode自动匹配，为了更快的提供照片，所给的图片将会比targetSize略大
        PHImageManager.defaultManager().requestImageForAsset(aAsset, targetSize: aSize, contentMode: .AspectFit, options: nil) { (image, info) in
            
            guard let info = info else {
                return;
            }
            
//            let loadState : Bool = !(info[PHImageCancelledKey] as! Bool || info[PHImageErrorKey] as! Bool)
            if /*loadState == true &&*/ image != nil {
                completion(image!, info)
                return
            }
            
            if info[PHImageResultIsInCloudKey] as! Bool == true && image == nil {
                let options = PHImageRequestOptions()
                options.networkAccessAllowed = true
                PHImageManager.defaultManager().requestImageDataForAsset(aAsset, options: options, resultHandler: { (imageData, dataUTI, orientation, info) in
                    // 从iCloud上请求到图片
                    let image = UIImage(data: imageData!, scale: 0.1)
                     completion(image!,info!)
                })
            }
        }
        
    }
    
    class func fetchResult(assetCollection aAssetCollection : PHAssetCollection) -> PHFetchResult {
        
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        return PHAsset.fetchAssetsInAssetCollection(aAssetCollection, options: options)

    }
    
    // 获取视频
    func video(asset aAsset : PHAsset, completion:(AVPlayerItem, [NSObject:AnyObject])->Void) {
        PHImageManager.defaultManager().requestPlayerItemForVideo(aAsset, options: nil) { (playerItem, info) in
            completion(playerItem!, info!)
        }
    }
    
}
