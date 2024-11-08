//
//  SelfDefineVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/22.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import JohnWick
import SFStyleKit

class SelfDefineVC: BaseViewController {

    fileprivate var titles: [String] = [
        "每日任务",
        "直播列表",
        "回放列表",
        "词汇通关",
        "词汇特训",
        "课程服务",
        "每日任务-听",
        "直播列表-说",
        "回放列表-读",
        "词汇通关-写",
        "词汇特训-练",
        "课程服务-通",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .hex_F5F5F9
        
        self.view.addSubview(AlphaBtn)
        AlphaBtn.center = self.view.center
    }
    
    func tapBtn() {
        SFPickerVC(titles) { index, value in
            SF.WINDOW?.makeToast("\(index) - \(value)")
        }.show()
    }

    lazy var AlphaBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.sf.backgroundColor(.random).frame(CGRect(x: 0, y: 0, width: 200, height: 50)).title("tap").tintColor(.white).titleFont(UIFont.systemFont(ofSize: 16.0, weight: .medium)).makeRadius(5.0).addTapAction { view in
            self.tapBtn()
        }
        return btn
    }()

}
