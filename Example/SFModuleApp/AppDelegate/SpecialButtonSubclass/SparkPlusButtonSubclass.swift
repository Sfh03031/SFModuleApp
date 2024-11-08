//
//  SparkPlusButtonSubclass.swift
//  SparkBase
//
//  Created by sfh on 2023/12/22.
//  Copyright © 2023 Spark. All rights reserved.
//

import UIKit
import SFStyleKit
import CYLTabBarController
import CTMediator
import JohnWick

class SparkPlusButtonSubclass: CYLPlusButton, CYLPlusButtonSubclassing {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.textAlignment = .center
        self.adjustsImageWhenHighlighted = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imgViewEdgeWith = self.bounds.size.width * 0.7
        let imgViewEdgeHeight = imgViewEdgeWith
        
        let centerOfView = self.bounds.size.width * 0.5
        let labelLineHeight = self.titleLabel?.font.lineHeight
        let verticalMargin = (self.bounds.size.height - labelLineHeight! - imgViewEdgeHeight) *  0.5
        
        // imageView 和 titleLabel 中心的 Y 值
        let centerOfImageView = verticalMargin + imgViewEdgeHeight * 0.5
        let centerOfTitleLabel = imgViewEdgeHeight + verticalMargin * 2 + labelLineHeight! * 0.5 - 1
        
        //imageView position 位置
        self.imageView?.bounds = CGRectMake(0, 0, imgViewEdgeWith, imgViewEdgeHeight)
        self.imageView?.center = CGPointMake(centerOfView, centerOfImageView)
        
        //title position 位置
        self.titleLabel?.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight!)
        self.titleLabel?.center = CGPointMake(centerOfView, centerOfTitleLabel)
        
    }
    
    /// 不规则tabBarItem
    static func plusButton() -> Any {
        let btn = SparkPlusButtonSubclass(type: .custom)
        btn.setImage(UIImage.init(named: "plusBtn_normal"), for: .normal)
        btn.setImage(UIImage.init(named: "plusBtn_selected"), for: .highlighted)
        btn.setImage(UIImage.init(named: "plusBtn_selected"), for: .selected)
        btn.setBackgroundImage(UIImage(named: "plusBtn_bg"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "plusBtn_bg"), for: .selected)
        btn.setTitle("specail", for: .normal)
        btn.setTitleColor(UIColor.sf.hexColor(hex: "#222222"), for: .normal)
        btn.setTitleColor(UIColor.sf.hexColor(hex: "#008AFF"), for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        btn.sizeToFit()
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 83)
        return btn
    }
    
    //FIXME: 已失效了
    /// 不规则tabBarItem点击事件
    static func clickPublish() {}
    
    /// 不规则tabBarItem点击跳转页面
    static func plusChildViewController() -> UIViewController {
        let path = "SFApp://Gamma/toGamma?title=Gamma"
        let pathUrl = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? path
        guard let vc = CTMediator.sharedInstance().openUrl(pathUrl, moduleName: "SFModuleApp_Example", completion: { dic in
            
        }) else {
            SFLog("模块缺失")
            return UIViewController()
        }
        return BaseNavigationController(rootViewController: vc)
    }
    
    /// 不规则tabBarItem位置，默认居中
    static func indexOfPlusButtonInTabBar() -> UInt {
        return 2
    }
    
    /// 调整不规则tabBarItem中心点Y轴方向的位置，建议在按钮超出了 tabbar 的边界时实现该方法。
    /// 返回值是自定义按钮中心点 Y 轴方向的坐标除以 tabbar 的高度，小于 0.5 表示 PlusButton 偏上，大于 0.5 则表示偏下。
    /// PlusButtonCenterY = multiplierOfTabBarHeight * tabBarHeight + constantOfPlusButtonCenterYOffset;
    static func multiplier(ofTabBarHeight tabBarHeight: CGFloat) -> CGFloat {
        return 0.3
    }
    
    /// 大于0会向下偏移，小于0会向上偏移。
    static func constantOfPlusButtonCenterYOffset(forTabBarHeight tabBarHeight: CGFloat) -> CGFloat {
        return 2.5
    }

}
 
