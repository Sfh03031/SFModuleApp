//
//  SparkTabBarController.swift
//  SparkBase
//
//  Created by sfh on 2023/12/22.
//  Copyright © 2023 Spark. All rights reserved.
//

import UIKit

class SparkTabBarController: CYLTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            let line: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 1))
            line.backgroundColor = UIColor.sf.hexColor(hex: "#F5F6F9")
            self.tabBar.addSubview(line)
            self.tabBar.shadowImage = UIImage()
            self.tabBar.backgroundImage =  UIImage()
        } else {
            let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: 1))
            view.backgroundColor = UIColor.sf.hexColor(hex: "#F5F6F9")
            self.tabBar.shadowImage = view.sf.screenShot()
        }

        tabBar.unselectedItemTintColor = UIColor.sf.hexColor(hex: "#222222")
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor.sf.hexColor(hex: "#008AFF")
        tabBar.isTranslucent = false
    }
    

    //MARK: - 转屏相关
    
    override var shouldAutorotate: Bool{
        return self.selectedViewController!.shouldAutorotate
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
            return self.selectedViewController?.supportedInterfaceOrientations ?? UIInterfaceOrientationMask.portrait
    }
 
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return self.selectedViewController!.preferredInterfaceOrientationForPresentation
    }

}
