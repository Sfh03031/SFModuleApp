//
//  WatchdogVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/10.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import UIFontComplete

class WatchdogVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.sf.frame(CGRect(x: 10, y: SCREENH/2 - 60, width: SCREENW - 20, height: 60))
            .text("当前监控阈值为1.25秒，点击模拟卡死2秒")
            .textColor(.red)
            .alignment(.center)
            .makeRadius(10)
            .addTapAction { view in
                Thread.sleep(forTimeInterval: 2)
            }
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.systemBrown.cgColor
        self.view.addSubview(label)
        
    }

}
