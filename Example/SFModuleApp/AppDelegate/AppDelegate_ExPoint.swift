//
//  AppDelegate_ExPoint.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/15.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    /// 针对某特定VC禁用第三方，强制使用系统内置。(键盘)
    func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool {
        for vc in (self.window?.rootViewController?.children)! {
            if vc.isKind(of: UINavigationController.self) {
                for vc1 in vc.children {
                    // 找到特定的VC
                    if vc1.isKind(of: UIViewController.self) {
                        return false
                    }
                }
            }
        }

        return true
    }
}
