//
//  HGCircularSliderVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/6/5.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import HGCircularSlider

class HGCircularSliderVC: BaseViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 禁掉左滑返回
//        let traget = self.navigationController?.interactivePopGestureRecognizer?.delegate;
//        let pan = UIPanGestureRecognizer.init(target: traget, action: nil)
//        self.view.addGestureRecognizer(pan)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(slider1)
        self.view.addSubview(slider2)
        self.view.addSubview(slider3)
        self.view.addSubview(slider4)
    }
    

    lazy var slider1: CircularSlider = {
        let view = CircularSlider(frame: CGRect.init(x: 20, y: TopHeight + 20, width: 150, height: 150))
        view.backgroundColor = .clear
        view.minimumValue = 0.0
        view.maximumValue = 1.0
        view.endPointValue = 0.2
        view.lineWidth = 5.0
        view.backtrackLineWidth = 5.0
        view.diskColor = UIColor.random.withAlphaComponent(0.4)
        view.diskFillColor = .blue.withAlphaComponent(0.3)
        return view
    }()
    
    lazy var slider2: RangeCircularSlider = {
        let view = RangeCircularSlider(frame: CGRect.init(x: SCREENW - 170, y: TopHeight + 20, width: 150, height: 150))
        view.backgroundColor = .clear
        view.startThumbImage = SFSymbol.symbol(name: "command")
        view.endThumbImage = SFSymbol.symbol(name: "signature")
        
        let daySeconds = 24 * 60 * 60
        view.maximumValue = CGFloat(daySeconds)
        
        view.startPointValue = 1 * 60 * 60
        view.endPointValue = 8 * 60 * 60
        view.numberOfRounds = 2 // Two rotations for full 24h range
        view.diskColor = UIColor.random.withAlphaComponent(0.4)
        view.diskFillColor = .systemTeal.withAlphaComponent(0.4)
        return view
    }()
    
    lazy var slider3: MidPointCircularSlider = {
        let view = MidPointCircularSlider()
        view.frame = CGRect.init(x: 20, y: TopHeight + 250, width: 150, height: 150)
        view.backgroundColor = .clear
        view.minimumValue = 0.0
        view.maximumValue = 10.0
        view.distance = 2.0
        view.midPointValue = 2.0
        view.diskColor = UIColor.random.withAlphaComponent(0.4)
        view.diskFillColor = .systemTeal.withAlphaComponent(0.4)
        return view
    }()
    
    lazy var slider4: CircularSlider = {
        let view = CircularSlider(frame: CGRect.init(x: SCREENW - 170, y: TopHeight + 250, width: 150, height: 150))
        view.backgroundColor = .white
        view.minimumValue = 0.0
        view.maximumValue = 30.0
        view.numberOfRounds = 10
//        view.endPointValue = 0.2
        view.isUserInteractionEnabled = false
        // to remove padding, for more details see issue #25
        view.thumbLineWidth = 0.0
        view.thumbRadius = 0.0
        view.trackFillColor = UIColor.sf.hexColor(hex: "2F3889")
        view.trackColor = UIColor.sf.hexColor(hex: "AC3064")
        view.lineWidth = 5.0
        view.backtrackLineWidth = 8.0
        view.diskColor = .white
        view.diskFillColor = .systemTeal.withAlphaComponent(0.4)
        return view
    }()

}
