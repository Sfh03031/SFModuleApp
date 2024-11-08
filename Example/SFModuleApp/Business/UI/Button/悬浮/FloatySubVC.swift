//
//  FloatySubVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/27.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import Floaty

class FloatySubVC: BaseViewController {
    
    var index: Int = 0
    var dataList:[String] = ["normal", "custom image", "isDraggable", "slideDown", "slideUp", "slideLeft", "fade", "quadCircular", "semiCircular", "fullCircular"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let floaty = Floaty()
        floaty.hasShadow = true
        floaty.paddingX = (SCREENW - 60) / 2
        floaty.paddingY = (SCREENH - TopHeight - SoftHeight - 60) / 2
        
        if index == 0 {
            floaty.paddingY = 100
        }
        
        if index == 1 {
            floaty.buttonImage = UIImage(named: "Plus")
            floaty.paddingY = 100
        }
        
        if index == 2 {
            floaty.isDraggable = true
        }
        
        if index == 3 {
            floaty.openAnimationType = .slideDown
            floaty.paddingY = 100
        }
        
        if index == 4 {
            floaty.openAnimationType = .slideUp
            floaty.paddingY = 100
        }
        
        if index == 5 {
            floaty.openAnimationType = .slideLeft
            floaty.paddingY = 100
        }
        
        if index == 6 {
            floaty.openAnimationType = .fade
            floaty.paddingY = 100
        }
        
//        if index == 7 {
//            floaty.isDraggable = true
//            floaty.openAnimationType = .quadCircular // 扇形
//            floaty.circleAnimationDegreeOffset = 0 // 水平角度偏移量
//            floaty.circleAnimationRadius = 250 // 扇形半径
//            floaty.paddingY = SoftHeight + 20
//            floaty.paddingX = 20
//        }
//        
//        if index == 8 {
//            floaty.isDraggable = true
//            floaty.openAnimationType = .semiCircular // 半环形
//            floaty.circleAnimationDegreeOffset = 10 // 水平角度偏移量
//            floaty.paddingY = (SCREENH - TopHeight - SoftHeight - 60) / 2
//        }
//        
//        if index == 9 {
//            floaty.isDraggable = true
//            floaty.openAnimationType = .fullCircular // 全环形
//            floaty.paddingY = (SCREENH - TopHeight - SoftHeight - 60) / 2
//        }
        
        floaty.addItem(icon: SFSymbol.symbol(name: "figure.american.football"))
        floaty.addItem(title: "只有文字")
        floaty.addItem("文字在左", icon: SFSymbol.symbol(name: "figure.basketball"))
        
        let item1 = FloatyItem()
        item1.title = "文字在右"
        item1.titleLabelPosition = .right
        item1.icon = SFSymbol.symbol(name: "sunset")
        floaty.addItem(item: item1)
        
        let item2 = FloatyItem()
        item2.title = "文字在上"
        item2.titleLabelPosition = .left
        item2.icon = SFSymbol.symbol(name: "signature")
        floaty.addItem(item: item2)
        
        let item3 = FloatyItem()
        item3.title = "文字在下"
        item3.titleLabelPosition = .right
        item3.icon = SFSymbol.symbol(name: "command")
        floaty.addItem(item: item3)
        
        floaty.addItem("点击回调", icon: SFSymbol.symbol(name: "figure.archery")) { item in
            SVProgressHUD.show(withStatus: "触发回调事件")
            SVProgressHUD.dismiss(withDelay: 2)
        }
        
        let item = FloatyItem()
        item.hasShadow = true
        item.buttonColor = .random
        item.circleShadowColor = .red
        item.titleShadowColor = .blue
        item.titleLabelPosition = .right
        item.icon = SFSymbol.symbol(name: "figure.badminton")
        item.title = "自定义样式"
        item.handler = { item in
            self.navigationController?.pushViewController(FloatySubVC(), animated: true)
        }
        floaty.addItem(item: item)
        
        floaty.size = 60
        
        
        floaty.fabDelegate = self
        self.view.addSubview(floaty)
    }
    
}

extension FloatySubVC: FloatyDelegate {
    
    func emptyFloatySelected(_ floaty: Floaty) {}

    func floatyShouldOpen(_ floaty: Floaty) -> Bool { return true }
    
    func floatyWillOpen(_ floaty: Floaty) {}
    
    func floatyDidOpen(_ floaty: Floaty) {}

    func floatyShouldClose(_ floaty: Floaty) -> Bool { return true }
    
    func floatyWillClose(_ floaty: Floaty) {}
    
    func floatyDidClose(_ floaty: Floaty) {}
}
