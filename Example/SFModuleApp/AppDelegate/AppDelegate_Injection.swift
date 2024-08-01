//
//  AppDelegate_Injection.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/11.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

extension AppDelegate {
    
    /// 依赖注入，与InjectionIII配合可实现在模拟器上的热重载
    func ConfigInjection() {
#if DEBUG
        do {
           let injectionBundle = Bundle.init(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")
           if let bundle = injectionBundle{
               try bundle.loadAndReturnError()
           } else {
                debugPrint("Injection 注入失败,未能检测到 Injection")
           }

        } catch {
            debugPrint("Injection 注入失败 \(error)")
        }
#endif
    }
}
