//
//  SF_TakeNoteToolView.swift
//  SparkBase
//
//  Created by sfh on 2023/7/31.
//  Copyright © 2023 Spark. All rights reserved.
//

import UIKit

typealias SF_TakeNoteToolViewBlock = (_ with: CGFloat, _ color: String) -> Void

class SF_TakeNoteToolView: UIView {
    
    var tapFinalBlock: SF_TakeNoteToolViewBlock!
    var tapShowBlock: SF_TakeNoteToolViewBlock!
    var tapHideBlock: SF_TakeNoteToolViewBlock!
    var tapPaintBlock: SF_TakeNoteToolViewBlock!
    var tapFontBlock: SF_TakeNoteToolViewBlock!
    
    var withArr:[CGFloat] = [1, 2, 4, 7]
    var colorArr:[String] = ["#FF3A2F", "#FECC01", "#008AFF", "#32C759", "#000000"]
    
    //0-返回听课 1-保存笔记 2-退出编辑
    var btnType: String = "0" {
        didSet {
            exitBtn.isHidden = btnType != "0"
            saveBtn.isHidden = btnType != "1"
            exitEditBtn.isHidden = btnType != "2"
        }
    }
    
    var finalWith: CGFloat = 1 {
        didSet {
            for i in 0..<withArr.count {
                if Int(self.finalWith) == Int(withArr[i]) {
                    withView.index = i
                }
            }
        }
    }
    
    var finalFont: CGFloat = 16 {
        didSet {
            fontView.fontSize = self.finalFont
        }
    }
    
