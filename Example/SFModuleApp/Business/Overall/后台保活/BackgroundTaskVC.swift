//
//  BackgroundTaskVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/6/14.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class BackgroundTaskVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(startBtn)
        self.view.addSubview(stopBtn)
        
        startBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 200, height: 60))
            make.top.equalTo(120)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        stopBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 200, height: 60))
            make.top.equalTo(220)
            make.centerX.equalTo(self.view.snp.centerX)
        }
    }
    
    @objc func start(_ sender: UIButton) {
        UserDefaults.standard.setValue("1", forKey: "BgTask")
        UserDefaults.standard.synchronize()
        exit(0)
    }
    
    @objc func stop(_ sender: UIButton) {
        UserDefaults.standard.setValue("0", forKey: "BgTask")
        UserDefaults.standard.synchronize()
        exit(0)
    }
    

    lazy var startBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("重启开启保活", for: .normal)
        btn.setTitleColor(.random, for: .normal)
        btn.addTarget(self, action: #selector(start(_:)), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var stopBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("重启关闭保活", for: .normal)
        btn.setTitleColor(.random, for: .normal)
        btn.addTarget(self, action: #selector(stop(_:)), for: .touchUpInside)
        return btn
    }()
}
