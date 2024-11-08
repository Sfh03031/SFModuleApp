//
//  DatePickerVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/22.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import JohnWick
import SFStyleKit

class DatePickerVC: BaseViewController {

    fileprivate var mode: UIDatePicker.Mode = .dateAndTime
    fileprivate var style: UIDatePickerStyle = .inline
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .hex_F5F5F9
        
        self.view.addSubview(AlphaBtn)
        AlphaBtn.center = self.view.center
        
        self.view.addSubview(BroveBtn)
        self.view.addSubview(GammaBtn)
    }
    
    func tapBtn() {
        SFDatePickerVC(self.mode, style: self.style) { date in
            let formart = DateFormatter()
            formart.timeZone = TimeZone.current // 时区
            // 时间格式, HH-强制为24小时制，hh-跟随系统,设置->通用->日期与时间->24小时制(是个滑动开关)
            formart.dateFormat = "yyyy-MM-dd HH:mm:ss"
            SF.WINDOW?.makeToast(formart.string(from: date))
        }.show()
    }
    
    func chooseMode() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "countDownTimer", style: .default, handler: { action in
            self.mode = .countDownTimer
            self.BroveBtn.setTitle("countDownTimer", for: .normal)
        }))
        alert.addAction(UIAlertAction(title: "date", style: .default, handler: { action in
            self.mode = .date
            self.BroveBtn.setTitle("date", for: .normal)
        }))
        alert.addAction(UIAlertAction(title: "dateAndTime", style: .default, handler: { action in
            self.mode = .dateAndTime
            self.BroveBtn.setTitle("dateAndTime", for: .normal)
        }))
        alert.addAction(UIAlertAction(title: "time", style: .default, handler: { action in
            self.mode = .time
            self.BroveBtn.setTitle("time", for: .normal)
        }))
        self.present(alert, animated: true)
    }
    
    func chooseStyle() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "automatic", style: .default, handler: { action in
            self.style = .automatic
            self.GammaBtn.setTitle("automatic", for: .normal)
        }))
        if self.mode != .countDownTimer {
            alert.addAction(UIAlertAction(title: "compact", style: .default, handler: { action in
                self.style = .compact
                self.GammaBtn.setTitle("compact", for: .normal)
            }))
        }
        if self.mode != .countDownTimer && self.mode != .date {
            alert.addAction(UIAlertAction(title: "inline", style: .default, handler: { action in
                self.style = .inline
                self.GammaBtn.setTitle("inline", for: .normal)
            }))
        }
        alert.addAction(UIAlertAction(title: "wheels", style: .default, handler: { action in
            self.style = .wheels
            self.GammaBtn.setTitle("wheels", for: .normal)
        }))
        self.present(alert, animated: true)
    }
    
    // MARK: lazyload

    lazy var AlphaBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.sf.backgroundColor(.random).frame(CGRect(x: 0, y: 0, width: 200, height: 50)).title("tap").tintColor(.white).titleFont(UIFont.systemFont(ofSize: 16.0, weight: .medium)).makeRadius(5.0).addTapAction { view in
            self.tapBtn()
        }
        return btn
    }()
    
    lazy var BroveBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.sf.backgroundColor(.random).frame(CGRect(x: (SCREENW - 300) / 3, y: SCREENH - 100, width: 150, height: 50)).title("dateAndTime").tintColor(.white).titleFont(UIFont.systemFont(ofSize: 16.0, weight: .medium)).makeRadius(5.0).addTapAction { view in
            self.chooseMode()
        }
        return btn
    }()
    
    lazy var GammaBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.sf.backgroundColor(.random).frame(CGRect(x: SCREENW - (SCREENW - 300) / 3 - 150, y: SCREENH - 100, width: 150, height: 50)).title("inline").tintColor(.white).titleFont(UIFont.systemFont(ofSize: 16.0, weight: .medium)).makeRadius(5.0).addTapAction { view in
            self.chooseStyle()
        }
        return btn
    }()

}
