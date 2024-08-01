//
//  Constant.swift
//  SparkBase
//
//  Created by sfh on 2023/12/26.
//  Copyright © 2023 Spark. All rights reserved.
//

import Foundation

/// 网络请求头参数
public let sparkAppId = "210951669544977408"
public let sparkTerminalType = "1"
public let sparkOs = "ios"
public let sparkChannel = "AppStore"

/// 协议头
public let sparkScheme = "spark"

/// 断网提示
public let noNetworkNotice = "您的网络好像出了点问题\n请前往 设置-无线局域网/蜂窝网络 检查网络是否开启\n或者检查是否授予APP网络使用权限"


public let userDateStandKey = "userDateStandKey"
public let tokenStandKey = "tokenStandKey"
public let ServiceKey = "ServiceKey"

// MARK: - 尺寸、系统判断

/// WINDOW
public var WINDOW: UIWindow? {
    if #available(iOS 13.0, *) {
        var window:UIWindow? = nil
        for sence: UIWindowScene in ((UIApplication.shared.connectedScenes as? Set<UIWindowScene>)!) {
            if sence.activationState == .foregroundActive {
                window = sence.windows.first
                break
            }
        }
        return window
    } else {
        return UIApplication.shared.keyWindow
    }
}

/** 屏幕的宽 */
var SCREENW: CGFloat { UIScreen.main.bounds.size.width }
/** 屏幕的高 */
var SCREENH: CGFloat { UIScreen.main.bounds.size.height }
/** 顶部StatusBar高度 */
var TopStatusBar: CGFloat {
    if #available(iOS 11.0, *) {
        return WINDOW?.safeAreaInsets.top ?? 20
    } else {
        return 20
    }
}
var navBarHeight: CGFloat { 44.0 }
/** 顶部StatusBar+Nav的高度判断 */
var TopHeight: CGFloat { TopStatusBar + navBarHeight }
/** 底部安全区域高度 */
var SoftHeight: CGFloat {
    if #available(iOS 11.0, *) {
        return WINDOW?.safeAreaInsets.bottom ?? 0
    } else {
        return 0
    }
}

var tabBarHeight: CGFloat { 49.0 }
/** 底部tabbar+soft的高度判断 */
var BottomHeight: CGFloat { SoftHeight + tabBarHeight }

/** iPhone 5 */
let isIPhone5 = SCREENH == 568 ? true:false
/** iPhone 6 */
let isIPhone6 = SCREENH == 667 ? true:false
/** iPhone 6P */
let isIPhone6P = SCREENH == 736 ? true:false
/** iPhone X */
let isIPhoneX = iPhoneX() ? true:false
/** iPad */
let isIPad = iPad() ? true:false

/** 判断是不是全面屏iPhone */
func iPhoneX() -> Bool {
    if TopStatusBar > 20 && UIDevice.current.userInterfaceIdiom == .phone {
        return true
    }
    return false
}

/** 判断是不是iPad */
func iPad() -> Bool {
    if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
        return true
    }
    return false
}

/** 判断是不是全面屏iPad */
func iPadX() -> Bool {
    if SoftHeight > 0 && UIDevice.current.userInterfaceIdiom == .pad {
        return true
    }
    return false
}

// 文本行高处理
func GetLabelParagraphStyle(lineHeight: CGFloat, lab: UILabel) -> [NSAttributedStringKey: Any] {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.maximumLineHeight = lineHeight
    paragraphStyle.minimumLineHeight = lineHeight
    var multipleAttributes = [NSAttributedStringKey: Any]()
    multipleAttributes[NSAttributedStringKey(rawValue: NSAttributedStringKey.paragraphStyle.rawValue)] = paragraphStyle
    multipleAttributes[NSAttributedStringKey(rawValue: NSAttributedStringKey.baselineOffset.rawValue)] = (lineHeight - lab.font.lineHeight) / 4
    return multipleAttributes
}

func textSizeWH(text: String, font: UIFont, maxSize: CGSize, lineSpace: CGFloat) -> CGSize {
    let paraph = NSMutableParagraphStyle()
    paraph.lineSpacing = lineSpace
    paraph.paragraphSpacing = 0
    return text.boundingRect(with: maxSize, options: [NSStringDrawingOptions.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font: font, NSAttributedStringKey.paragraphStyle: paraph], context: nil).size
}
