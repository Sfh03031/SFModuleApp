//
//  AppDelegate_Monitor.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/11.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import SFNetworkMonitor

extension AppDelegate {
    
    /// 监听网络状态
    func ConfigNetMonitor() {
        SFNetworkMonitor.shared.monitoring(useClosures: true)
        SFNetworkMonitor.shared.isShowAlertWhenNoNet = true
    }
}
