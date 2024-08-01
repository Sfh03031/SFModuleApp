//
//  PerformanceMonitorVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/6/14.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import UIFontComplete
import GDPerformanceView_Swift

class PerformanceMonitorVC: BaseViewController {
    
    var isPause: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(startBtn)
        self.view.addSubview(pauseBtn)
        self.view.addSubview(stopBtn)
        
        self.view.addSubview(allBtn)
        self.view.addSubview(defBtn)
        
        self.view.addSubview(darkBtn)
        self.view.addSubview(lightBtn)
        self.view.addSubview(randomBtn)
        
        let margin: CGFloat = 20.0
        let btnW: CGFloat = (SCREENW - margin * 4) / 3
        startBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: btnW, height: 50))
            make.left.equalTo(margin)
            make.top.equalTo(TopHeight + margin)
        }
        
        pauseBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: btnW, height: 50))
            make.left.equalTo(margin * 2 + btnW)
            make.top.equalTo(TopHeight + margin)
        }
        
        stopBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: btnW, height: 50))
            make.left.equalTo(margin * 3 + btnW * 2)
            make.top.equalTo(TopHeight + margin)
        }
        
        let margin1: CGFloat = 20.0
        let btnW1: CGFloat = (SCREENW - margin1 * 3) / 2
        allBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: btnW1, height: 50))
            make.left.equalTo(margin1)
            make.top.equalTo(TopHeight + 100)
        }
        
        defBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: btnW1, height: 50))
            make.left.equalTo(margin1 * 2 + btnW1)
            make.top.equalTo(TopHeight + 100)
        }
        
        darkBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: btnW, height: 50))
            make.left.equalTo(margin)
            make.top.equalTo(TopHeight + 200)
        }
        
        lightBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: btnW, height: 50))
            make.left.equalTo(margin * 2 + btnW)
            make.top.equalTo(TopHeight + 200)
        }
        
        randomBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: btnW, height: 50))
            make.left.equalTo(margin * 3 + btnW * 2)
            make.top.equalTo(TopHeight + 200)
        }
    }
    
    //MARK: - click event
    
    @objc func start(_ sender: UIButton) {
        PerformanceMonitor.shared().show()
    }
    
    @objc func pause(_ sender: UIButton) {
        isPause = !isPause
        
        if isPause {
            PerformanceMonitor.shared().start()
        } else {
            PerformanceMonitor.shared().pause()
        }
        
    }
    
    @objc func stop(_ sender: UIButton) {
        PerformanceMonitor.shared().hide()
    }
    
    @objc func all(_ sender: UIButton) {
        PerformanceMonitor.shared().performanceViewConfigurator.options = .all
    }
    
    @objc func def(_ sender: UIButton) {
        PerformanceMonitor.shared().performanceViewConfigurator.options = .default
    }
    
    @objc func dark(_ sender: UIButton) {
        PerformanceMonitor.shared().performanceViewConfigurator.style = .dark
    }
    
    @objc func light(_ sender: UIButton) {
        PerformanceMonitor.shared().performanceViewConfigurator.style = .light
    }
    
    @objc func random(_ sender: UIButton) {
        PerformanceMonitor.shared().performanceViewConfigurator.style = .custom(backgroundColor: .random, borderColor: .random, borderWidth: 1.0, cornerRadius: 5.0, textColor: .random, font: UIFont.init(font: .menloItalic, size: 8)!)
    }
    
    //MARK: - lazyload

    lazy var startBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("显示", for: .normal)
        btn.setTitleColor(.random, for: .normal)
        btn.addTarget(self, action: #selector(start(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var pauseBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("暂停", for: .normal)
        btn.setTitleColor(.random, for: .normal)
        btn.addTarget(self, action: #selector(pause(_:)), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var stopBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("隐藏", for: .normal)
        btn.setTitleColor(.random, for: .normal)
        btn.addTarget(self, action: #selector(stop(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var allBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("所有信息", for: .normal)
        btn.setTitleColor(.random, for: .normal)
        btn.addTarget(self, action: #selector(all(_:)), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var defBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("默认", for: .normal)
        btn.setTitleColor(.random, for: .normal)
        btn.addTarget(self, action: #selector(def(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var darkBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("暗色", for: .normal)
        btn.setTitleColor(.random, for: .normal)
        btn.addTarget(self, action: #selector(dark(_:)), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var lightBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("亮色", for: .normal)
        btn.setTitleColor(.random, for: .normal)
        btn.addTarget(self, action: #selector(light(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var randomBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("自定义", for: .normal)
        btn.setTitleColor(.random, for: .normal)
        btn.addTarget(self, action: #selector(random(_:)), for: .touchUpInside)
        return btn
    }()

}
