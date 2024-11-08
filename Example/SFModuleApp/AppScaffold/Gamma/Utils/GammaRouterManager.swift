//
//  GammaRouterManager.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/11/5.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import JohnWick
import ScreenRotator

class GammaRouterManager: NSObject {
    
    public static let shared = GammaRouterManager()
    
    func toTargetVC(_ key: String, name: String) {
        switch key {
        case "G-1":
//            let image = self.playView.getCurrentBufferImage()
            let image = UIImage.init(named: "Kobe.jpg")!
            
            let vc = SF_KYTakeNotesVC()
            vc.courseKey = "网课key"
            vc.videoKey = "小节key"
            vc.TNImage = image
            vc.isfrom = "0"
            vc.modalPresentationStyle = .fullScreen
            
            ScreenRotator.shared.rotationToLandscapeLeft()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                SF.visibleVC?.present(vc, animated: true)
            }
            
            vc.backBlock = { dic in
                let image = dic["image"] as? UIImage ?? nil
                let fontSize = dic["fontSize"] as? String ?? ""
                let lineWidth = dic["lineWidth"] as? String ?? ""
                let color = dic["color"] as? String ?? ""
                let info = "字号: \(fontSize), 线宽: \(lineWidth), 色值: \(color)"
                
                let vc = CLCameraResultVC()
                vc.image = image
                vc.intrStr = info
                
                ScreenRotator.shared.rotationToPortrait()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
                }
            }
            break
        case "G-2":
            let vc = GeneratorController()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "G-3":
            let vc = NotificationBannerVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "G-4":
            // JDStatusBarNotification示例使用的SwiftUI，有些api方法iOS14及以上版本才有，故单起了一个App用协议的方式打开示例页面
            let url = "JDStatusBarNotification://org.SFModuleApp.JDStatusBarNotification.ViewController?act=present"
            if UIApplication.shared.canOpenURL(URL.init(string: url)!) {
                UIApplication.shared.open(URL.init(string: url)!)
            } else {
                SF.WINDOW?.makeToast("模块缺失", position: .center)
            }
            break
        case "G-5":
            let vc = FlagsListViewController()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "G-6":
            let url = "qmui://com.molice.test"
            if UIApplication.shared.canOpenURL(URL.init(string: url)!) {
                UIApplication.shared.open(URL.init(string: url)!)
            } else {
                SF.WINDOW?.makeToast("模块缺失", position: .center)
            }
            break
        case "G-7":
            let vc = LFLiveKitVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "G-8":
            let vc = PYSearchExampleVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
    }
}
