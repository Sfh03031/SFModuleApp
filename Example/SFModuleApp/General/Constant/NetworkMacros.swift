//
//  URLConstant.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/16.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

/// 请求根地址
public var HOST_URL: String { return getRequestHostUrl() }

/// M站根地址
public var M_HOST_URL: String { return getMHostUrl() }

/// 网络请求地址
public let HOST_URL_DEV = "https://apidev.sparke.cn/"
public let HOST_URL_DEV1 = "https://apidev1.sparke.cn/"
public let HOST_URL_DEV2 = "https://apidev2.sparke.cn/"
public let HOST_URL_TEST = "https://apitest.sparke.cn/"
public let HOST_URL_RELEASE = "https://api2.sparke.cn/"

/// M站地址
public let M_URL_DEV = "https://mdev.sparke.cn"
public let M_URL_TEST = "https://mtest.sparke.cn"
public let M_URL_RELEASE = "https://m.sparke.cn"

/// 根地址key
public let kUrlHostKey = "BASE_URL_HOST"

/// 获取请求地址，默认dev
fileprivate func getRequestHostUrl() -> String {
    if let url = UserDefaults.standard.object(forKey: kUrlHostKey) as? String {
        return url
    } else {
        UserDefaults.standard.setValue(HOST_URL_DEV, forKey: kUrlHostKey)
        UserDefaults.standard.synchronize()
        return HOST_URL_DEV
    }
}

/// 获取M站地址，随根地址的变化而变化
fileprivate func getMHostUrl() -> String {
    let value = getRequestHostUrl()
    if value == HOST_URL_TEST {
        return M_URL_TEST
    } else if value == HOST_URL_RELEASE {
        return M_URL_RELEASE
    } else {
        return M_URL_DEV
    }
}
