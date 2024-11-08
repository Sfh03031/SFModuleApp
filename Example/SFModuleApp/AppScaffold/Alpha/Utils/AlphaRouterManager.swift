//
//  AlphaRouterManager.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/23.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import JohnWick
import WhatsNew
import SFServiceKit

class AlphaRouterManager: NSObject {

    public static let shared = AlphaRouterManager()
    
    func toTargetVC(_ key: String, name: String) {
        switch key {
        case "A-0":
            let vc = ServiceSettingVC(collectionViewLayout: FlowLayoutManager.shared.makeFlowLayout(itemSize: CGSize(width: SCREENW - 20, height: 80)))
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "A-1":
            let vc = SparkViewController()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "A-2":
            let vc = FSPagerViewVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "A-3":
            let vc = EmptyVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "A-4":
            let vc = SkeletonVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "A-5":
            let vc = WatchdogVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "A-6":
            let whatsNew = WhatsNewViewController(items: [
                WhatsNewItem.image(title: "标题一", subtitle: "完全自定义的颜色、文字和图标。", image: SFSymbolManager.shared.symbol(systemName: "line.3.crossed.swirl.circle.fill", withConfiguration: nil, withTintColor: .random)!),
                WhatsNewItem.image(title: "标题二", subtitle: "只需两行代码即可实现效果，牛逼不？", image: SFSymbolManager.shared.symbol(systemName: "shippingbox.fill", withConfiguration: nil, withTintColor: .random)!),
                WhatsNewItem.image(title: "标题三", subtitle: "它能帮你用更少的代码快速的构建应用。", image: SFSymbolManager.shared.symbol(systemName: "fan.oscillation", withConfiguration: nil, withTintColor: .random)!),
                WhatsNewItem.text(title: "标题四", subtitle: "天上白玉京，十二楼五重。"),
            ])
            whatsNew.modalPresentationStyle = .fullScreen
            whatsNew.presentationOption = .debug
            whatsNew.presentIfNeeded(on: SF.visibleVC!)
            break
        case "A-7":
            let vc = SwitchThemeVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "A-8":
            let vc = BgTaskVC(collectionViewLayout: FlowLayoutManager.shared.makeFlowLayout())
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "A-9":
            let vc = PerfMonitorVC(collectionViewLayout: FlowLayoutManager.shared.makeFlowLayout(itemSize: CGSize(width: (SCREENW - 40) / 3, height: 60)))
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "A-10":
            let vc = RotatorVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "A-11":
            let vc = CryptoVC(collectionViewLayout: FlowLayoutManager.shared.makeFlowLayout())
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "A-12":
            let vc = RotatorVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
    }
}
