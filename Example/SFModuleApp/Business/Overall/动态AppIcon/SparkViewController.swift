//
//  SparkViewController.swift
//  AlternateIcons
//
//  Created by sfh on 2024/2/23.
//

import UIKit

class SparkViewController: UIViewController {
    
    /// 是否交换了方法
    var isExchange: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "动态AppIcon"
        self.view.backgroundColor = .white
        
        // 1、添加图片资源到根目录，可配置多套，主AppIcon还是在Assets里
        // 2、配置Info, CFBundleIcons -> CFBundleAlternateIcons -> CFBundleIconFiles
        // 3、调用UIApplication私有方法切换图标
        
        // UIApplication.shared.setAlternateIconName 方法会默认弹窗，
        // 可以利用runtime去掉弹窗，也可以通过methodForSelector:获取IMP绕过消息机制直接调用
        
    }

    /// 利用runtime去掉弹窗
    @IBAction func exchange(_ sender: Any) {
        ExchangePresentAlert()
        isExchange = !isExchange
    }
    /// 切换图标一
    @IBAction func SwitchToFirst(_ sender: Any) {
        if #available(iOS 10.3, *) {
            if UIApplication.shared.supportsAlternateIcons {
                print("替换前图标：\(UIApplication.shared.alternateIconName ?? "原始图标")")
                
                UIApplication.shared.setAlternateIconName("Doraemon", completionHandler: { (error: Error?) in
                    print("替换后图标：\(UIApplication.shared.alternateIconName ?? "原始图标")")
                })
            }
        }
        
        if isExchange {
            UIAlertController.alertStyle(.actionSheet).message("切换图标一").show(self).hidden(2)
        }
        
    }
    
    /// 切换图标二
    @IBAction func SwitchToSenond(_ sender: Any) {
        if #available(iOS 10.3, *) {
            if UIApplication.shared.supportsAlternateIcons {
                print("替换前图标：\(UIApplication.shared.alternateIconName ?? "原始图标")")
                
                UIApplication.shared.setAlternateIconName("code", completionHandler: { (error: Error?) in
                    print("替换后图标：\(UIApplication.shared.alternateIconName ?? "原始图标")")
                })
            }
        }
        
        if isExchange {
            UIAlertController.alertStyle(.actionSheet).message("切换图标二").show(self).hidden(2)
        }
        
    }
    
    /// 切换图标三
    @IBAction func SwitchToThird(_ sender: Any) {
        if #available(iOS 10.3, *) {
            if UIApplication.shared.supportsAlternateIcons {
                print("替换前图标：\(UIApplication.shared.alternateIconName ?? "原始图标")")
                
                UIApplication.shared.setAlternateIconName("fishbone", completionHandler: { (error: Error?) in
                    print("替换后图标：\(UIApplication.shared.alternateIconName ?? "原始图标")")
                })
            }
        }
        
        if isExchange {
            UIAlertController.alertStyle(.actionSheet).message("切换图标三").show(self).hidden(2)
        }
        
    }
    
    /// 通过IMP切换图标三，不会走消息发送，也就不会触发弹窗，进而就不需要runtime交换方法了
    @IBAction func SwitchToThirdWithIMP(_ sender: Any) {
        
        if #available(iOS 10.3, *) {
            if UIApplication.shared.supportsAlternateIcons {
                print("替换前图标：\(UIApplication.shared.alternateIconName ?? "原始图标")")
                
                let selectorString = NSMutableString(capacity: 40)
                selectorString.append("_setAlternate")
                selectorString.append("IconName:")
                selectorString.append("completionHandler:")
                
                let selector = NSSelectorFromString(selectorString as String)
                let imp = UIApplication.shared.method(for: selector)
                typealias Function = @convention(c) (AnyObject, Selector, String?, ((Error?) -> Void)?) -> Void
                let function = unsafeBitCast(imp, to: Function.self)
                function(UIApplication.shared, selector, "fishbone", { (error: Error?) in
                    print(error.debugDescription)
                })
            }
        }
        
        if isExchange {
            UIAlertController.alertStyle(.actionSheet).message("通过IMP切换图标三，不会走消息发送，也就不会触发弹窗").show(self).hidden(2)
        }
        
    }
    
    /// 还原
    @IBAction func SwitchToPrimary(_ sender: Any) {
        if #available(iOS 10.3, *) {
            if UIApplication.shared.supportsAlternateIcons {
                print("替换前图标：\(UIApplication.shared.alternateIconName ?? "原始图标")")
                //当前显示的是原始图标
                UIApplication.shared.setAlternateIconName(nil, completionHandler: { (error: Error?) in
                    print("替换后图标：\(UIApplication.shared.alternateIconName ?? "原始图标")")
                })
            }
        }
    }
    
}

extension SparkViewController {
    
    /// 利用runtime去掉弹窗
    func ExchangePresentAlert() -> Void {
        if let presentM = class_getInstanceMethod(type(of: self), #selector(present(_:animated:completion:))),
            let presentSwizzlingM = class_getInstanceMethod(type(of: self), #selector(temporary_present(_:animated:completion:))){
            method_exchangeImplementations(presentM, presentSwizzlingM)
        }
    }
    
    /// 利用runtime恢复方法实现
    func ResetPresentAlert() -> Void {
        // 再换一次
        ExchangePresentAlert()
    }
    
    /// 在自己实现中特殊处理
    @objc dynamic func temporary_present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Swift.Void)? = nil){
        if viewControllerToPresent.isKind(of: UIAlertController.self) {
            if let alertController = viewControllerToPresent as? UIAlertController{
                //通过判断title和message都为nil，得知是替换icon触发的提示。
                if alertController.title == nil && alertController.message == nil {
                    return;
                }
            }
        }
        
        self.temporary_present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
