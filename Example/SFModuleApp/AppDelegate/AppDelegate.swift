//
//  AppDelegate.swift
//  SFModuleApp
//
//  Created by Sfh03031 on 04/07/2024.
//  Copyright (c) 2024 Sfh03031. All rights reserved.
//

import UIKit
import Watchdog
import SFServiceKit
import ScreenRotator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // 看门狗
    var watchdog: Watchdog!
    // tabbar模型
    var tabModel: tabInfoModel?
    // 双指动画
    var transitionHandle: Gagat.TransitionHandle!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 看门狗
        ConfigWatchdog()

        // 监听网络状态
        ConfigNetMonitor()
        
        // UITableView统一设置
        ConfigTableView()
        
        // 控制键盘
        ConfigKeyboard()
        
        // 模拟器热重载
        ConfigInjection()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        // 设置根控制器
        ConfigTabBarController()
        
        // 设置Gagat
        ConfigGagat()
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return ScreenRotator.shared.orientationMask
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        if let isBgTask = UserDefaults.standard.object(forKey: "BgTask") as? String, isBgTask == "1" {
            //MARK: 开启后台保活，保活时长2小时，超时自动停止保活
            SFBackgroundTaskManager.shared.start(2, isAutoStop: true)
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        //MARK: 显示FPS、CPU等信息
        ConfigGDP()
        
        //MARK: 停止后台保活
        SFBackgroundTaskManager.shared.stop()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

