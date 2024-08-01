//
//  LTMorphingLabelVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/30.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import LTMorphingLabel

class LTMorphingLabelVC: BaseViewController {
    
    @IBOutlet weak var label: LTMorphingLabel!
    @IBOutlet weak var progressSlider: UISlider!
    
    @IBOutlet weak var effectSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var themeSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var autoStart: UISwitch!
    
    
    fileprivate var i = -1
    fileprivate var textArray = [
        "What is design?",
        "Design", "Design is not just", "what it looks like", "and feels like.",
        "Design", "is how it works.", "- Steve Jobs",
        "Older people", "sit down and ask,", "'What is it?'",
        "but the boy asks,", "'What can I do with it?'.", "- Steve Jobs",
        "One more thing...", "Swift", "Objective-C", "iPhone", "iPad", "Mac Mini",
        "MacBook Pro🔥", "Mac Pro⚡️",
        "爱老婆",
        "नमस्ते दुनिया",
        "हिन्दी भाषा",
        "$68.98",
        "$68.99",
        "$69.00",
        "$69.01"
    ]
    fileprivate var text: String {
        i = i >= textArray.count - 1 ? 0 : i + 1
        return textArray[i]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.delegate = self
        
        [effectSegmentControl, themeSegmentControl].forEach {
            $0?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
            $0?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        }
        
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeText)))
    }
    
    @objc func changeText() {
        label.text = text
        if !autoStart.isOn {
            label.pause()
            progressSlider.value = 0
        }
    }
    
    /// 改变文字变形进度
    @IBAction func updateProgress(_ sender: Any) {
        label.morphingProgress = progressSlider.value / 100
        label.setNeedsDisplay()
    }
    
    /// 改变字体大小
    @IBAction func changeFontSize(_ sender: UISlider) {
        label.font = UIFont(descriptor: label.font.fontDescriptor, size: CGFloat(sender.value))
        label.text = label.text
    }
    
    /// 切换文字变形模式
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        let seg = sender
        if let effect = LTMorphingEffect(rawValue: seg.selectedSegmentIndex) {
            label.morphingEffect = effect
            changeText()
        }
    }
    
    /// 切换黑白模式
    @IBAction func toggleLight(_ sender: UISegmentedControl) {
        let isNight = Bool(sender.selectedSegmentIndex == 0)
        view.backgroundColor = isNight ? .black : .white
        label.textColor = isNight ? .systemTeal : .systemYellow
    }
    
    /// 是否自动变形
    @IBAction func updateAutoStart(_ sender: UISwitch) {
        progressSlider.isHidden = autoStart.isOn
        if autoStart.isOn {
            label.unpause()
        } else {
            label.pause()
            changeText()
        }
    }
    
    
    @IBAction func clear(_ sender: UIButton) {
        label.text = nil
    }
    
    
    
    
}

extension LTMorphingLabelVC: LTMorphingLabelDelegate {
    
    func morphingDidStart(_ label: LTMorphingLabel) {
        
    }
    
    func morphingDidComplete(_ label: LTMorphingLabel) {
        
    }
    
    func morphingOnProgress(_ label: LTMorphingLabel, progress: Float) {
        
    }
}
