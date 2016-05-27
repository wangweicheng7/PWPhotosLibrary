//
//  PWPhotoGroupViewController.swift
//  PWPhotosLibrary
//
//  Created by 王炜程 on 16/5/26.
//  Copyright © 2016年 weicheng wang. All rights reserved.
//

import UIKit
import Photos

class PWPhotoGroupViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    private var resultArr = [PHAssetCollection]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(UINib(nibName: "PWPhotoGroupCell", bundle: nil), forCellReuseIdentifier: idePhotoGroupCell)
        
        PWPhotosManager.album { (resultArr) in
            self.resultArr += resultArr
            self.tableView.reloadData()
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(idePhotoGroupCell, forIndexPath: indexPath) as! PWPhotoGroupCell
        cell.setResult(resultArr[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 82
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let photoVC = PWPhotoViewController()
        photoVC.assetCollection = resultArr[indexPath.row]
        
        
        navigationController?.pushViewController(photoVC, animated: true)
    }

}
