//
//  MarqueeVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/25.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import MarqueeLabel

class MarqueeVC: BaseViewController {

    @IBOutlet weak var demoLabel1: MarqueeLabel!
    @IBOutlet weak var demoLabel2: MarqueeLabel!
    @IBOutlet weak var demoLabel3: MarqueeLabel!
    @IBOutlet weak var demoLabel4: MarqueeLabel!
    @IBOutlet weak var demoLabel5: MarqueeLabel!
    @IBOutlet weak var demoLabel6: MarqueeLabel!
    
    @IBOutlet weak var labelizeSwitch: UISwitch!
    @IBOutlet weak var holdLabelsSwitch: UISwitch!
    @IBOutlet weak var pauseLabelsSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Continuous Type
        demoLabel1.tag = 101
        demoLabel1.type = .continuous
        demoLabel1.animationCurve = .easeInOut
        // Text string, fade length, leading buffer, trailing buffer, and scroll
        // duration for this label are set via Interface Builder's Attributes Inspector!
        
        // Reverse Continuous Type, with attributed string
        demoLabel2.tag = 201
        demoLabel2.type = .continuousReverse
        demoLabel2.textAlignment = .right
        demoLabel2.lineBreakMode = .byTruncatingHead
        demoLabel2.speed = .duration(8.0)
        demoLabel2.fadeLength = 15.0
        demoLabel2.leadingBuffer = 40.0
        
