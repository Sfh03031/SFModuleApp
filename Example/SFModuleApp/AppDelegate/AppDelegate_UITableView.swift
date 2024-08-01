//
//  AppDelegate_UITableView.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/18.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

extension AppDelegate {
    
    /// 统一设置
    func ConfigTableView() {
        if #available(iOS 11.0, *) {
            UITableView.appearance().contentInsetAdjustmentBehavior = .never
        }
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
        UITableView.appearance().separatorStyle = .none
    }
}
