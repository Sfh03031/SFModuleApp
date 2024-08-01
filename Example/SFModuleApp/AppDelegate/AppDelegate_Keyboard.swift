//
//  AppDelegate_Keyboard.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/11.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift

extension AppDelegate {
    
    /// 键盘管理
    func ConfigKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "完成"
    }
}
