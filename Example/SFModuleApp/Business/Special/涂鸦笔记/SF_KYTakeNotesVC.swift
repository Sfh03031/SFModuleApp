//
//  SF_KYTakeNotesVC.swift
//  SparkBase
//
//  Created by sfh on 2023/7/28.
//  Copyright © 2023 Spark. All rights reserved.
//

import UIKit
import SwiftyJSON

///画板枚举
enum SF_KYTakeNoteType {
    ///涂鸦
    case lineType
    ///写字
    case textType
}

typealias SF_KYTakeNotesVCBlock = (_ dic: [String: Any]) -> Void

class SF_KYTakeNotesVC: BaseViewController {
    
    var backBlock: SF_KYTakeNotesVCBlock!
    
    var courseKey: String = "" //网课key
    var videoKey: String = "" //录播小节key
    var key: String = "" //笔记key
    var TNImage: UIImage = UIImage()
    var TNPath: String = ""
    var isfrom: String = "0" //0-做笔记 1-看笔记
    var withArr:[CGFloat] = [1, 2, 4, 7]
    var fontArr: [CGFloat] = [16, 20, 24, 30, 36, 48, 56]
    var colorArr:[String] = ["#FF3A2F", "#FECC01", "#008AFF", "#32C759", "#000000"]
    var TNWith: CGFloat = 1
    var TNFont: CGFloat = 16
    var TNColor: String = "#FF3A2F"
    var isDeleting: Bool = false //是否选中逐条删除
    var isKeyboardShow: Bool = false //是否弹出键盘
    var tnType: SF_KYTakeNoteType = .lineType //默认涂鸦画板
    var lines: [Any] = [] //保存涂鸦
    var textViewArr: [UIView] = [] //保存写字

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        forceOrientationLandscape()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        loadViews()
    }
    
    //TODO: deinit
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //MARK: - noti methods
    
    ///键盘出现
    @objc func keyboardWillShow(_ noti: Notification) {
        self.isKeyboardShow = true
        self.drawTextView.isKeyboardShow = true
        if let info = noti.userInfo as? NSDictionary,
           let value = info.object(forKey: UIKeyboardFrameEndUserInfoKey) as? NSValue {
            let height = value.cgRectValue.size.height
            UIView.animate(withDuration: 0.2, delay: 0) {
                if isIPad {
                    self.baseView.frame = CGRect(x: 0, y: (self.view.bounds.height - self.view.bounds.width * 9.0 / 16.0)/2 - height, width: self.view.bounds.width, height: self.view.bounds.width * 9.0 / 16.0)
                    self.drawLineView.frame = CGRect(x: 0, y: (self.view.bounds.height - self.view.bounds.width * 9.0 / 16.0)/2 - height, width: self.view.bounds.width, height: self.view.bounds.width * 9.0 / 16.0)
                    self.drawTextView.frame = CGRect(x: 0, y: (self.view.bounds.height - self.view.bounds.width * 9.0 / 16.0)/2 - height, width: self.view.bounds.width, height: self.view.bounds.width * 9.0 / 16.0)
                } else {
                    self.baseView.frame = CGRect(x: (self.view.bounds.width - self.view.bounds.height * 16.0 / 9.0)/2, y: -height, width: self.view.bounds.height * 16.0 / 9.0, height: self.view.bounds.height)
                    self.drawLineView.frame = CGRect(x: (self.view.bounds.width - self.view.bounds.height * 16.0 / 9.0)/2, y: -height, width: self.view.bounds.height * 16.0 / 9.0, height: self.view.bounds.height)
                    self.drawTextView.frame = CGRect(x: (self.view.bounds.width - self.view.bounds.height * 16.0 / 9.0)/2, y: -height, width: self.view.bounds.height * 16.0 / 9.0, height: self.view.bounds.height)
                }
            }
        }
    }
    
    ///键盘消失
    @objc func keyboardWillHide(_ noti: Notification) {
        self.isKeyboardShow = false
        UIView.animate(withDuration: 0.2, delay: 0, animations: {
            if isIPad {
                self.baseView.frame = CGRect(x: 0, y: (self.view.bounds.height - self.view.bounds.width * 9.0 / 16.0)/2, width: self.view.bounds.width, height: self.view.bounds.width * 9.0 / 16.0)
                self.drawLineView.frame = CGRect(x: 0, y: (self.view.bounds.height - self.view.bounds.width * 9.0 / 16.0)/2, width: self.view.bounds.width, height: self.view.bounds.width * 9.0 / 16.0)
                self.drawTextView.frame = CGRect(x: 0, y: (self.view.bounds.height - self.view.bounds.width * 9.0 / 16.0)/2, width: self.view.bounds.width, height: self.view.bounds.width * 9.0 / 16.0)
            } else {
                self.baseView.frame = CGRect(x: (self.view.bounds.width - self.view.bounds.height * 16.0 / 9.0)/2, y: 0, width: self.view.bounds.height * 16.0 / 9.0, height: self.view.bounds.height)
                self.drawLineView.frame = CGRect(x: (self.view.bounds.width - self.view.bounds.height * 16.0 / 9.0)/2, y: 0, width: self.view.bounds.height * 16.0 / 9.0, height: self.view.bounds.height)
                self.drawTextView.frame = CGRect(x: (self.view.bounds.width - self.view.bounds.height * 16.0 / 9.0)/2, y: 0, width: self.view.bounds.height * 16.0 / 9.0, height: self.view.bounds.height)
            }
            
        }) { finished in
            if finished {
                self.drawTextView.isKeyboardShow = false
            }
        }
    }
    
    //MARK: - initViews
    
    func loadViews() {
        self.view.addSubview(baseView)
        self.view.addSubview(drawLineView)
        self.view.addSubview(drawTextView)
        self.view.insertSubview(drawTextView, belowSubview: drawLineView)
        
        if self.isfrom == "0" {
            baseView.image = self.TNImage
            if let w = UserDefaults.standard.value(forKey: "TNWith&&\(videoKey)") as? CGFloat {
                TNWith = w
            }
            if let c = UserDefaults.standard.value(forKey: "TNColor&&\(videoKey)") as? String {
                TNColor = c
            }
            if let f = UserDefaults.standard.value(forKey: "TNFont&&\(videoKey)") as? CGFloat {
                TNFont = f
            }
        } else {
            baseView.kf.setImage(with: NSURL.init(string: TNPath) as URL?)
        }
        
        //加载工具条
        loadToolView()
        //属性赋值
        reloadWCF()
        //处理回调
        loadCallBack()
    }
    
    ///属性赋值
    func reloadWCF() {
        toolView.finalWith = TNWith
        toolView.finalColor = TNColor
        toolView.finalFont = TNFont
        drawLineView.TNWith = TNWith
        drawLineView.TNColor = UIColor.sf.hexColor(hex: TNColor)
        drawTextView.TNFont = TNFont
        drawTextView.TNColor = UIColor.sf.hexColor(hex: TNColor)
    }
    
    ///缓存宽度、颜色、字号
    func saveWCFCache() {
        UserDefaults.standard.set(TNWith, forKey: "TNWith&&\(videoKey)")
        UserDefaults.standard.set(TNColor, forKey: "TNColor&&\(videoKey)")
        UserDefaults.standard.set(TNFont, forKey: "TNFont&&\(videoKey)")
        UserDefaults.standard.synchronize()
    }
    
    ///加载工具条视图
    func loadToolView() {
        self.view.addSubview(self.toolView)
        UIView.animate(withDuration: 0.2) {
            self.toolView.frame =  CGRect(x: 120, y: 10, width: SCREENW - 240, height: 44)
            self.toolView.alpha = 1
        }
        //判断已做笔记，修改按钮状态
        self.checkDrawRes()
    }
    
    ///屏幕的哪些边缘不需要首先响应系统手势
    override func preferredScreenEdgesDeferringSystemGestures() -> UIRectEdge {
        return UIRectEdge.all
    }
    
    //MARK: - block methods
    
    ///处理回调
    func loadCallBack() {
        //选择线宽、颜色的回调
        toolView.tapFinalBlock = {[weak self] (kwith, kcolor) in
            self?.TNWith = kwith
            self?.TNColor = kcolor
            self?.reloadWCF() //刷新画板属性
            self?.saveWCFCache() //缓存画板属性
        }
        
        //显示选择字体视图的回调
        toolView.tapShowBlock = {[weak self] (kwith, kcolor) in
            self?.loadChooseFontView()
        }
        
        //隐藏选择字体视图的回调
        toolView.tapHideBlock = {[weak self] (kwith, kcolor) in
            self?.hideChooseFontView()
        }
        
        //点击画笔，隐藏选择字体视图的回调
        toolView.tapPaintBlock = {[weak self] (kwith, kcolor) in
            self?.tnType = .lineType
            self?.updateDrawStatus() //刷新画板状态
            self?.hideChooseFontView() //隐藏选择字号视图
            self?.view.insertSubview(self!.drawTextView, belowSubview: self!.drawLineView)
        }
        
        //点击打字的回调
        toolView.tapFontBlock = {[weak self] (kwith, kcolor) in
            self?.tnType = .textType
            self?.updateDrawStatus() //刷新画板状态
            self?.view.insertSubview(self!.drawLineView, belowSubview: self!.drawTextView)
        }
        
        //选择字号的回调
        chooseFontView.chooseFontBlock = {[weak self] (kfont) in
            self?.TNFont = kfont
            self?.reloadWCF() //刷新画板属性
            self?.saveWCFCache() //缓存画板属性
            self?.hideChooseFontView() //隐藏选择字号视图
            self?.toolView.fontView.fontSize = kfont
        }
        
        //涂鸦回调
        drawLineView.callBackBlock = {[weak self] list in
            self?.lines = list
            self?.checkDrawRes() //校验画板内容，修改按钮状态
        }
        
        //打字回调
        drawTextView.callBackBlock = {[weak self] list in
            self?.textViewArr = list
            self?.checkDrawRes() //校验画板内容，修改按钮状态
        }
    }
    
    //MARK: - private methods
    
    ///加载选择字体视图
    private func loadChooseFontView() {
        self.view.addSubview(self.chooseFontView)
        UIView.animate(withDuration: 0.2) {
            self.chooseFontView.frame = CGRect(x: 270, y: 62, width: 396, height: 92)
            self.chooseFontView.alpha = 1
        }
    }
    
    ///隐藏选择字体视图
    private func hideChooseFontView() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.chooseFontView.frame = CGRect(x: 270, y: -100, width: 396, height: 92)
            self.chooseFontView.alpha = 0
        }) { finished in
            if finished {
                self.chooseFontView.removeFromSuperview()
            }
        }
    }
    
    ///判断画板内容，修改按钮状态
    private func checkDrawRes() {
        if self.lines.count > 0 || self.textViewArr.count > 0 {
            self.toolView.btnType = "1"
        } else {
            self.toolView.btnType = isfrom == "1" ? "2" : "0"
            self.toolView.delBtn.isSelected = false
            self.isDeleting = false
            self.updateDrawStatus()
        }
    }
    
    ///刷新画板状态
    private func updateDrawStatus() {
        if self.isDeleting {
            self.drawLineView.isDeleting = tnType == .lineType
            self.drawTextView.isDeleting = tnType == .textType
        } else {
            self.drawLineView.isDeleting = false
            self.drawTextView.isDeleting = false
        }
    }
    
    ///涂鸦内容渲染到图片
    private func renderDrawLine() {
        for i in 0..<self.textViewArr.count {
            if let temp = self.textViewArr[i] as? SF_TNTextItemView {
                let textLayer = CATextLayer()
                textLayer.frame = CGRect(x: temp.frame.origin.x, y: temp.frame.origin.y + 12, width: temp.frame.width - 12, height: temp.frame.width - 12)
                textLayer.backgroundColor = UIColor.clear.cgColor
                textLayer.contentsScale = UIScreen.main.scale
                textLayer.foregroundColor = temp.textView.textColor?.cgColor
                textLayer.alignmentMode = kCAAlignmentCenter
                textLayer.isWrapped = true
                textLayer.fontSize = temp.textView.font?.pointSize ?? 16
                textLayer.string = temp.textView.text
                self.baseView.layer.addSublayer(textLayer)
            }
        }
        
        self.textViewArr.removeAll()
        self.drawLineView.clearAll()
    }
    
    ///打字内容渲染到图片
    private func renderDrawText() {
        for i in 0..<self.lines.count {
            if let layer = self.lines[i] as? CAShapeLayer {
                let slayer = CAShapeLayer()
                slayer.path = layer.path
                slayer.backgroundColor = layer.backgroundColor
                slayer.fillColor = layer.fillColor
                slayer.lineCap = layer.lineCap
                slayer.lineJoin = layer.lineJoin
                slayer.strokeColor = layer.strokeColor
                slayer.lineWidth = layer.lineWidth
                self.baseView.layer.addSublayer(slayer)
            }
        }
        
        self.lines.removeAll()
        self.drawTextView.clearAll()
    }
    
    ///把涂鸦和打字渲染到图片后，重新获取一张新图
    private func getCurrentFrameImage() -> UIImage {
        UIGraphicsBeginImageContext(self.baseView.bounds.size)
        self.baseView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let imgae = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imgae!
    }
    
    ///上传图片并返回上级
    private func uploadDrawImg(img: UIImage) {
//        let imgData = UIImagePNGRepresentation(img) ?? Data()
        let param = ["courseKey": courseKey, "videoKey": videoKey, "key": self.key, "fontSize": "\(self.TNFont)", "lineWidth": "\(self.TNWith)", "color": "\(self.TNColor)" , "image": img] as [String : Any]
        self.dismiss(animated: false) {
            self.backBlock?(param)
        }
    }
    
    //MARK: - click event
    
    ///展开工具条
    @objc func expandBtnClick(_ sender: UIButton) {
        self.view.addSubview(self.toolView)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.toolView.frame = CGRect(x: 120, y: 10, width: SCREENW - 240, height: 44)
            self.expandBtn.frame = CGRect(x: -40, y: 10, width: 25, height: 44)
        }) { finished in
            if finished {
                self.expandBtn.removeFromSuperview()
            }
        }
    }
    
    ///收起工具条
    @objc func backBtnClick(_ sender: UIButton) {
        self.view.addSubview(self.expandBtn)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.toolView.frame = CGRect(x: -SCREENW, y: 10, width: SCREENW - 240, height: 44)
            self.expandBtn.frame = CGRect(x: 0, y: 10, width: 25, height: 44)
        }) { finished in
            if finished {
                self.toolView.removeFromSuperview()
            }
        }
    }
    
    ///点击逐条删除
    @objc func delBtnClick(_ sender: UIButton) {
        if self.lines.count > 0 || self.textViewArr.count > 0 {
            sender.isSelected = !sender.isSelected
            self.isDeleting = sender.isSelected
            if tnType == .lineType {
                self.view.insertSubview(drawTextView, belowSubview: drawLineView)
            } else if tnType == .textType {
                self.view.insertSubview(drawLineView, belowSubview: drawTextView)
            }
            
            //刷新画板状态
            updateDrawStatus()
        } else {
            SVProgressHUD.showInfo(withStatus: "暂无需要删除内容")
        }
    }
    
    ///返回听课
    @objc func exitBtnClick(_ sender: UIButton) {
        self.dismiss(animated: false) {
            if self.backBlock != nil {
                self.backBlock([:])
            }
        }
    }
    
    ///退出编辑
    @objc func exitEditBtnClick(_ sender: UIButton) {
        self.dismiss(animated: false) {
            if self.backBlock != nil {
                self.backBlock([:])
            }
        }
    }
    
    ///保存笔记
    @objc func saveBtnClick(_ sender: UIButton) {
        //涂鸦内容渲染到图片
        renderDrawLine()
        //打字内容渲染到图片
        renderDrawText()
        //上传图片、返回上级
        uploadDrawImg(img: getCurrentFrameImage())
    }
    
    //MARK: - lazyload
    
    ///图片
    lazy var baseView: UIImageView = {
        let view = UIImageView(image: self.TNImage)
        view.backgroundColor = .black
        if isIPad {
            view.frame = CGRect(x: 0, y: (self.view.bounds.height - self.view.bounds.width * 9.0 / 16.0)/2, width: self.view.bounds.width, height: self.view.bounds.width * 9.0 / 16.0)
        } else {
            view.frame = CGRect(x: (self.view.bounds.width - self.view.bounds.height * 16.0 / 9.0)/2, y: 0, width: self.view.bounds.height * 16.0 / 9.0, height: self.view.bounds.height)
        }
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    ///涂鸦
    lazy var drawLineView: SF_TNDrawLineView = {
        let view = SF_TNDrawLineView()
        if isIPad {
            view.frame = CGRect(x: 0, y: (self.view.bounds.height - self.view.bounds.width * 9.0 / 16.0)/2, width: self.view.bounds.width, height: self.view.bounds.width * 9.0 / 16.0)
        } else {
            view.frame = CGRect(x: (self.view.bounds.width - self.view.bounds.height * 16.0 / 9.0)/2, y: 0, width: self.view.bounds.height * 16.0 / 9.0, height: self.view.bounds.height)
        }
        return view
    }()
    
    ///打字
    lazy var drawTextView: SF_TNDrawTextView = {
        let view = SF_TNDrawTextView()
        if isIPad {
            view.frame = CGRect(x: 0, y: (self.view.bounds.height - self.view.bounds.width * 9.0 / 16.0)/2, width: self.view.bounds.width, height: self.view.bounds.width * 9.0 / 16.0)
        } else {
            view.frame = CGRect(x: (self.view.bounds.width - self.view.bounds.height * 16.0 / 9.0)/2, y: 0, width: self.view.bounds.height * 16.0 / 9.0, height: self.view.bounds.height)
        }
        return view
    }()
    
    ///展开按钮
    lazy var expandBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 25, height: 44)
        btn.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        btn.setImage(UIImage(named: "做笔记_展开"), for: .normal)
        btn.setImage(UIImage(named: "做笔记_展开"), for: .highlighted)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.withAlphaComponent(0.05).cgColor
        btn.addTarget(self, action: #selector(expandBtnClick(_:)), for: .touchUpInside)
        btn.sf.makeCornerRadius(corners: [.topRight, .bottomRight], radius: 9)
        return btn
    }()
    
    ///工具条
    lazy var toolView: SF_TakeNoteToolView = {
        let view = SF_TakeNoteToolView(frame: CGRect(x: 120, y: -60, width: SCREENW - 240, height: 44))
        view.alpha = 0
        view.btnType = self.isfrom == "1" ? "2" : "0"
        view.backBtn.addTarget(self, action: #selector(backBtnClick(_:)), for: .touchUpInside)
        view.delBtn.addTarget(self, action: #selector(delBtnClick(_:)), for: .touchUpInside)
        view.exitBtn.addTarget(self, action: #selector(exitBtnClick(_:)), for: .touchUpInside)
        view.saveBtn.addTarget(self, action: #selector(saveBtnClick(_:)), for: .touchUpInside)
        view.exitEditBtn.addTarget(self, action: #selector(exitEditBtnClick(_:)), for: .touchUpInside)
        return view
    }()
    
    ///字体弹窗
    lazy var chooseFontView: SF_TNChooseFontView = {
        let view = SF_TNChooseFontView(frame: CGRect(x: 270, y: -100, width: 396, height: 92))
        view.alpha = 0
        return view
    }()

}
