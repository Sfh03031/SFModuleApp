//
//  AppDelegate_GDP.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/6/3.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import GDPerformanceView_Swift

extension AppDelegate {
    
    /// Shows FPS, CPU and memory usage, device model, app and iOS versions above the status bar and report FPS, CPU and memory usage via delegate.
    func ConfigGDP() {
//#if DEBUG
        PerformanceMonitor.shared().start()
//        PerformanceMonitor.shared().pause()
        PerformanceMonitor.shared().hide()
        
        // performance - CPU usage and FPS.
        // memory - Memory usage.
        // application - Application version with build number.
        // device - Device model.
        // system - System name with version.
        
        // By default, set of [.performance, .application, .system] options is used.
        PerformanceMonitor.shared().performanceViewConfigurator.options = .default
        
        // dark - Black background, white text.
        // light - White background, black text.
        // custom - You can set background color, border color, border width, corner radius, text color and font.
        // By default, dark style is used.
        PerformanceMonitor.shared().performanceViewConfigurator.style = .light
        
        // Also you can override prefersStatusBarHidden and preferredStatusBarStyle to match your expectations:
//        PerformanceMonitor.shared().statusBarConfigurator.statusBarHidden = false
//        PerformanceMonitor.shared().statusBarConfigurator.statusBarStyle = .lightContent
        
        PerformanceMonitor.shared().delegate = self
        
//#endif
    }
    
}

extension AppDelegate: PerformanceMonitorDelegate {
    
    //FIXME: 此方法会在app运行期间一直调用
    func performanceMonitor(didReport performanceReport: GDPerformanceView_Swift.PerformanceReport) {
//        print(performanceReport.cpuUsage, performanceReport.fps, performanceReport.memoryUsage.used, performanceReport.memoryUsage.total)
    }
    
}


