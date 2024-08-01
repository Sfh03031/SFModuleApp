//
//  SparkHUD.swift
//  SparkBase
//
//  Created by sfh on 2024/4/1.
//  Copyright © 2024 Spark. All rights reserved.
//

import Foundation

public enum SparkHUD {
    
    /// 错误提示
    public static func showError(withStatus: String?) {
        // 过滤
        if let msg = withStatus, msg.contains("似乎已断开与互联网的连接。") { return }
        
        SVProgressHUD.showError(withStatus: withStatus)
    }
}
