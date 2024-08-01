//
//  SpreadSheetVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/26.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import ScreenRotator

class SpreadSheetVC: BaseViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        ScreenRotator.shared.isLockOrientationWhenDeviceOrientationDidChange = false
        ScreenRotator.shared.rotationToPortrait()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn1 = UIButton(type: .custom)
        btn1.sf.title("班级信息表").titleColor(.blue).titleFont(UIFont.systemFont(ofSize: 17)).addTapAction { view in
            let vc = ClassDataVC()
            vc.title = "班级信息"
            self.sf.push(vc)
        }
        self.view.addSubview(btn1)
        
        let btn2 = UIButton(type: .custom)
        btn2.sf.title("甘特图表").titleColor(.blue).titleFont(UIFont.systemFont(ofSize: 17)).addTapAction { view in
            let vc = GanttChartVC()
            vc.title = "甘特图"
            self.sf.push(vc)
        }
        self.view.addSubview(btn2)
        
        let btn3 = UIButton(type: .custom)
        btn3.sf.title("日程表").titleColor(.blue).titleFont(UIFont.systemFont(ofSize: 17)).addTapAction { view in
            let vc = ScheduleVC()
            vc.title = "日程安排"
            self.sf.push(vc)
        }
        self.view.addSubview(btn3)
        
        let btn4 = UIButton(type: .custom)
        btn4.sf.title("时间表").titleColor(.blue).titleFont(UIFont.systemFont(ofSize: 17)).addTapAction { view in
            let vc = TimetableVC()
            vc.title = "时间表"
            self.sf.push(vc)
        }
        self.view.addSubview(btn4)
        
        btn1.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(TopHeight + 100)
        }
        
        btn2.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(btn1.snp.bottom).offset(20)
        }
        
        btn3.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(btn2.snp.bottom).offset(20)
        }
        
        btn4.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(btn3.snp.bottom).offset(20)
        }

    }

}
