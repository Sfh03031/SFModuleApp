//
//  MarqueeTouchCharacterVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/25.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import MarqueeLabel

class MarqueeTouchCharacterVC: BaseViewController {
    
    let strings = [
        "4月23日，恒大地产集团有限公司新增23条被执行人信息，执行标的合计2.74亿余元,涉及服务合同纠纷、保理合同纠纷等案件，",
        "部分案件被执行人还包括恒大地产集团济南置业有限公司、合肥恒瑞置业有限公司、林州市城投宝利金房地产开发有限公司等",
        "风险信息显示，恒大地产集团有限公司现存680余条被执行人信息，被执行总金额超526亿元。",
        "今年是《西部陆海新通道总体规划》实施的第5年。5年来，这条国际物流大通道加速延伸，跨越山海，联结世界，铺就崭新的发展通途。",
        "西部陆海新通道以重庆为运营中心，各西部省区市为关键节点，利用铁路、海运、公路等运输方式，向南经广西、云南等沿海沿边口岸通达世界各地。",
        "2017年9月，西部陆海新通道的前身——渝黔桂新“南向通道”班列从重庆团结村中心站驶出，标志着该班列实现常态化运输。此后，“第一个1万列”用时1461天，“第二个1万列”用时487天，“第三个1万列”用时402天……西部陆海新通道“万列”完成时间进程不断缩短。"
    ]

    @IBOutlet weak var demoLabel: MarqueeLabel!
    @IBOutlet weak var labelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        demoLabel.type = MarqueeLabel.MarqueeType.allCases.randomElement() ?? .continuous
        // Set label label text
        labelLabel.text = { () -> String in
            switch demoLabel.type {
            case .continuous:
                return "连续滚动"
            case .continuousReverse:
                return "连续反向滚动"
            case .left:
                return "只向左滚动，滚完即停"
            case .leftRight:
                return "左-右 滚动"
            case .right:
                return "只向右滚动，滚完即停"
            case .rightLeft:
                return "右-左 滚动"
            }
        }()
        
        demoLabel.speed = .duration(15)
        demoLabel.animationCurve = .easeInOut
        demoLabel.fadeLength = 10.0
        demoLabel.leadingBuffer = 30.0
        
        demoLabel.text = strings[Int(arc4random_uniform(UInt32(strings.count)))]
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap(_:)))
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        demoLabel.addGestureRecognizer(tapRecognizer)
        demoLabel.isUserInteractionEnabled = true
    }
    
    @objc func didTap(_ recognizer: UIGestureRecognizer) {
        let label = recognizer.view as! MarqueeLabel
        if recognizer.state == .ended {
            label.isPaused ? label.unpauseLabel() : label.pauseLabel()
            // Convert tap points
            let tapPoint = recognizer.location(in: label)
            print("Frame coord: \(tapPoint)")
            guard let textPoint = label.textCoordinateForFramePoint(tapPoint) else {
                return
            }
            print(" Text coord: \(textPoint)")
            
            // Thanks to Toomas Vahter for the basis of the below
            // https://augmentedcode.io/2020/12/20/opening-hyperlinks-in-uilabel-on-ios/
            // Create layout manager
            let layoutManager = NSLayoutManager()
            let textContainer = NSTextContainer(size: label.textLayoutSize())
            textContainer.lineFragmentPadding = 0
            // Create text storage
            guard let text = label.text else { return }
            let textStorage = NSTextStorage(string: "")
            textStorage.setAttributedString(label.attributedText!)
            layoutManager.addTextContainer(textContainer)
            textStorage.addLayoutManager(layoutManager)
            textContainer.lineBreakMode = label.lineBreakMode
            textContainer.size = label.textRect(forBounds: CGRect(origin: .zero, size:label.textLayoutSize()), limitedToNumberOfLines: label.numberOfLines).size
            
            let characterIndex = layoutManager.characterIndex(for: textPoint, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
            guard characterIndex >= 0, characterIndex != NSNotFound else {
                print("No character at point found!")
                return
            }
            
            let stringIndex = text.index(text.startIndex, offsetBy: characterIndex)
            // Print character under touch point
            print("Character under touch point: \(text[stringIndex])")
            SVProgressHUD.showInfo(withStatus: "触摸点的字符是: \(text[stringIndex])")
        }
    }

}
