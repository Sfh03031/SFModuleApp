//
//  LGLoginVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/27.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import LGButton

class LGLoginVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = LGButton()
        btn.bgColor = .random
        //触摸反馈
        btn.showTouchFeedback = true
        //渐变背景
        btn.gradientStartColor = UIColor.red
        btn.gradientEndColor = UIColor.orange
        btn.gradientHorizontal = true
        btn.gradientRotation = 20
        //圆角
        btn.cornerRadius = 10
        btn.fullyRoundedCorners = true
        //边框
        btn.borderColor = UIColor.brown
        btn.borderWidth = 2.0
        //文字
        btn.titleColor = UIColor.white
        btn.titleString = "可自定义的登录按钮：触摸反馈/渐变背景/圆角/边框/文字/水平或垂直布局/两侧图片或icon/间距/阴影/loading样式/内容整体偏左或偏右"
        btn.titleFontName = nil
        btn.titleFontSize = 14.0
        btn.titleNumOfLines = 0
        //是否垂直布局
        btn.verticalOrientation = false
        //左侧icon
        btn.leftIconString = ""
        btn.leftIconFontName = ""
        btn.leftIconFontSize = 14.0
        btn.leftIconColor = .orange
        //左侧图片
        btn.leftImageSrc = SFSymbol.symbol(name: "figure.archery")
        btn.leftImageColor = .blue
        btn.leftImageWidth = 30.0
        btn.leftImageHeight = 30.0
        //右侧icon
//        btn.rightIconString = "done_all"
//        btn.rightIconFontName = "ma"
//        btn.rightIconFontSize = 20.0
//        btn.rightIconColor = .white
        //右侧图片
        btn.rightImageSrc = SFSymbol.symbol(name: "figure.badminton")
        btn.rightImageColor = .green
        btn.rightImageWidth = 30.0
        btn.rightImageHeight = 30.0
        //间距
        btn.spacingLeading = 20.0
        btn.spacingTop = 5.0
        btn.spacingTrailing = 10.0
        btn.spacingBottom = 5.0
        btn.spacingTitleIcon = 10.0
        //阴影
        btn.shadowOffset = CGSize(width: 5.0, height: 5.0)
        btn.shadowColor = .purple
        btn.shadowRadius = 10.0
        btn.shadowOpacity = 0.8
        //loading
        btn.loadingString = "加载中..."
        btn.loadingColor = .white
        btn.loadingFontName = ""
        btn.loadingFontSize = 14.0
        btn.loadingSpinnerColor = .yellow
        //偏左或偏右
        btn.leftAligned = false
        btn.rightAligned = false
        
        btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 300, height: 100))
            make.center.equalTo(self.view.snp.center)
        }
        
        
    }
    
    @objc func btnClick(_ sender: LGButton) {
        sender.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            sender.isLoading = false
            
            SVProgressHUD.showSuccess(withStatus: "登录成功")
            SVProgressHUD.dismiss(withDelay: 1)
        }
    }

}
