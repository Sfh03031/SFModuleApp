//
//  AppDelegate_Watchdog.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/10.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import Watchdog
import Toast_Swift

extension AppDelegate {
    
    func ConfigWatchdog() {
        watchdog = Watchdog(threshold: 1.25, watchdogFiredCallback: {
            DispatchQueue.main.async {
                self.ConfigTabBarController()
                WINDOW?.makeToast("监控到进程堵塞超过阈值，自动重置进程")
            }
        })
    }
}
