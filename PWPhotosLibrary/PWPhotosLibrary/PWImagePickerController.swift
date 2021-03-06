//
//  PWImagePickerController.swift
//  PWPhotosLibrary
//
//  Created by 王炜程 on 16/5/26.
//  Copyright © 2016年 weicheng wang. All rights reserved.
//

import UIKit

class PWImagePickerController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let photoGroupVC = PWPhotoGroupViewController()
        
        let photoVC = PWPhotoViewController()
        
        viewControllers = [photoGroupVC,photoVC]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
