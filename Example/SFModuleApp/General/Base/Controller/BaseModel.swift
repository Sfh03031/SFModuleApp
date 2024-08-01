//
//  BaseModel.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/16.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import HandyJSON

open class BaseModel: NSObject, HandyJSON {
    
    required public override init() { }
    
    /// 复制本体, 深拷贝
    open func copy<T: HandyJSON>(_ type: T.Type) -> T? {
        if let json = toJSON(),
            let model = T.deserialize(from: json) {
            return model
        }
        return nil
    }
    
    /// 更新本体, 不是创建另一个代替自己
    open class func update<T: BaseModel>(_ object: T?, from: T?, complete:@escaping((Bool) -> Void)) {
        guard var object = object, let from = from else { return }
        JSONDeserializer.update(object: &object, from: from.toJSON())
        complete(true)
    }
    
    /// 可进行key的映射
    open func mapping(mapper: HelpingMapper) {

    }
    
    /// 序列化完毕
    open func didFinishMapping() {

    }
    
    
}
