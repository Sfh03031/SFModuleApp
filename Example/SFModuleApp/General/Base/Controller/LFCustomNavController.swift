//
//  LFCustomNavController.swift
//  SparkBase
//
//  Created by 宋时成 on 2024/1/18.
//  Copyright © 2024 Spark. All rights reserved.
//

import UIKit
 
class LFCustomNavController: LFBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        if #available(iOS 15.0, *) {
            let newAppearance = UINavigationBarAppearance()
            newAppearance.configureWithOpaqueBackground()
            newAppearance.backgroundColor = .white
            newAppearance.shadowImage = UIImage()
            newAppearance.shadowColor = nil
  
            self.navigationController?.navigationBar.standardAppearance = newAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = newAppearance
        }
    }

}
