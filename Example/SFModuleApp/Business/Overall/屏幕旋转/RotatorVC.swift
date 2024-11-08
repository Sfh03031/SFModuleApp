//
//  RotatorVC.swift
//  RotatorExample
//
//  Created by sfh on 2024/7/10.
//

import UIKit
import JohnWick
import SFStyleKit
import SFServiceKit
import ScreenRotator

enum SegmentType: CaseIterable {
    case chat
    case question
    case chapter
}

@available(iOS 13.0, *)
class RotatorVC: UIViewController {
    
    var ScreenW: CGFloat = SCREENW
    var ScreenH: CGFloat = SCREENH
    var videoW: CGFloat = SCREENW
    var videoH: CGFloat = SCREENH / 3
    var btnW: CGFloat = SCREENW / 3
    var btnH: CGFloat = 60
    var pptW: CGFloat = 180
    var pptH: CGFloat = 140
    var margin: CGFloat = 20
    var videoTopH: CGFloat = TopHeight
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
                
        setup()
        
        ScreenRotator.shared.orientationMaskDidChange = { orientationMask in
            var temp = "竖屏"
            switch orientationMask {
            case .portrait:
                temp = "竖屏"
                break
            case .landscapeLeft:
                temp = "向左横屏"
                break
            case .landscapeRight:
                temp = "向右横屏"
                break
            default:
                temp = "竖屏"
                break
            }
            
            SF.WINDOW?.makeToast("当前屏幕方向: \(temp)")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        ScreenRotator.shared.isLockOrientationWhenDeviceOrientationDidChange = false
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        DispatchQueue.main.async {
            self.ScreenW = UIScreen.main.bounds.width
            self.ScreenH = UIScreen.main.bounds.height
            if ScreenRotator.shared.isPortrait {
                self.videoW = self.ScreenW
                self.videoH = self.ScreenH / 3
                self.btnW = self.ScreenW / 3
                self.videoTopH = TopHeight
                self.updatePortrait()
            } else {
                let with: CGFloat = self.ScreenW / 4
                self.videoW = self.ScreenW - with
                self.videoH = self.ScreenH
                self.btnW = with / 3
                self.videoTopH = 60
                self.updateLandScape()
            }
        }
    }
    
    func setup() {
        self.view.addSubview(videoLabel)
        self.view.addSubview(chatBtn)
        self.view.addSubview(questionBtn)
        self.view.addSubview(chapterBtn)
        self.view.addSubview(contentLabel)
        self.view.addSubview(pptLabel)
        
        videoTopView.addSubview(backLabel)
        videoTopView.addSubview(lockBtn)
        
        videoLabel.addSubview(videoTopView)
        
        self.view.bringSubviewToFront(pptLabel)
        
        updatePortrait()
    }
    
    func updatePortrait() {
        UIView.animate(withDuration: 0.25) {
            self.videoLabel.frame = CGRect(x: 0, y: 0, width: self.videoW, height: self.videoH)
            self.chatBtn.frame = CGRect(x: 0, y: self.videoH, width: self.btnW, height: self.btnH)
            self.questionBtn.frame = CGRect(x: self.btnW, y: self.videoH, width: self.btnW, height: self.btnH)
            self.chapterBtn.frame = CGRect(x: self.btnW * 2, y: self.videoH, width: self.btnW, height: self.btnH)
            self.contentLabel.frame = CGRect(x: 0, y: self.videoH + self.btnH, width: self.ScreenW, height: self.ScreenH - self.videoH - self.btnH)
            self.pptLabel.frame = CGRect(x: self.ScreenW - self.margin - self.pptW, y: self.videoTopH + self.margin, width: self.pptW, height: self.pptH)
            
            self.videoTopView.frame = CGRect(x: 0, y: 0, width: self.ScreenW, height: self.videoTopH)
            
            self.backLabel.frame = CGRect(x: 20, y: TopStatusBar, width: 100, height: self.videoTopH - TopStatusBar)
            self.lockBtn.frame = CGRect(x: self.ScreenW - 60, y: TopStatusBar + (self.videoTopH - TopStatusBar - 40) / 2, width: 40, height: 40)
        }
        
    }
    
