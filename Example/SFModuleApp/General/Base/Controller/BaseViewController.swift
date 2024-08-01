//
//  BaseViewController.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/16.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SFNetworkMonitor
import FLEX

#if DEBUG
extension UIViewController {
    @objc func injected() {
        viewDidLoad()
    }
}
#endif

/// 控制器当前显示的页面
public enum ViewControllerPageStatus {
    case mainPage
    case visitorPage
    case noNetworkPage
}

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        print(SFNetworkMonitor.shared.netStatus.rawValue)
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(flexTap(_:)))
//        tap.numberOfTapsRequired = 3
//        self.view.isUserInteractionEnabled = true
//        self.view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: Notification.Name("loginSuccess"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goToLogin), name: Notification.Name("goToLogin"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(networkChanged), name: Notification.Name(SFNetworkMonitor.kNotificationNameNetworkChanged), object: nil)
    }
    
    @objc func flexTap(_ sender: UIGestureRecognizer) {
        FLEXManager.shared.showExplorer()
    }
    
    @objc func loginSuccess() {
        
    }
    
    @objc func goToLogin() {
        
    }
    
    @objc func networkChanged() {
        
    }

}
