//
//  PWCollectionViewFlowLayout.swift
//  PWPhotosLibrary
//
//  Created by 王炜程 on 16/5/26.
//  Copyright © 2016年 weicheng wang. All rights reserved.
//

import UIKit

class PWCollectionViewFlowLayout: UICollectionViewFlowLayout {
    

    var selectedIndexPath  = NSIndexPath()
    
    private var itemW : CGFloat = 0
    private var itemH : CGFloat = 0
    private var expandItemW : CGFloat = 0
    private var expandItemH : CGFloat = 0
    private var expandFactor : CGFloat = 0
    private var collectionViewW : CGFloat = 0
    private var orderItemAlpha : CGFloat = 0.5
    
    private var numberOfItemsInRow : Int = 1
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        
        reLayout(false)
    }
    
    func reLayout(preview : Bool) {
        
        if preview {
            itemW = ScreenWidth
            itemH = ScreenHeight
            minimumLineSpacing = 0
            minimumInteritemSpacing = 0
            scrollDirection = .Horizontal
            sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }else{
            itemW = (ScreenWidth-26)/4
            itemH = (ScreenWidth-26)/4

            minimumLineSpacing = 2
            minimumInteritemSpacing = 2
            scrollDirection = .Vertical
            sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        }
        itemSize = CGSizeMake(itemW, itemH)
    }
    
    
    /*
     *  新插入或者删除的元素的最初或最终状态（Layout）
     *  苹果默认的实现中，对于特定的某个 indexPath，返回的是它的通常的位置，但 alpha 值为 0.0，这就产生了一个淡入或淡出动画。
     *
    override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
     // 自定义出现时候的动画
        guard let attr = layoutAttributesForItemAtIndexPath(itemIndexPath) else {
            print("no this item arrtibute")
            return UICollectionViewLayoutAttributes()
        }
        
        attr.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), CGFloat(M_PI));
        attr.center = CGPointMake(CGRectGetMidX(collectionView!.bounds), CGRectGetMaxY(collectionView!.bounds));
     
     return attr;
    }
    
    override func finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
    }
     */

    /*
     *  相应设备横竖屏变化
     *
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }*/
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let attrArr : [UICollectionViewLayoutAttributes] = super.layoutAttributesForElementsInRect(rect) else {
            return [UICollectionViewLayoutAttributes]()
        }
        
        let _ = attrArr.filter { (attr) -> Bool in
            attr.size = CGSizeMake(itemW, itemH)

            return true
        }
        return attrArr
    }
    

    
//    override func prepareLayout() {
//        super.prepareLayout()
//        // 这个方法是在viewDidLayoutSubview之后调用的，所以这时候collectionView的大小才是正确的
//        itemW = itemSize.width
//        itemH = itemSize.height
//        collectionViewW = CGRectGetWidth((collectionView?.frame)!)
//        // 取出按默认位置一行应该有几个item
//        numberOfItemsInRow = (super.layoutAttributesForElementsInRect(CGRectMake(0, 0, collectionViewW - sectionInset.left - sectionInset.right, itemH))?.count)!
//        
//        if numberOfItemsInRow <= 3 {
//            numberOfItemsInRow = 3 //这里必须加这一句判断，否则当cell个数小于3时会出问题
//        }
//    }
}