        let attributedString2 = NSMutableAttributedString(string:"这是一个长字符串，也是一个属性字符串，同样有效！这是一个长字符串，也是一个属性字符串，同样有效！")
        attributedString2.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Helvetica-Bold", size: 18)!, range: NSMakeRange(0, 21))
        attributedString2.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.lightGray, range: NSMakeRange(0, 14))
        attributedString2.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 0.234, green: 0.234, blue: 0.234, alpha: 1.0), range: NSMakeRange(0, attributedString2.length))
        attributedString2.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Light", size: 18)!, range: NSMakeRange(21, attributedString2.length - 21))
        demoLabel2.attributedText = attributedString2
        
        // Left/right example, with rate usage
        demoLabel3.tag = 301
        demoLabel3.type = .leftRight
        demoLabel3.speed = .rate(60)
        demoLabel3.fadeLength = 10.0
        demoLabel3.leadingBuffer = 30.0
        demoLabel3.trailingBuffer = 20.0
        demoLabel3.textAlignment = .center
        demoLabel3.text = "这是另一个以特定速率滚动的长标签，而不是在定义的时间窗口中滚动其长度！这是另一个以特定速率滚动的长标签，而不是在定义的时间窗口中滚动其长度！"
        
        
        // Right/left example, with tap to scroll
        demoLabel4.tag = 401
        demoLabel4.type = .rightLeft
        demoLabel4.textAlignment = .right
        demoLabel4.lineBreakMode = .byTruncatingHead
        demoLabel4.tapToScroll = true
        demoLabel4.trailingBuffer = 20.0
        demoLabel4.text = "这是一个支持点击后滚动且只滚动一次的文本。这是一个支持点击后滚动且只滚动一次的文本。"
        
        // Continuous, with tap to pause
        demoLabel5.tag = 501
        demoLabel5.type = .continuousReverse
        demoLabel5.speed = .duration(10)
        demoLabel5.fadeLength = 10.0
        demoLabel5.leadingBuffer = 40.0
        demoLabel5.trailingBuffer = 30.0
        demoLabel5.text = "这是一个内容很长且支持点击后暂停滚动的文本。这是一个内容很长且支持点击后暂停滚动的文本。这是一个内容很长且支持点击后暂停滚动的文本。"
        
        demoLabel5.isUserInteractionEnabled = true // Don't forget this, otherwise the gesture recognizer will fail (UILabel has this as NO by default)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(pauseTap))
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        demoLabel5.addGestureRecognizer(tapRecognizer)

        // Continuous, with attributed text
        demoLabel6.tag = 601
        demoLabel6.type = .continuous
        demoLabel6.speed = .duration(15.0)
        demoLabel6.fadeLength = 10.0
        demoLabel6.trailingBuffer = 30.0
        
        let attributedString6 = NSMutableAttributedString(string:"这是一个内容很长且被设置为以连续的方式循环滚动的富文本。这是一个内容很长且被设置为以连续的方式循环滚动的富文本。")
        attributedString6.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 0.123, green: 0.331, blue: 0.657, alpha: 1.000), range: NSMakeRange(0,34))
        attributedString6.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 0.657, green: 0.096, blue: 0.088, alpha: 1.000), range: NSMakeRange(34, attributedString6.length - 34))
        attributedString6.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Light", size:18.0)!, range: NSMakeRange(0, 16))
        attributedString6.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Light", size:18.0)!, range: NSMakeRange(33, attributedString6.length - 33))
        demoLabel6.attributedText = attributedString6
    }

    /// 改变内容
    @IBAction func changeLabelTexts(_ sender: Any) {
        // Use demoLabel1 tag to store "state"
        if (demoLabel1.tag == 101) {
            demoLabel1.text = "这是一个短的文本"
            demoLabel3.text = "这是一个短的、居中的文本"
            
            let attributedString2 = NSMutableAttributedString(string: "这是一个内容不同且内容较长并且具有新的不同属性的富文本。这是一个内容不同且内容较长并且具有新的不同属性的富文本。")
            attributedString2.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSMakeRange(0, attributedString2.length))
            attributedString2.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Helvetica-Bold", size:18.0)!, range:NSMakeRange(0, attributedString2.length))
            attributedString2.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor(white:0.600, alpha:1.000), range:NSMakeRange(0,33))
            attributedString2.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Light", size:18.0)!, range:NSMakeRange(19, attributedString2.length - 19))
            demoLabel2.attributedText = attributedString2;
            
            let attributedString6 = NSMutableAttributedString(string: "这是一个内容不同且内容更长并且被设置为以连续的方式循环滚动的富文本。这是一个内容不同且内容更长并且被设置为以连续的方式循环滚动的富文本。")
            attributedString6.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.657, green:0.078, blue:0.067, alpha:1.000), range:NSMakeRange(0,attributedString6.length))
            attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name: "HelveticaNeue-Light", size:18.0)!, range:NSMakeRange(0, 16))
            attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name: "HelveticaNeue-Light", size:18.0)!, range:NSMakeRange(33, attributedString6.length - 33))
            attributedString6.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red:0.123, green:0.331, blue:0.657, alpha:1.000), range:NSMakeRange(33, attributedString6.length - 33))
            demoLabel6.attributedText = attributedString6;
            
            demoLabel1.tag = 102;
        } else {
            demoLabel1.text = "这是对跑马灯的测试——文本内容足够长，需要滚动才能看到整个内容。这是对跑马灯的测试——文本内容足够长，需要滚动才能看到整个内容。";
            demoLabel3.text = "左右滚动但不连续，左右滚动但不连续，左右滚动但不连续，左右滚动但不连续，左右滚动但不连续，左右滚动但不连续。"
            
            let attributedString2 = NSMutableAttributedString(string: "这是一个内容很长的富文本，同样有效！这是一个内容很长的富文本，同样有效！这是一个内容很长的富文本，同样有效！")
            attributedString2.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Helvetica-Bold", size:18.0)!, range:NSMakeRange(0, 21))
            attributedString2.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.lightGray, range:NSMakeRange(10,11))
            attributedString2.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red:0.234, green:0.234, blue:0.234, alpha:1.000), range:NSMakeRange(0,attributedString2.length))
            attributedString2.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Light", size:18.0)!, range: NSMakeRange(21, attributedString2.length - 21))
            demoLabel2.attributedText = attributedString2
            
            let attributedString6 = NSMutableAttributedString(string: "这是一个内容很长且被设置为以连续的方式循环滚动的富文本。这是一个内容很长且被设置为以连续的方式循环滚动的富文本。")
            attributedString6.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.123, green:0.331, blue:0.657, alpha:1.000), range:NSMakeRange(0,attributedString6.length))
            attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name: "HelveticaNeue-Light", size:18.0)!, range:NSMakeRange(0, 16))
            attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name: "HelveticaNeue-Light", size:18.0)!, range:NSMakeRange(33, attributedString6.length - 33))
            demoLabel6.attributedText = attributedString6
            
            demoLabel1.tag = 101;
        }
    }
    
    /// 在列表中
    @IBAction func InTableView(_ sender: Any) {
        self.navigationController?.pushViewController(MarqueeTableVC(), animated: true)
    }
    
    /// 获取点击位置的字符
    @IBAction func TouchCharacter(_ sender: Any) {
        self.navigationController?.pushViewController(MarqueeTouchCharacterVC(), animated: true)
    }
    
    @objc func pauseTap(_ recognizer: UIGestureRecognizer) {
        let continuousLabel2 = recognizer.view as! MarqueeLabel
        if recognizer.state == .ended {
            continuousLabel2.isPaused ? continuousLabel2.unpauseLabel() : continuousLabel2.pauseLabel()
        }
    }
    
    @IBAction func labelizeSwitched(_ sender: UISwitch) {
        if sender.isOn {
            MarqueeLabel.controllerLabelsLabelize(self)
        } else {
            MarqueeLabel.controllerLabelsAnimate(self)
        }
    }
    
    @IBAction func holdLabelsSwitched(_ sender: UISwitch) {
        for pv in view.subviews as [UIView] {
            if let v = pv as? MarqueeLabel {
                v.holdScrolling = sender.isOn
            }
        }
    }
    
    @IBAction func togglePause(_ sender: UISwitch) {
        for pv in view.subviews as [UIView] {
            if let v = pv as? MarqueeLabel {
                sender.isOn ? v.pauseLabel() : v.unpauseLabel()
            }
        }
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
