//
//  BroveRouterManager.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import JohnWick

class BroveRouterManager: NSObject {
    
    public static let shared = BroveRouterManager()
    
    func toTargetVC(_ key: String, name: String) {
        switch key {
        case "B-T-0":
            let vc = TableHeadAutoScaleVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "B-T-1":
            let vc = FoldingCellVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "B-T-2":
            let vc = SwipeCellVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "B-T-3":
            let vc = BadgeVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
//        case "B-C-0":
//            
//            break
        case "B-C-1":
            let vc = BouncyTableVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "B-C-2":
            let vc = SFFoucsFlowLayoutVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "B-C-3":
            let vc = IBPCollectionViewCompositionalLayoutVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "B-C-4":
            let vc = AlignedCollectionViewFlowLayoutVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "B-C-5":
            let vc = SlantedLayoutVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "B-C-6":
            let vc = VerticalCardSwiperVC()
//            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "B-C-7":
            let vc = GravitySliderVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "B-C-8":
            let vc = CarLensVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "B-C-9":
            let vc = UPCarouselVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "B-C-10":
            let vc = WaveFirstCollectionVC.init(collectionViewLayout: FlowLayoutManager.shared.makeFlowLayout(itemSize: CGSize(width: (SCREENW - 30) / 2, height: (SCREENW - 30) / 2)))
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
    }
}
