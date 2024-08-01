//
//  SwitchListVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/6/3.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import TKSwitcherCollection

class SwitchListVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(switch1)
        self.view.addSubview(switch2)
        self.view.addSubview(switch3)
        self.view.addSubview(switch4)
        self.view.addSubview(switch5)
        
        //FIXME: 开或关的状态返回的有点问题
    }
    
    lazy var switch1: TKSimpleSwitch = {
        let view = TKSimpleSwitch(frame: CGRect.init(x: 20, y: TopHeight + 20, width: 90, height: 40))
        view.rotateWhenValueChange = false
        view.onColor = .systemTeal
        view.offColor = .lightGray
        view.lineColor = .brown
        view.lineSize = 10
        view.circleColor = .random
        view.valueChange = { isOn in
            print("switch1: \(isOn)")
        }
        return view
    }()
    
    lazy var switch2: TKSimpleSwitch = {
        let view = TKSimpleSwitch(frame: CGRect.init(x: SCREENW - 110, y: TopHeight + 20, width: 90, height: 40))
        view.rotateWhenValueChange = true
        view.onColor = .systemTeal
        view.offColor = .lightGray
        view.lineColor = .brown
        view.lineSize = 10
        view.circleColor = .random
        view.valueChange = { isOn in
            print("switch2: \(isOn)")
        }
        return view
    }()
    
    lazy var switch3: TKExchangeSwitch = {
        let view = TKExchangeSwitch(frame: CGRect.init(x: 20, y: TopHeight + 100, width: 90, height: 40))
        view.onColor = .systemTeal
        view.offColor = .lightGray
        view.lineColor = .brown
        view.lineSize = 20
        view.valueChange = { isOn in
            print("switch3: \(isOn)")
        }
        return view
    }()
    
    lazy var switch4: TKSmileSwitch = {
        let view = TKSmileSwitch(frame: CGRect.init(x: SCREENW - 110, y: TopHeight + 100, width: 90, height: 40))
        view.backgroundColor = .white
        view.valueChange = { isOn in
            print("switch4: \(isOn)")
        }
        return view
    }()
    
    lazy var switch5: TKLiquidSwitch = {
        let view = TKLiquidSwitch(frame: CGRect.init(x: 20, y: TopHeight + 180, width: 90, height: 40))
        view.onColor = .systemTeal
        view.offColor = .lightGray
        view.valueChange = { isOn in
            print("switch5: \(isOn)")
        }
        return view
    }()

}
