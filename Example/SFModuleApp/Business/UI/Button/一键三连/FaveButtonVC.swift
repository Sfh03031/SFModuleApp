//
//  FaveButtonVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/23.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SFStyleKit
import FaveButton
//import WCLShineButton
//import DOFavoriteButton

func color(_ rgbColor: Int) -> UIColor{
    return UIColor(
        red:   CGFloat((rgbColor & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbColor & 0x00FF00) >> 8 ) / 255.0,
        blue:  CGFloat((rgbColor & 0x0000FF) >> 0 ) / 255.0,
        alpha: CGFloat(1.0)
    )
}

var btnWH:CGFloat = 66
var margin:CGFloat = (SCREENW - 4 * btnWH) / 5

var dobtnWH:CGFloat = 88
var domargin:CGFloat = (SCREENW - 4 * dobtnWH) / 5

var btnWH2:CGFloat = 44
var margin2:CGFloat = (SCREENW - 5 * btnWH2) / 6

class FaveButtonVC: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // FaveButton
        self.view.addSubview(btn5)
        self.view.addSubview(btn6)
        self.view.addSubview(btn7)
        self.view.addSubview(btn8)
        
        btn5.setSelected(selected: true, animated: false)
        btn6.setSelected(selected: false, animated: false)
        btn7.setSelected(selected: true, animated: false)
        btn8.setSelected(selected: false, animated: false)
        
        // DOFavoriteButton
        self.view.addSubview(btn9)
        self.view.addSubview(btn10)
        self.view.addSubview(btn11)
        self.view.addSubview(btn12)
        
        // WCLShineButton
        self.view.addSubview(btn13)
        self.view.addSubview(btn14)
        self.view.addSubview(btn15)
        self.view.addSubview(btn16)
        self.view.addSubview(btn17)
    }
    
    /// DOFavoriteButton点击事件
    @objc func dofaveTap(_ sender: DOFavoriteButton) {
        if sender.isSelected {
            sender.deselect()
        } else {
            sender.select()
        }
    }
    
    /// WCLShineButton的valueChanged事件
    @objc func wclTap(_ sender: WCLShineButton) {
        sender.isSelected = !sender.isSelected
        sender.setClicked(!sender.isSelected)
    }
    
    //MARK: FaveButton
    
    //FIXME: 必须通过init(frame: CGRect, faveIconNormal: UIImage?)方法创建按钮，布局方法不管用
    lazy var btn5: FaveButton = {
        let view = FaveButton(frame: CGRect(x: margin, y: SCREENH / 2 - 200, width: btnWH, height: btnWH), faveIconNormal: UIImage(named: "fave_star"))
        view.normalColor = .lightGray
        view.selectedColor = .orange
        view.dotFirstColor = .random
        view.dotSecondColor = .random
        view.circleFromColor = .random
        view.circleToColor = .random
        view.delegate = self
        return view
    }()

    lazy var btn6: FaveButton = {
        let view = FaveButton(frame: CGRect(x: margin * 2 + btnWH, y: SCREENH / 2 - 200, width: btnWH, height: btnWH), faveIconNormal: UIImage(named: "fave_heart"))
        view.normalColor = .lightGray
        view.selectedColor = .red
        view.dotFirstColor = .random
        view.dotSecondColor = .random
        view.circleFromColor = .random
        view.circleToColor = .random
        view.delegate = self
        return view
    }()
    
    lazy var btn7: FaveButton = {
        let view = FaveButton(frame: CGRect(x: margin * 3 + btnWH * 2, y: SCREENH / 2 - 200, width: btnWH, height: btnWH), faveIconNormal: UIImage(named: "fave_smile"))
        view.normalColor = .lightGray
        view.selectedColor = .blue
        view.dotFirstColor = .random
        view.dotSecondColor = .random
        view.circleFromColor = .random
        view.circleToColor = .random
        view.delegate = self
        return view
    }()
    
    lazy var btn8: FaveButton = {
        let view = FaveButton(frame: CGRect(x: margin * 4 + btnWH * 3, y: SCREENH / 2 - 200, width: btnWH, height: btnWH), faveIconNormal: UIImage(named: "fave_like"))
        view.normalColor = .lightGray
        view.selectedColor = .green
        view.dotFirstColor = .random
        view.dotSecondColor = .random
        view.circleFromColor = .random
        view.circleToColor = .random
        view.delegate = self
        return view
    }()
    
    //MARK: DOFavoriteButton
    lazy var btn9: DOFavoriteButton = {
        let view = DOFavoriteButton(frame: CGRect(x: domargin, y: SCREENH / 2, width: dobtnWH, height: dobtnWH), image: UIImage(named: "fave_star"))
        view.imageColorOff = .lightGray
        view.imageColorOn = .orange
        view.circleColor = .random
        view.lineColor = .random
        view.duration = 1.0
        view.addTarget(self, action: #selector(dofaveTap(_:)), for: .touchUpInside)
        return view
    }()
    
    lazy var btn10: DOFavoriteButton = {
        let view = DOFavoriteButton(frame: CGRect(x: domargin * 2 + dobtnWH, y: SCREENH / 2, width: dobtnWH, height: dobtnWH), image: UIImage(named: "fave_heart"))
        view.imageColorOff = .lightGray
        view.imageColorOn = .red
        view.circleColor = .random
        view.lineColor = .random
        view.duration = 1.0
        view.addTarget(self, action: #selector(dofaveTap(_:)), for: .touchUpInside)
        return view
    }()
    
    lazy var btn11: DOFavoriteButton = {
        let view = DOFavoriteButton(frame: CGRect(x: domargin * 3 + dobtnWH * 2, y: SCREENH / 2, width: dobtnWH, height: dobtnWH), image: UIImage(named: "fave_smile"))
        view.imageColorOff = .lightGray
        view.imageColorOn = .blue
        view.circleColor = .random
        view.lineColor = .random
        view.duration = 1.0
        view.addTarget(self, action: #selector(dofaveTap(_:)), for: .touchUpInside)
        return view
    }()
    
    lazy var btn12: DOFavoriteButton = {
        let view = DOFavoriteButton(frame: CGRect(x: domargin * 4 + dobtnWH * 3, y: SCREENH / 2, width: dobtnWH, height: dobtnWH), image: UIImage(named: "fave_like"))
        view.imageColorOff = .lightGray
        view.imageColorOn = .green
        view.circleColor = .random
        view.lineColor = .random
        view.duration = 1.0
        view.addTarget(self, action: #selector(dofaveTap(_:)), for: .touchUpInside)
        return view
    }()
    
    //MARK: WCLShineButton
    lazy var btn13: WCLShineButton = {
        var param = WCLShineParams()
        param.bigShineColor = .red
        param.smallShineColor = .orange
        param.animDuration = 1
        let view = WCLShineButton(frame: CGRect(x: margin2, y: SCREENH / 2 + 200, width: btnWH2, height: btnWH2), params: param)
        view.image = .star
        view.color = .lightGray
        view.fillColor = .orange
        view.addTarget(self, action: #selector(wclTap(_:)), for: .valueChanged)
        return view
    }()
    
    lazy var btn14: WCLShineButton = {
        var param = WCLShineParams()
        param.bigShineColor = .systemTeal
        param.smallShineColor = .brown
        param.shineCount = 5
        param.animDuration = 1
        param.smallShineOffsetAngle = -5
        let view = WCLShineButton(frame: CGRect(x: margin2 * 2 + btnWH2, y: SCREENH / 2 + 200, width: btnWH2, height: btnWH2), params: param)
        view.image = .heart
        view.color = .lightGray
        view.fillColor = .red
        view.addTarget(self, action: #selector(wclTap(_:)), for: .valueChanged)
        return view
    }()
    
    lazy var btn15: WCLShineButton = {
        var param = WCLShineParams()
        param.allowRandomColor = true
        param.animDuration = 1
        let view = WCLShineButton(frame: CGRect(x: margin2 * 3 + btnWH2 * 2, y: SCREENH / 2 + 200, width: btnWH2, height: btnWH2), params: param)
        view.image = .smile
        view.color = .lightGray
        view.fillColor = .blue
        view.isSelected = true
        view.addTarget(self, action: #selector(wclTap(_:)), for: .valueChanged)
        return view
    }()
    
    lazy var btn16: WCLShineButton = {
        var param = WCLShineParams()
        param.enableFlashing = true
        param.animDuration = 2
        let view = WCLShineButton(frame: CGRect(x: margin2 * 4 + btnWH2 * 3, y: SCREENH / 2 + 200, width: btnWH2, height: btnWH2), params: param)
        view.image = .like
        view.color = .lightGray
        view.fillColor = .green
        view.addTarget(self, action: #selector(wclTap(_:)), for: .valueChanged)
        return view
    }()
    
    lazy var btn17: WCLShineButton = {
        var param = WCLShineParams()
        param.bigShineColor = .purple
        param.animDuration = 1
        
        let defImg = SFSymbol.symbol(name: "link.circle.fill", tintColor: .gray)!
        let selImg = SFSymbol.symbol(name: "fan.oscillation", tintColor: .red)!
        let view = WCLShineButton(frame: CGRect(x: margin2 * 5 + btnWH2 * 4, y: SCREENH / 2 + 200, width: btnWH2, height: btnWH2), params: param)
        //FIXME: defaultAndSelect方法的图片不能被改变颜色
        view.image = .defaultAndSelect(defImg, selImg)
        //FIXME: custom方法的图片可通过fillColor改变颜色
//        view.image = .custom(SFSymbol.symbol(name: "fan.oscillation")!)
//        view.fillColor = .red
        view.addTarget(self, action: #selector(wclTap(_:)), for: .valueChanged)
        return view
    }()
}

//MARK: - FaveButtonDelegate
extension FaveButtonVC: FaveButtonDelegate {
    
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {
        if faveButton == btn5 {
            print("tap star: \(btn5.isSelected)")
        } else if faveButton == btn6 {
            print("tap heart: \(btn6.isSelected)")
        } else if faveButton == btn7 {
            print("tap smile: \(btn7.isSelected)")
        } else {
            print("tap hand: \(btn8.isSelected)")
        }
    }
    
    func faveButtonDotColors(_ faveButton: FaveButton) -> [DotColors]? {
//        return [
//            DotColors(first: color(0x7DC2F4), second: color(0xE2264D)),
//            DotColors(first: color(0xF8CC61), second: color(0x9BDFBA)),
//            DotColors(first: color(0xAF90F4), second: color(0x90D1F9)),
//            DotColors(first: color(0xE9A966), second: color(0xF8C852)),
//            DotColors(first: color(0xF68FA7), second: color(0xF6A2B8))
//        ]
        return nil
    }
}
