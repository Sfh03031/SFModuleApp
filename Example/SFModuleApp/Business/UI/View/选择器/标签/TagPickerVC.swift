//
//  TagPickerVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/22.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import JohnWick
import SFStyleKit

class TagPickerVC: BaseViewController {
    
    /// 最多选择多少, 0代表无限
    fileprivate var maxNum = 0
    
    fileprivate var titles: [(String, Bool)] = [
        ("每日任务", false),
        ("直播列表", false),
        ("回放列表", true),
        ("词汇通关", false),
        ("词汇特训", false),
        ("课程服务", false),
        ("每日任务-听", false),
        ("直播列表-说", false),
        ("回放列表-读", true),
        ("词汇通关-写", false),
        ("词汇特训-练", false),
        ("课程服务-通", false),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .hex_F5F5F9
        
        self.view.addSubview(AlphaBtn)
        AlphaBtn.center = self.view.center
        self.view.addSubview(BroveBtn)
        BroveBtn.center.x = self.view.center.x
    }
    
    func tapBtn() {
        SFTagPickerVC(titles, maxNum: maxNum) { list in
            SF.WINDOW?.makeToast("\(list)")
        }.show()
    }
    
    func chooseNum() {
        let alert = UIAlertController(title: nil, message: "最多选择多少, 0代表无限", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "0", style: .default, handler: { action in
            self.maxNum = 0
            self.BroveBtn.setTitle("最多选择数: \(self.maxNum)", for: .normal)
        }))
        alert.addAction(UIAlertAction(title: "1", style: .default, handler: { action in
            self.maxNum = 1
            self.BroveBtn.setTitle("最多选择数: \(self.maxNum)", for: .normal)
        }))
        alert.addAction(UIAlertAction(title: "2", style: .default, handler: { action in
            self.maxNum = 2
            self.BroveBtn.setTitle("最多选择数: \(self.maxNum)", for: .normal)
        }))
        alert.addAction(UIAlertAction(title: "3", style: .default, handler: { action in
            self.maxNum = 3
            self.BroveBtn.setTitle("最多选择数: \(self.maxNum)", for: .normal)
        }))
        alert.addAction(UIAlertAction(title: "4", style: .default, handler: { action in
            self.maxNum = 4
            self.BroveBtn.setTitle("最多选择数: \(self.maxNum)", for: .normal)
        }))
        alert.addAction(UIAlertAction(title: "5", style: .default, handler: { action in
            self.maxNum = 5
            self.BroveBtn.setTitle("最多选择数: \(self.maxNum)", for: .normal)
        }))
        alert.addAction(UIAlertAction(title: "6", style: .default, handler: { action in
            self.maxNum = 6
            self.BroveBtn.setTitle("最多选择数: \(self.maxNum)", for: .normal)
        }))
        self.present(alert, animated: true)
    }

    lazy var AlphaBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.sf.backgroundColor(.random).frame(CGRect(x: 0, y: 0, width: 200, height: 50)).title("tap").tintColor(.white).titleFont(UIFont.systemFont(ofSize: 16.0, weight: .medium)).makeRadius(5.0).addTapAction { view in
            self.tapBtn()
        }
        return btn
    }()

    
    lazy var BroveBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.sf.backgroundColor(.random).frame(CGRect(x: 0, y: SCREENH - 100, width: 200, height: 50)).title("最多选择数: \(self.maxNum)").tintColor(.white).titleFont(UIFont.systemFont(ofSize: 16.0, weight: .medium)).makeRadius(5.0).addTapAction { view in
            self.chooseNum()
        }
        return btn
    }()
}
