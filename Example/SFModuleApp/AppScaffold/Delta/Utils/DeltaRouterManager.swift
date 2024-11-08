//
//  DeltaRouterManager.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/25.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import JohnWick

class DeltaRouterManager: NSObject {
    
    public static let shared = DeltaRouterManager()
    
    func toTargetVC(_ key: String, name: String) {
        switch key {
        case "D-Font-0":
            let vc = FontsVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Font-1":
            let vc = FontBlasterTableVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Color-0":
            let vc = FrequentlyUsedColorVC(collectionViewLayout: FlowLayoutManager.shared.makeFlowLayout(itemSize: CGSize(width: (SCREENW - 30) / 2, height: 120)))
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Color-1":
            let vc = ChineseColorVC(collectionViewLayout: FlowLayoutManager.shared.makeFlowLayout(itemSize: CGSize(width: (SCREENW - 30) / 2, height: 120)))
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Color-2":
            let vc = PanTongColorVC(collectionViewLayout: FlowLayoutManager.shared.makeFlowLayout(itemSize: CGSize(width: (SCREENW - 30) / 2, height: 120)))
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Color-3":
            let vc = GradientColorVC(collectionViewLayout: FlowLayoutManager.shared.makeFlowLayout(itemSize: CGSize(width: (SCREENW - 30) / 2, height: 120)))
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Color-4":
            let vc = MatchColorVC(collectionViewLayout: FlowLayoutManager.shared.makeFlowLayout(itemSize: CGSize(width: (SCREENW - 30) / 2, height: 120)))
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-View-0":
            let vc = JXScratchVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-View-1":
            let vc = HCSStarRatingVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-View-2":
            let vc = ShimmerVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-View-3":
            let vc = NVIndicatorVC(collectionViewLayout: FlowLayoutManager.shared.makeFlowLayout(itemSize: CGSize(width: (SCREENW - 40) / 3, height: (SCREENW - 40) / 3)))
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-View-4":
            let vc = TwinkleVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-View-5":
            let vc = RulerPickerVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-View-6":
            let vc = TimeLineVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-View-7":
            let vc = TagListViewVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-View-8":
            let vc = RadarAnimationVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-View-9":
            let vc = WaterWaveVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-View-10":
            let vc = GradientLoadingBarVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-View-11":
            let vc = NumberMorphVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-View-12":
            let vc = SAConfettiViewVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-View-13":
            let vc = VisualEffectVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-View-14":
            let vc = PulsatorVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-View-15":
            let vc = PopTipVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-View-16":
            let vc = MultiProgressVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Button-0":
            let vc = FaveButtonVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Button-1":
            let vc = LiquidFloatingVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Button-2":
            let vc = FloatyVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Button-3":
            let vc = LGLoginVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Button-4":
            let vc = TransitionButtonVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Label-0":
            let vc = MarqueeVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Label-1":
            let vc = LTMorphingLabelVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Label-2":
            let vc = SplitflapVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Label-3":
            let vc = GlitchLabelVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Label-4":
            let vc = ActiveLabelVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Label-5":
            let vc = CountdownLabelVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Label-6":
            let vc = ExpandLabelVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Image-0":
            let vc = GifViewController()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Slider-0":
            let vc = FluidSliderVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Slider-1":
            let vc = HGCircularSliderVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Switch-0":
            let vc = SwitchListVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Charts-0":
            let vc = SLB_LearnDataVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Charts-1":
            let vc = SpreadSheetVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Charts-2":
            let vc = DemoListViewController()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Menu-0":
            let vc = PMRootViewController()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Menu-1":
            let vc = CircleMenuVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Animator-1":
            let vc = SkeletonVC()
            vc.title = name
            vc.isShowAni = true
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Picker-0":
            let vc = FilePickerVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Picker-1":
            let vc = AddressPickerVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Picker-2":
            let vc = DatePickerVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Picker-3":
            let vc = TagPickerVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
        case "D-Picker-4":
            let vc = SelfDefineVC()
            vc.title = name
            SF.visibleVC?.navigationController?.pushViewController(vc, animated: true)
            break
            
        default:
            break
        }
    }
}
