//
//  TransitionButtonVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/27.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class TransitionButtonVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.bottom.equalTo(-60)
            make.height.equalTo(60)
        }
    }
    
    @objc func btnClick(_ sender: TransitionButton) {
        sender.startAnimation()
        
        // 队列优先级 https://www.jianshu.com/p/fc7ac5cd1221
        let qosClass = DispatchQoS.QoSClass.background
        let queue = DispatchQueue.global(qos: qosClass)
        queue.async(execute: {
            sleep(2)
            
            DispatchQueue.main.async {
                sender.stopAnimation(animationStyle: .expand) {
                    let vc = TranstionButtonSecondVC()
                    self.present(vc, animated: true)
                }
            }
        })
    }

    lazy var btn: TransitionButton = {
        let view = TransitionButton()
        view.backgroundColor = .random
        view.setTitle("提交", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        return view
    }()

}
