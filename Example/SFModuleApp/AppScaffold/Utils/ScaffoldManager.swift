//
//  ScaffoldManager.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/16.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import Toast_Swift
import WhatsNew
import PopMenu

public class ScaffoldManager: NSObject {

    static let shared = ScaffoldManager()
    
    func ShowVC(self: UIViewController?, type: String?, name: String?) {
        let ktype = Int(type ?? "0")
        switch ktype {
        case 0:
            let vc = SFServiceSettingVC()
            vc.title = name
            self?.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = SparkViewController()
            vc.title = name
            self?.sf.push(vc, animated: true)
//        case 2:
//            let vc = CLCameraController()
//            vc.delegate = self
//            self.sf.present(vc)
        case 3:
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
                self?.present(vc, animated: false)
            }
            
            vc.backBlock = {[weak self] dic in
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
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                
            }
        case 4:
            let vc = ColorsVC()
            vc.title = name
            self?.sf.push(vc)
        case 5:
            let vc = SLB_LearnDataVC()
            vc.title = name
            self?.sf.push(vc)
        case 6:
            let vc = FSPagerViewVC()
            vc.title = name
            self?.sf.push(vc)
        case 7:
            let vc = EmptyVC()
            vc.title = name
            self?.sf.push(vc)
        case 8:
            let vc = PMRootViewController()
            vc.title = name
            self?.sf.push(vc)
        case 9:
            let vc = JXScratchVC()
            vc.title = name
            self?.sf.push(vc)
        case 10:
            let vc = HCSStarRatingVC()
            vc.title = name
            self?.sf.push(vc)
        case 11:
            let vc = GifViewController()
            vc.title = name
            self?.sf.push(vc)
        case 12:
            let vc = GeneratorController()
            vc.title = name
            self?.sf.push(vc)
        case 13:
            let vc = SkeletonVC()
            vc.title = name
            self?.sf.push(vc)
        case 14:
            let vc = SkeletonVC()
            vc.title = name
            vc.isShowAni = true
            self?.sf.push(vc)
        case 15:
            let vc = MarqueeVC()
            vc.title = name
            self?.sf.push(vc)
        case 16:
            let vc = NotificationBannerVC()
            vc.title = name
            self?.sf.push(vc)
        case 17:
            let vc = SpreadSheetVC()
            vc.title = name
            self?.sf.push(vc)
        case 18:
            let vc = ShimmerVC()
            vc.title = name
            self?.sf.push(vc)
        case 19:
            // JDStatusBarNotification示例使用的SwiftUI，有些api方法iOS14或以上版本才有，故单起了一个App用协议的方式打开示例页面
            let url = "JDStatusBarNotification://org.SFModuleApp.JDStatusBarNotification.ViewController?act=present"
            if UIApplication.shared.canOpenURL(URL.init(string: url)!) {
                UIApplication.shared.open(URL.init(string: url)!)
            } else {
                WINDOW?.makeToast("模块缺失", position: .center)
            }
        case 20:
            let vc = NVActivityIndicatorViewVC()
            vc.title = name
            self?.sf.push(vc)
        case 21:
            let vc = DemoListViewController()
            vc.title = name
            self?.sf.push(vc)
        case 22:
            let vc = FluidSliderVC()
            vc.title = name
            self?.sf.push(vc)
        case 23:
            let vc = FoldingCellVC()
            vc.title = name
            self?.sf.push(vc)
        case 24:
            let vc = LTMorphingLabelVC()
            vc.title = name
            self?.sf.push(vc)
        case 25:
            let vc = SplitflapVC()
            vc.title = name
            self?.sf.push(vc)
        case 26:
            let vc = GlitchLabelVC()
            vc.title = name
            self?.sf.push(vc)
        case 27:
            let vc = FontBlasterTableVC()
            vc.title = name
            self?.sf.push(vc)
        case 28:
            let vc = FlagsListViewController()
            vc.title = name
            self?.sf.push(vc)
        case 29:
            let vc = ActiveLabelVC()
            vc.title = name
            self?.sf.push(vc)
        case 30:
            let vc = CountdownLabelVC()
            vc.title = name
            self?.sf.push(vc)
        case 31:
            let vc = ExpandLabelVC()
            vc.title = name
            self?.sf.push(vc)
//        case 32:
//            let manager = PopMenuManager.default
//            
//            manager.actions = [
//                PopMenuDefaultAction(title: "CrossFade", image: SFSymbol.symbol(name: "line.3.crossed.swirl.circle.fill"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)),
//                PopMenuDefaultAction(title: "Cube", image: SFSymbol.symbol(name: "shippingbox.fill"), color: #colorLiteral(red: 0.9816910625, green: 0.5655395389, blue: 0.4352460504, alpha: 1)),
//                PopMenuDefaultAction(title: "Linear", image: SFSymbol.symbol(name: "pencil.and.outline"), color: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)),
//                PopMenuDefaultAction(title: "Page", image: SFSymbol.symbol(name: "figure.walk.motion"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)),
//                PopMenuDefaultAction(title: "Parallax", image: SFSymbol.symbol(name: "paragraphsign"), color: #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)),
//                PopMenuDefaultAction(title: "RotateInOut", image: SFSymbol.symbol(name: "crop.rotate"), color: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)),
//                PopMenuDefaultAction(title: "SnapIn", image: SFSymbol.symbol(name: "link.circle.fill"), color: #colorLiteral(red: 0.9816910625, green: 0.5655395389, blue: 0.4352460504, alpha: 1)),
//                PopMenuDefaultAction(title: "ZoomInOut", image: SFSymbol.symbol(name: "fan.oscillation"), color: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)),
//            ]
//
//            manager.popMenuAppearance.popMenuFont = UIFont(name: "AvenirNext-DemiBold", size: 16)!
//            manager.popMenuAppearance.popMenuBackgroundStyle = .blurred(.light)
//            manager.popMenuShouldDismissOnSelection = true
//            manager.popMenuDelegate = self
//            
//            manager.present()
        case 33:
            let vc = BouncyTableVC()
            vc.title = name
            self?.sf.push(vc)
        case 34:
            let vc = WatchdogVC()
            vc.title = name
            self?.sf.push(vc)
        case 35:
            let url = "qmui://com.molice.test"
            if UIApplication.shared.canOpenURL(URL.init(string: url)!) {
                UIApplication.shared.open(URL.init(string: url)!)
            } else {
                WINDOW?.makeToast("模块缺失", position: .center)
            }
        case 36:
            let vc = LFLiveKitVC()
            vc.modalPresentationStyle = .fullScreen
            self?.sf.present(vc)
        case 37:
            let vc = TwinkleVC()
            vc.title = name
            self?.sf.push(vc)
        case 38:
            let vc = TableHeadAutoScaleVC()
            vc.title = name
            self?.sf.push(vc)
        case 39:
            let whatsNew = WhatsNewViewController(items: [
                WhatsNewItem.image(title: "Nice Icons", subtitle: "Completely customize colors, texts and icons.", image: SFSymbol.symbol(name: "line.3.crossed.swirl.circle.fill", tintColor: .random)!),
                WhatsNewItem.image(title: "Such Easy", subtitle: "Setting this up only takes 2 lines of code, impressive you say?", image: SFSymbol.symbol(name: "shippingbox.fill", tintColor: .random)!),
                WhatsNewItem.image(title: "Very Sleep", subtitle: "It helps you get more sleep by writing less code.", image: SFSymbol.symbol(name: "fan.oscillation", tintColor: .random)!),
                WhatsNewItem.text(title: "Text Only", subtitle: "No icons? Just go with plain text."),
            ])
            whatsNew.modalPresentationStyle = .fullScreen
            whatsNew.presentationOption = .debug
            whatsNew.presentIfNeeded(on: self!)
        case 40:
            let vc = SFFoucsFlowLayoutVC()
            vc.title = name
            self?.sf.push(vc)
        case 41:
            let vc = IBPCollectionViewCompositionalLayoutVC()
            vc.title = name
            self?.sf.push(vc)
        case 42:
            let vc = AlignedCollectionViewFlowLayoutVC()
            vc.title = name
            self?.sf.push(vc)
        case 43:
            let vc = SlantedLayoutVC()
            vc.title = name
            self?.sf.push(vc)
        case 44:
            let vc = VerticalCardSwiperVC()
//            vc.title = name
            self?.sf.push(vc)
        case 45:
            let vc = GravitySliderVC()
            vc.title = name
            self?.sf.push(vc)
        case 46:
            let vc = CarLensVC()
            vc.title = name
            self?.sf.push(vc)
        case 47:
            let vc = UPCarouselVC()
            vc.title = name
            self?.sf.push(vc)
        case 48:
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: (SCREENW - 30) / 2, height: (SCREENW - 30) / 2)
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(all: 10)
            let vc = WaveFirstCollectionVC.init(collectionViewLayout: layout)
            vc.title = name
            self?.sf.push(vc)
        case 49:
            let vc = SwipeCellVC()
            vc.title = name
            self?.sf.push(vc)
        case 50:
            let vc = BadgeVC()
            vc.title = name
            self?.sf.push(vc)
        case 51:
            let vc = RulerPickerVC()
            vc.title = name
            self?.sf.push(vc)
        case 52:
            let vc = TimeLineVC()
            vc.title = name
            self?.sf.push(vc)
        case 53:
            let vc = FaveButtonVC()
            vc.title = name
            self?.sf.push(vc)
        case 54:
            let vc = LiquidFloatingVC()
            vc.title = name
            self?.sf.push(vc)
        case 55:
            let vc = FloatyVC()
            vc.title = name
            self?.sf.push(vc)
        case 56:
            let vc = LGLoginVC()
            vc.title = name
            self?.sf.push(vc)
        case 57:
            let vc = TransitionButtonVC()
            vc.title = name
            self?.sf.push(vc)
        case 58:
            let vc = CircleMenuVC()
            vc.title = name
            self?.sf.push(vc)
        case 59:
            let vc = TagListViewVC()
            vc.title = name
            self?.sf.push(vc)
        case 60:
            let vc = RadarAnimationVC()
            vc.title = name
            self?.sf.push(vc)
        case 61:
            let vc = WaterWaveVC()
            vc.title = name
            self?.sf.push(vc)
        case 62:
            let vc = GradientLoadingBarVC()
            vc.title = name
            self?.sf.push(vc)
        case 63:
            let vc = NumberMorphVC()
            vc.title = name
            self?.sf.push(vc)
        case 64:
            let vc = SAConfettiViewVC()
            vc.title = name
            self?.sf.push(vc)
        case 65:
            let vc = VisualEffectVC()
            vc.title = name
            self?.sf.push(vc)
        case 66:
            let vc = PulsatorVC()
            vc.title = name
            self?.sf.push(vc)
        case 67:
            let vc = SwitchListVC()
            vc.title = name
            self?.sf.push(vc)
        case 68:
            let vc = PopTipVC()
            vc.title = name
            self?.sf.push(vc)
        case 69:
            let vc = MultiProgressVC()
            vc.title = name
            self?.sf.push(vc)
        case 70:
            let vc = HGCircularSliderVC()
            vc.title = name
            self?.sf.push(vc)
        case 71:
            let vc = SwitchThemeVC()
            vc.title = name
            self?.sf.push(vc)
        case 72:
            let vc = BackgroundTaskVC()
            vc.title = name
            self?.sf.push(vc)
        case 73:
            let vc = PerformanceMonitorVC()
            vc.title = name
            self?.sf.push(vc)
        case 74:
            let vc = PYSearchExampleVC()
            vc.title = name
            self?.sf.push(vc)
        default:
            
            break
        }
    }
}
