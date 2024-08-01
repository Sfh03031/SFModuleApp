
//
//  LFBaseViewController.swift
//  SparkBase
//
//  Created by 李凌飞 on 2018/3/12.
//  Copyright © 2018年 李凌飞. All rights reserved.
//

import FDFullscreenPopGesture
import UIKit

class LFBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        if #available(iOS 13.0, *) {
//            UIApplication.shared.statusBarStyle = .darkContent
        }

        view.backgroundColor = .white
        navigationController?.fd_prefersNavigationBarHidden = true
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
        SVProgressHUD.setForegroundColor(UIColor.white)
        // Do any additional setup after loading the view.
        // 全局网络提示
//        let Status = UserDefaults.standard.object(forKey: "NetStatus") as? String;
//        if Status == "None" {
        ////            Alert_Mes(title: "提示", message: "请检查网络", viewcontroll: self);
//            if nonetisShow == false{
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.0) {
//                    self.view.addSubview(self.hiddenView);
//                }
//            }
//        }
    }
    
    /// 空白视图
//    lazy var xh_noDataView: SparkEmptyView = {
//        let view = SparkEmptyView(frame: CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight))
//        return view
//    }()
    
    /// 无网络
//    lazy var xh_noNetView: SparkNoNetworkView = {
//        let view = SparkNoNetworkView(frame: CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight))
//        return view
//    }()
    
    /// 强制横屏
    func forceOrientationLandscape() {
//        let appdelegate = UIApplication.shared.delegate as! AppDelegate
//        if isIPad {
//            appdelegate.isForcePortrait = false
//            appdelegate.isForceLandscape = true
//        }
//        appdelegate.shouldChangeOrientation = true
//        appdelegate.application(UIApplication.shared, supportedInterfaceOrientationsFor: self.view.window)
//        
//        // 强制翻转屏幕，Home键在右边。
//        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
//        // 刷新
//        UIViewController.attemptRotationToDeviceOrientation()
    }
    
    /// 强制竖屏
    func forceOrientationPortrait() {
//        let appdelegate = UIApplication.shared.delegate as! AppDelegate
//        if isIPad {
//            appdelegate.isForcePortrait = true
//            appdelegate.isForceLandscape = false
//        }
//        appdelegate.shouldChangeOrientation = false
//        appdelegate.application(UIApplication.shared, supportedInterfaceOrientationsFor: self.view.window)
//        
//        // 强制翻转屏幕，Home键在右边。
//        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
//        // 刷新
//        UIViewController.attemptRotationToDeviceOrientation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