    func updateLandScape() {
        UIView.animate(withDuration: 0.25) {
            self.videoLabel.frame = CGRect(x: 0, y: 0, width: self.videoW, height: self.videoH)
            self.chatBtn.frame = CGRect(x: self.videoW, y: 0, width: self.btnW, height: self.btnH)
            self.questionBtn.frame = CGRect(x: self.videoW + self.btnW, y: 0, width: self.btnW, height: self.btnH)
            self.chapterBtn.frame = CGRect(x: self.videoW + self.btnW * 2, y: 0, width: self.btnW, height: self.btnH)
            self.contentLabel.frame = CGRect(x: self.videoW, y: self.btnH, width: self.btnW * 3, height: self.ScreenH - self.btnH)
            
            self.pptLabel.frame = CGRect(x: self.ScreenW - self.margin - self.pptW, y: self.videoTopH + self.margin, width: self.pptW, height: self.pptH)
            
            self.videoTopView.frame = CGRect(x: 0, y: 0, width: self.videoW, height: self.videoTopH)
            
            self.backLabel.frame = CGRect(x: 20, y: 0, width: 100, height: self.videoTopH)
            self.lockBtn.frame = CGRect(x: self.videoW - 60, y: (self.videoTopH - 40) / 2, width: 40, height: 40)
        }
    }
    
    /// 显隐工具条
    @objc func tapVideo(_ sender: UILabel) {
        self.videoTopView.isHidden = !self.videoTopView.isHidden
    }
    
    /// 退出
    @objc func back(_ sender: UILabel) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// 锁定方向
    @objc func lock(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        ScreenRotator.shared.isLockOrientationWhenDeviceOrientationDidChange = sender.isSelected
        if sender.isSelected {
            SF.WINDOW?.makeToast("锁定，屏幕方向不会随设备摆动自动改变")
        } else {
            SF.WINDOW?.makeToast("取消锁定，屏幕方向会随设备摆动自动改变")
        }
    }
    
    @objc func pptTap(_ sender: UITapGestureRecognizer) {
        pptLabel.text = pptLabel.text == "PPT" ? "视频区" : "PPT"
        pptLabel.backgroundColor = pptLabel.text == "PPT" ? UIColor.lightGray.withAlphaComponent(0.5) : UIColor.brown
        
        videoLabel.text = pptLabel.text == "PPT" ? "视频区" : "PPT"
        videoLabel.backgroundColor = pptLabel.text == "PPT" ? UIColor.brown : UIColor.lightGray.withAlphaComponent(0.5)
    }
    
