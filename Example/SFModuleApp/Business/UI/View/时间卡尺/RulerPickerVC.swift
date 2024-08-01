//
//  RulerPickerVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/23.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SFStyleKit

class RulerPickerVC: BaseViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 禁掉左滑返回
        let traget = self.navigationController?.interactivePopGestureRecognizer?.delegate;
        let pan = UIPanGestureRecognizer.init(target: traget, action: nil)
        self.view.addGestureRecognizer(pan)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(timeLabel)
        self.view.addSubview(normalLabel)
        self.view.addSubview(picker)
        self.view.addSubview(picker1)
        
        // 显示，必须要先初始化、再设置属性、最后才显示
        picker.showTimeRulerView()
        // 移到某个时间点对应位置
        picker.seek(toRulerValue: "08:00:00")
        
        

        picker1.showTimeRulerView()
        picker1.seek(toUnitValue: 100)
    }
    
    lazy var timeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: TopHeight + 150, width: SCREENW - 20, height: 40), bgColor: .clear, text: "时间卡尺: 00:00:00", textColor: .black, aligment: .center)
        return label
    }()
    
    lazy var picker: VNBRluerPicker = {
        let view = VNBRluerPicker(frame: CGRect(x: 10, y: TopHeight + 50, width: SCREENW - 20, height: 100))
        view.backgroundColor = .hex_F5F6F9
        view.start = 0 // 开始时间
        view.numberOfBigUnit = 24 // 大刻度个数
        view.numberOfSmallUnit = 12 // 每个大刻度包含小刻度个数
        view.rulerWidth = UInt(SCREENW - 20) // 刻度尺宽度
        view.rulerHeight = 100 // 刻度尺高度
        view.mainLineHeight = 20 // 大刻度线高度
        view.mainLineColor = UIColor.random // 大刻度线颜色
        view.secondaryLineNormalHeight = 5 // 小刻度线高度
        view.secondaryLineColor = UIColor.random // 小刻度线颜色
        view.secondaryLineMidHeight = 10 // 小刻度线正中位置刻度线高度
        view.lineSpacing = 16 // 刻度线间距
        view.linePadTopBottom = 10 // 刻度线距离卡尺上下边缘间隔
        view.triangleHeight = 10 // 指示器三角高度
        view.indicatorPadTop = 0 // 指示器距顶部间距
        view.indicatorPadBottom = 0 // 指示器距底部间距
        view.indicatorColor = UIColor.random // 指示器颜色
        view.isGradientEnabled = true // 卡尺两侧是否带渐变
        view.isRoundingEnabled = false // 是否四舍五入后调整偏移量
        view.delegate = self
        return view
    }()
    
    lazy var normalLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: TopHeight + 300, width: SCREENW - 20, height: 40), bgColor: .clear, text: "时间卡尺: 00:00:00", textColor: .black, aligment: .center)
        return label
    }()
    
    lazy var picker1: VNBRluerPicker = {
        let view = VNBRluerPicker(frame: CGRect(x: 10, y: TopHeight + 200, width: SCREENW - 20, height: 100))
        view.backgroundColor = .hex_F5F5F9
        view.start = 6 // 开始
        view.numberOfBigUnit = 12 // 大刻度个数
        view.numberOfSmallUnit = 6 // 每个大刻度包含小刻度个数
        view.rulerWidth = UInt(SCREENW - 20) // 刻度尺宽度
        view.rulerHeight = 100 // 刻度尺高度
        view.mainLineHeight = 30 // 大刻度线高度
        view.mainLineColor = .hex_3b2e7e // 大刻度线颜色
        view.secondaryLineNormalHeight = 10 // 小刻度线高度
        view.secondaryLineColor = .hex_9b4400 // 小刻度线颜色
        view.secondaryLineMidHeight = 20 // 小刻度线正中位置刻度线高度
        view.lineSpacing = 20 // 刻度线间距
        view.linePadTopBottom = 5 // 刻度线距离卡尺上下边缘间隔
        view.triangleHeight = 20 // 指示器三角高度
        view.indicatorPadTop = 5 // 指示器距顶部间距
        view.indicatorPadBottom = 5 // 指示器距底部间距
        view.indicatorColor = .red // 指示器颜色
        view.isGradientEnabled = false // 卡尺两侧是否带渐变
        view.isRoundingEnabled = true // 是否四舍五入后调整偏移量
        view.delegate = self
        return view
    }()

}

extension RulerPickerVC: VNBTimeRulerDelegate {
    func rulerScrollViewWillBeginDragging(_ rulerPicker: VNBRluerPicker!) {
        
    }
    
    func rulerScrollViewDidScroll(_ rulerPicker: VNBRluerPicker!) {
        if rulerPicker == picker {
            self.timeLabel.text = "时间卡尺: \(String(describing: rulerPicker.rulerValue))"
        } else {
            self.normalLabel.text = "时间卡尺: \(String(describing: rulerPicker.rulerValue))"
        }
        
    }
    
    func rulerScrollViewDidEndDecelerating(_ rulerPicker: VNBRluerPicker!) {
        
    }
    
    func rulerScrollViewDidEndDragging(_ rulerPicker: VNBRluerPicker!, willDecelerate decelerate: Bool) {
        
    }
    
    
}
