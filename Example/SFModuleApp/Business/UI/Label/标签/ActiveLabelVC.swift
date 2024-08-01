//
//  ActiveLabelVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/6.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import ActiveLabel
import SFStyleKit

class ActiveLabelVC: BaseViewController {
    
    let label = ActiveLabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customType = ActiveType.custom(pattern: "\\s假期\\b") //Looks for "假期"
        let customType2 = ActiveType.custom(pattern: "\\s上班\\b") //Looks for "上班"
        let customType3 = ActiveType.custom(pattern: "\\s状态\\b") //Looks for "状态"

        label.enabledTypes.append(customType)
        label.enabledTypes.append(customType2)
        label.enabledTypes.append(customType3)

        label.urlMaximumLength = 31

        // 每设置一次属性就会刷新一次ActiveLabel，使用此方法只会刷新一次ActiveLabel
        label.customize { label in
            // 关键字前后有空格
            label.text = " 上班 第一天就期待端午假期了 #距离下个假期还有26个工作日 今天是五一 假期 后的上班第一天 @微博 不少网友还没从假期的状态中 http://www.baidu.com 走出来。还有不少人已经开始期待端午假期了，算上 https://www.baidu.com/status/649678392372121601 今天，距离端午假期还有26个工作日，并且，今年的端午假期无需调休。 #节后上班第1天 你今天 状态 如何？有没有开始期待下个假期?"
            label.numberOfLines = 0
            label.lineSpacing = 4
            label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            
            label.textColor = UIColor(red: 102.0/255, green: 117.0/255, blue: 127.0/255, alpha: 1)
            label.hashtagColor = UIColor(red: 85.0/255, green: 172.0/255, blue: 238.0/255, alpha: 1)
            label.mentionColor = UIColor(red: 238.0/255, green: 85.0/255, blue: 96.0/255, alpha: 1)
            label.URLColor = UIColor(red: 85.0/255, green: 238.0/255, blue: 151.0/255, alpha: 1)
            label.URLSelectedColor = UIColor(red: 82.0/255, green: 190.0/255, blue: 41.0/255, alpha: 1)

            label.handleMentionTap { self.alert("@", message: $0) }
            label.handleHashtagTap { self.alert("#", message: $0) }
            label.handleURLTap { self.alert("链接", message: $0.absoluteString) }

            //Custom types

            label.customColor[customType] = UIColor.purple
            label.customSelectedColor[customType] = UIColor.green
            label.customColor[customType2] = UIColor.magenta
            label.customSelectedColor[customType2] = UIColor.green
            
            label.configureLinkAttribute = { (type, attributes, isSelected) in
                var atts = attributes
                switch type {
                case customType3:
                    atts[NSAttributedString.Key.font] = isSelected ? UIFont.boldSystemFont(ofSize: 18) : UIFont.boldSystemFont(ofSize: 16)
                default: ()
                }
                
                return atts
            }

            label.handleCustomTap(for: customType) { self.alert("自定义", message: $0) }
            label.handleCustomTap(for: customType2) { self.alert("自定义", message: $0) }
            label.handleCustomTap(for: customType3) { self.alert("自定义", message: $0) }
        }

        label.frame = CGRect(x: 20, y: TopHeight + 10, width: view.frame.width - 40, height: 300)
        view.addSubview(label)
    }
    
    func alert(_ title: String, message: String) {
        UIAlertController().sf.message(message).title(title).show(self).hidden(2)
    }

}