    /// 拖动PPT
    @objc func pptPan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            break
        case .changed:
            //获取拖拽的point的坐标
            let translation = sender.translation(in: self.view)
            //修改被拖拽的视图的坐标
            sender.view?.center = CGPoint.init(x: (sender.view?.center.x)! + translation.x, y: (sender.view?.center.y)! + translation.y)
            //在坐标系里设置视图的translate
            sender.setTranslation(CGPointZero, in: self.view)
            break
        default:
            break
        }
    }
    
    @objc func chatBtnTap(_ sender: UIButton) {
        switchType(.chat)
    }
    
    @objc func questionBtnTap(_ sender: UIButton) {
        switchType(.question)
    }
    
    @objc func chapterBtnTap(_ sender: UIButton) {
        switchType(.chapter)
    }
    
    /// 模拟切换
    func switchType(_ type: SegmentType) {
        chatBtn.setTitleColor(type == .chat ? .white : .lightGray, for: .normal)
        questionBtn.setTitleColor(type == .question ? .white : .lightGray, for: .normal)
        chapterBtn.setTitleColor(type == .chapter ? .white : .lightGray, for: .normal)
        
        chatBtn.backgroundColor = type == .chat ? .red.withAlphaComponent(0.5) : .white
        questionBtn.backgroundColor = type == .question ? .orange.withAlphaComponent(0.5) : .white
        chapterBtn.backgroundColor = type == .chapter ? .blue.withAlphaComponent(0.5) : .white
        
        switch type {
        case .chat:
            contentLabel.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            contentLabel.text = "聊天区"
            break
        case .question:
            contentLabel.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            contentLabel.text = "提问区"
            break
        case .chapter:
            contentLabel.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
            contentLabel.text = "章节区"
            break
        }
    }
    
    // MARK: - lazyload
    
    lazy var videoLabel: UILabel = {
        let label = UILabel()
        label.sf.frame(CGRect(x: 0, y: 0, width: ScreenW, height: videoH))
            .backgroundColor(.brown)
            .text("视频区")
            .textColor(.white)
            .font(UIFont.systemFont(ofSize: 20.0, weight: .medium))
            .alignment(.center)
            .isUserInteractionEnabled(true)
            .addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapVideo(_:))))
        return label
    }()
    
    lazy var videoTopView: UIView = {
        let view = UIView()
        view.sf.frame(CGRect(x: 0, y: 0, width: ScreenW, height: videoTopH)).backgroundColor(.white.withAlphaComponent(0.5))
        return view
    }()
    
    lazy var backLabel: UILabel = {
        let label = UILabel()
        label.sf.frame(CGRect(x: 20, y: 0, width: 100, height: videoTopH))
            .text("退出")
            .alignment(.left)
            .isUserInteractionEnabled(true)
            .addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(back(_:))))
        return label
    }()
    
    lazy var lockBtn: UIButton = {
        let lockImg = SFSymbolManager.shared.symbol(systemName: "lock.slash", withConfiguration: nil, withTintColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
        let unlockImg = SFSymbolManager.shared.symbol(systemName: "lock.open", withConfiguration: nil, withTintColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
        
        let btn = UIButton(type: .custom)
        btn.sf.image(unlockImg, for: .normal)
            .image(lockImg, for: .selected)
            .addTarget(self, action: #selector(lock(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var chatBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.sf.frame(CGRect(x: 0, y: videoH, width: btnW, height: btnH))
            .backgroundColor(.red.withAlphaComponent(0.5))
            .title("聊天")
            .titleColor(.white)
            .titleFont(UIFont.systemFont(ofSize: 14.0, weight: .medium))
            .addTarget(self, action: #selector(chatBtnTap(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var questionBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.sf.frame(CGRect(x: btnW, y: videoH, width: btnW, height: btnH))
            .backgroundColor(.white)
            .title("提问")
            .titleColor(.lightGray)
            .titleFont(UIFont.systemFont(ofSize: 14.0, weight: .medium))
            .addTarget(self, action: #selector(questionBtnTap(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var chapterBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.sf.frame(CGRect(x: btnW * 2, y: videoH, width: btnW, height: btnH))
            .backgroundColor(.white)
            .title("章节")
            .titleColor(.lightGray)
            .titleFont(UIFont.systemFont(ofSize: 14.0, weight: .medium))
            .addTarget(self, action: #selector(chapterBtnTap(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.sf.frame(CGRect(x: 0, y: videoH + btnH, width: ScreenW, height: ScreenH - videoH - btnH))
            .backgroundColor(.red)
            .text("聊天区")
            .textColor(.white)
            .font(UIFont.systemFont(ofSize: 30.0, weight: .medium))
            .alignment(.center)
        return label
    }()

    
    lazy var pptLabel: UILabel = {
        let label = UILabel()
        label.sf.frame(CGRect(x: ScreenW - margin - pptW, y: margin, width: pptW, height: pptH))
            .backgroundColor(.lightGray.withAlphaComponent(0.5))
            .text("PPT")
            .textColor(.white)
            .font(UIFont.systemFont(ofSize: 20.0, weight: .medium))
            .alignment(.center)
            .makeRadius(10.0)
            .isUserInteractionEnabled(true)
            .addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pptTap(_:))))
            .addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(pptPan(_:))))
        return label
    }()

}
