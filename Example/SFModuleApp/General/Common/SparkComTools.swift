//
//  SparkComTools.swift
//  SparkBase
//
//  Created by sfh on 2023/12/27.
//  Copyright © 2023 Spark. All rights reserved.
//

import Foundation
import SFStyleKit

public enum SparkComTools {
    
}

//MARK: - 对象、json字符串互转

extension SparkComTools {
    
    /// 对象转json字符串
    public static func toJsonString(obj: [String: Any]) -> String? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: obj),
           let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) else {
            return ""
        }
        
        return JSONString
    }
    
    /// json字符串转对象
    public static func toJsonObj(jsonStr: String) -> [String: Any]? {
        let jsonData = jsonStr.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data()
        guard let json = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) else {
            return [:]
        }
        
        return json as? [String : Any]
    }
}

//MARK: - MMKV

extension SparkComTools {
    
    /// 存
    /// - Parameters
    ///   - obj: 要存储的对象
    ///   - key: 存储key
    ///
    public static func setValue(_ obj: (NSCoding & NSObjectProtocol)?, key: String) {
        MMKV.default()?.set(obj, forKey: key)
    }
    
    /// 取
    /// - Parameters
    ///   - cls: 要取对象的类型
    ///   - key: 存储key
    ///
    public static func getValue(of cls: AnyClass, key: String) -> Any? {
        return MMKV.default()?.object(of: cls, forKey: key)
    }
    
    /// 删单个
    /// - Parameters
    ///   - key: 要删除对象的key
    ///
    public static func delValue(key: String) {
        MMKV.default()?.removeValue(forKey: key)
    }
    
    /// 删一组
    /// - Parameters
    ///   - keys: 要删除对象的keys
    ///
    public static func delValues(keys: [String]) {
        MMKV.default()?.removeValues(forKeys: keys)
    }
}
