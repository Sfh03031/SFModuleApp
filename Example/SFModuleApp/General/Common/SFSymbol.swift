//
//  SFSymbol.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/17.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

public class SFSymbol: NSObject {

    /// 获取系统SF Symbol图片 - 通过pointSize和weight调整大小
    /// - Parameters:
    ///   - name: 名字
    ///   - pointSize: 自定义大小
    ///   - weight: 权重
    ///   - scale: 缩放比例
    ///   - tintColor: 颜色
    /// - Returns: 图片，可能为nil
    static func symbol(name: String,
                       pointSize: CGFloat = 22.0,
                       weight: UIImage.SymbolWeight = .regular,
                       scale: UIImage.SymbolScale = .default,
                       tintColor: UIColor = .black) -> UIImage? {
        let config = UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight, scale: scale)
        let image = UIImage.init(systemName: name, withConfiguration: config)?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        return image
    }
    
    
    /// 获取系统SF Symbol图片 - 通过textStyle和weight调整大小
    /// - Parameters:
    ///   - name: Symbol名称
    ///   - textStyle: 内置的动态类型大小
    ///   - weight: 权重
    ///   - scale: 缩放比例
    ///   - tintColor: 颜色
    /// - Returns: 图片，可能为nil
    static func symbol(name: String,
                       textStyle: UIFont.TextStyle = .largeTitle,
                       weight: UIImage.SymbolWeight = .regular,
                       scale: UIImage.SymbolScale = .default,
                       tintColor: UIColor = .black) -> UIImage? {
        let ts = UIImage.SymbolConfiguration(textStyle: textStyle)
        let sw = UIImage.SymbolConfiguration(weight: weight)
        let ss = UIImage.SymbolConfiguration(scale: scale)
        let combined = ts.applying(sw).applying(ss)
        let image = UIImage.init(systemName: name, withConfiguration: combined)?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        return image
    }

    /// 获取系统SF Symbol图片 - 通过font调整大小
    /// - Parameters:
    ///   - name: Symbol名称
    ///   - font: 字号
    ///   - scale: 缩放比例
    ///   - tintColor: 颜色
    /// - Returns: 图片，可能为nil
    static func symbol(name: String,
                       font: UIFont = UIFont.systemFont(ofSize: 14),
                       scale: UIImage.SymbolScale = .default,
                       tintColor: UIColor = .black) -> UIImage? {
        let config = UIImage.SymbolConfiguration(font: font, scale: scale)
        let image = UIImage.init(systemName: name, withConfiguration: config)?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        return image
    }
    
    
    @available(iOS 15.0, *)
    /// 获取系统SF Symbol图片 - 渲染分层
    /// - Parameters:
    ///   - name: Symbol名称
    ///   - color: 颜色
    /// - Returns: 图片，可能为nil
    static func symbol(name: String, color: UIColor = .systemIndigo) -> UIImage? {
        let config = UIImage.SymbolConfiguration(hierarchicalColor: color)
        let image = UIImage(systemName: name, withConfiguration: config)
        return image
    }
    
    @available(iOS 15.0, *)
    static func symbolWithMulticolor(name: String) -> UIImage? {
        let config = UIImage.SymbolConfiguration.preferringMulticolor()
        let image = UIImage(systemName: name, withConfiguration: config)
        return image
    }
    
    @available(iOS 16.0, *)
    static func symbolWithMonochrome(name: String) -> UIImage? {
        let config = UIImage.SymbolConfiguration.preferringMonochrome()
        let image = UIImage(systemName: name, withConfiguration: config)
        return image
    }
    
}
