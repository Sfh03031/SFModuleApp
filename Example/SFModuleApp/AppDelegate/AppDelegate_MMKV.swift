//
//  AppDelegate_MMKV.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/15.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import MMKV

extension AppDelegate {
    
    /// 初始化MMKV
    func initDefaultMMKV() {
        let paths = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)
        guard let path = paths.first, path.count > 0 else {
            MMKV.initialize(rootDir: nil)
            return
        }
        let rootDir = path.appending("/sparkmmkv")
        //FIXME: 需要在developer的bundleid下配置AppGroup
        let groupId = "group.spark.mmkv"
        guard let groupDir = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupId)?.path else {
            MMKV.initialize(rootDir: nil)
            return
        }
        MMKV.initialize(rootDir: rootDir, groupDir: groupDir, logLevel: .info, handler: self)
        
//        let mmkv = MMKV.init(mmapID: "multi_process", mode: .multiProcess)
//
//        print("multi_process phone: \(String(describing: mmkv?.string(forKey: "phone")))")
//        print("multi_process userId: \(String(describing: mmkv?.string(forKey: "userId")))")
//        print("multi_process password: \(String(describing: mmkv?.string(forKey: "password")))")

    }
}

extension AppDelegate: MMKVHandler {
    
    func onMMKVCRCCheckFail(_ mmapID: String!) -> MMKVRecoverStrategic {
        return .onErrorRecover
    }
    
    func onMMKVFileLengthError(_ mmapID: String!) -> MMKVRecoverStrategic {
        return .onErrorRecover
    }
    
    func onMMKVContentChange(_ mmapID: String!) {
        print("onMMKVContentChange: \(String(describing: mmapID))")
    }
    
    func mmkvLog(with level: MMKVLogLevel, file: UnsafePointer<CChar>!, line: Int32, func funcname: UnsafePointer<CChar>!, message: String!) {
        var des: String = ""
        switch level {
        case .debug:
            des = "D"
            break
        case .info:
            des = "I"
            break
        case .error:
            des = "E"
            break
        case .warning:
            des = "W"
            break
        default:
            des = "N"
            break
        }
        
        print("redirect logging [\(des)] <\(String(describing: file)):\(line)::\(String(describing: funcname))> \(String(describing: message))")
    }
}
