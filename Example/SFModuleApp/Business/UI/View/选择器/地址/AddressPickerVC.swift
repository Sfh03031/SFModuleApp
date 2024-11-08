//
//  AddressPickerVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/22.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import JohnWick
import SFStyleKit

class AddressPickerVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .hex_F5F5F9
        
        self.view.addSubview(AlphaBtn)
        self.view.addSubview(BroveBtn)
        self.view.addSubview(GammaBtn)
    }
    
    func areaBtn() {
        SFAddressPickerVC.init(.area) { model, model1, model2 in
            SF.WINDOW?.makeToast("\(String(describing: model?.name))\(String(describing: model1?.name))\(String(describing: model2?.name))")
        }.show()
    }
    
    func cityBtn() {
        SFAddressPickerVC.init(.city) { model, model1, model2 in
            SF.WINDOW?.makeToast("\(String(describing: model?.name))\(String(describing: model1?.name))\(String(describing: model2?.name))")
        }.show()
    }
    
    func provinceBtn() {
        SFAddressPickerVC.init(.province) { model, model1, model2 in
            SF.WINDOW?.makeToast("\(String(describing: model?.name))\(String(describing: model1?.name))\(String(describing: model2?.name))")
        }.show()
    }
    

    lazy var AlphaBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.sf.backgroundColor(.random).frame(CGRect(x: (SCREENW - 200) / 2, y: 200, width: 200, height: 50)).title("地区").tintColor(.white).titleFont(UIFont.systemFont(ofSize: 16.0, weight: .medium)).makeRadius(5.0).addTapAction { view in
            self.areaBtn()
        }
        return btn
    }()
    
    lazy var BroveBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.sf.backgroundColor(.random).frame(CGRect(x: (SCREENW - 200) / 2, y: 270, width: 200, height: 50)).title("城市").tintColor(.white).titleFont(UIFont.systemFont(ofSize: 16.0, weight: .medium)).makeRadius(5.0).addTapAction { view in
            self.cityBtn()
        }
        return btn
    }()
    
    lazy var GammaBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.sf.backgroundColor(.random).frame(CGRect(x: (SCREENW - 200) / 2, y: 340, width: 200, height: 50)).title("省").tintColor(.white).titleFont(UIFont.systemFont(ofSize: 16.0, weight: .medium)).makeRadius(5.0).addTapAction { view in
            self.provinceBtn()
        }
        return btn
    }()

}