    var finalColor: String = "#FF3A2F" {
        didSet {
            for i in 0..<colorArr.count {
                if self.finalColor == colorArr[i] {
                    colorView.index = i
                }
            }  
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        loadViews()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadViews() {
        self.addSubview(leftView)
        self.addSubview(midView)
        self.addSubview(rightView)
        
        withView.tapWithBlock = {[weak self] kwith in
            self?.finalWith = kwith
            self?.callBackValues()
        }
        
        colorView.tapColorBlock = {[weak self] kcolor in
            self?.finalColor = kcolor
            self?.callBackValues()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutLeft()
        layoutMiddle()
        layoutRight()
    }
    
    func layoutLeft() {
        leftView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 48, height: 44))
            make.top.left.bottom.equalToSuperview()
        }
        
        backBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 44, height: 44))
            make.top.bottom.equalToSuperview()
            make.centerX.equalTo(leftView.snp.centerX).offset(0)
        }
    }
    
    func layoutMiddle() {
        midView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(backBtn.snp.right).offset(7)
            make.width.equalTo(413)
        }

        paintBtn.snp.makeConstraints { make in
            make.left.equalTo(16.5)
            make.size.equalTo(CGSize(width: 25, height: 25))
            make.centerY.equalTo(midView.snp.centerY).offset(0)
        }
        
        writeBtn.snp.makeConstraints { make in
            make.left.equalTo(paintBtn.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 25, height: 25))
            make.centerY.equalTo(midView.snp.centerY).offset(0)
        }
        
        lineView.snp.makeConstraints { make in
            make.left.equalTo(writeBtn.snp.right).offset(20)
            make.size.equalTo(CGSize(width: 1, height: 22))
            make.centerY.equalTo(midView.snp.centerY).offset(0)
        }
        
        withView.snp.makeConstraints { make in
            make.left.equalTo(lineView.snp.right).offset(0)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(129)
        }
    
        fontView.snp.makeConstraints { make in
            make.left.equalTo(lineView.snp.right).offset(0)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(129)
        }
        
        lineView1.snp.makeConstraints { make in
            make.left.equalTo(lineView.snp.right).offset(129)
            make.size.equalTo(CGSize(width: 1, height: 22))
            make.centerY.equalTo(midView.snp.centerY).offset(0)
        }
        
        colorView.snp.makeConstraints { make in
            make.left.equalTo(lineView1.snp.right).offset(2)
            make.top.bottom.right.equalToSuperview()
        }
        
    }
    
    func layoutRight() {
        rightView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(midView.snp.right).offset(5)
            make.width.equalTo(101)
        }
        
        delBtn.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 50, height: 44))
        }
        
        exitBtn.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 50, height: 44))
        }
        
        saveBtn.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 50, height: 44))
        }
        
        exitEditBtn.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 50, height: 44))
        }
        
        lineView2.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 1, height: 22))
        }
    }
    
    
    ///回调with、color属性
    func callBackValues() {
        if self.tapFinalBlock != nil {
            self.tapFinalBlock(self.finalWith, self.finalColor)
        }
    }
    
    // MARK: - 点击事件
    
    ///点击画笔，选择粗细
    @objc func paintBtnClick(_ sender: UIButton) {
        sender.isSelected = true
        writeBtn.isSelected = false
        
        withView.isHidden = false
        fontView.isHidden = true
        
        self.fontView.fontBtn.isSelected = false
        if self.tapPaintBlock != nil {
            self.tapPaintBlock(0, "#000000")
        }
    }
    
    ///点击打字，选择字号
    @objc func writeBtnClick(_ sender: UIButton) {
        sender.isSelected = true
        paintBtn.isSelected = false
        
        withView.isHidden = true
        fontView.isHidden = false
        
        if self.tapFontBlock != nil {
            self.tapFontBlock(0, "#000000")
        }
    }
    
    ///点击字号，显示选择字号视图
    @objc func fontBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected == true {
            if self.tapShowBlock != nil {
                self.tapShowBlock(0, "#000000")
            }
        } else {
            if self.tapHideBlock != nil {
                self.tapHideBlock(0, "#000000")
            }
        }
    }
    
    
    // MARK: - lazyload
    
    //TODO: left
    lazy var leftView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.05).cgColor
        view.addSubview(backBtn)
        return view
    }()
    
    lazy var backBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "做笔记_收起"), for: .normal)
        btn.setImage(UIImage(named: "做笔记_收起"), for: .highlighted)
        return btn
    }()
    
    //TODO: middle
    
    lazy var midView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.05).cgColor
        view.addSubview(paintBtn)
        view.addSubview(writeBtn)
        view.addSubview(lineView)
        view.addSubview(withView)
        view.addSubview(fontView)
        view.addSubview(lineView1)
        view.addSubview(colorView)
        return view
    }()
    
    lazy var paintBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "做笔记_画笔_未选中"), for: .normal)
        btn.setImage(UIImage(named: "做笔记_画笔_已选中"), for: .selected)
        btn.addTarget(self, action: #selector(paintBtnClick(_:)), for: .touchUpInside)
        btn.isSelected = true
        return btn
    }()
    
    lazy var writeBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "做笔记_打字_未选中"), for: .normal)
        btn.setImage(UIImage(named: "做笔记_打字_已选中"), for: .selected)
        btn.addTarget(self, action: #selector(writeBtnClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        return view
    }()
    
    lazy var withView: SF_TNWithView = {
        let view = SF_TNWithView()
        return view
    }()
    
    lazy var fontView: SF_TNFontView = {
        let view = SF_TNFontView()
        view.isHidden = true
        view.fontBtn.addTarget(self, action: #selector(fontBtnClick(_:)), for: .touchUpInside)
        return view
    }()
    
    lazy var lineView1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        return view
    }()
    
    lazy var colorView: SF_TNColorView = {
        let view = SF_TNColorView()
        return view
    }()
    
    //TODO: right
    
    lazy var rightView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.05).cgColor
        view.addSubview(delBtn)
        view.addSubview(lineView2)
        view.addSubview(exitBtn)
        view.addSubview(saveBtn)
        view.addSubview(exitEditBtn)
        return view
    }()
    
    lazy var delBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "做笔记_逐条删除_未选中"), for: .normal)
        btn.setImage(UIImage(named: "做笔记_逐条删除_已选中"), for: .selected)
        return btn
    }()
    
    lazy var lineView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        return view
    }()
    
    lazy var exitBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "做笔记_返回听课"), for: .normal)
        btn.setImage(UIImage(named: "做笔记_返回听课"), for: .highlighted)
        return btn
    }()

    lazy var saveBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "做笔记_保存笔记"), for: .normal)
        btn.setImage(UIImage(named: "做笔记_保存笔记"), for: .highlighted)
        return btn
    }()
    
    lazy var exitEditBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "看笔记_退出编辑"), for: .normal)
        btn.setImage(UIImage(named: "看笔记_退出编辑"), for: .highlighted)
        return btn
    }()

}
