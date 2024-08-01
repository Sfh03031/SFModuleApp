//
//  AppDelegate_Gagat.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/6/7.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
//import Gagat

extension AppDelegate {
    
    /// 双指下滑切换主题
    func ConfigGagat() {
        let config = Gagat.Configuration(jellyFactor: 3.5)
        let tab = window!.rootViewController as! SparkTabBarController
        let nav = tab.selectedViewController as! BaseNavigationController
        transitionHandle = Gagat.configure(for: window!, with: nav, using: config)
    }
}
