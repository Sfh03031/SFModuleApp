//
//  TwinkleVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/16.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class TwinkleVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(twinkleBtn)
        
    }
    
    /// 钻石闪耀效果
    @objc func twinkleBtnAction(_ sender: UIButton) {
        twinkleBtn.twinkle()
    }

    lazy var twinkleBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 40, y: 350, width: SCREENW - 80, height: 60)
        btn.backgroundColor = .systemOrange
        btn.setTitle("点击触发钻石闪耀效果", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.addTarget(self, action: #selector(twinkleBtnAction(_:)), for: .touchUpInside)
        return btn
    }()

}
