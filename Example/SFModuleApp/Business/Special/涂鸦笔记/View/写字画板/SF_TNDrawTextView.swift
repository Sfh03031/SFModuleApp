//
//  SF_TNDrawTextView.swift
//  SparkBase
//
//  Created by sfh on 2023/8/4.
//  Copyright © 2023 Spark. All rights reserved.
//

import UIKit

typealias SF_TNDrawTextViewBlock = (_ list: [UIView]) -> Void

class SF_TNDrawTextView: UIView {
    
    var callBackBlock: SF_TNDrawTextViewBlock!
    
    var TNFont: CGFloat = 16
    var TNColor: UIColor = UIColor.sf.hexColor(hex: "#008AFF")
    var textViewArr: [UIView] = [] //保存写字且带删除的临时view
    
    //是否弹出键盘
    var isKeyboardShow: Bool = false {
        didSet {
            if isKeyboardShow == false {
                checkTextItemView()
            }
        }
    }
    
    //是否点击了逐条删除
    var isDeleting: Bool = false {
        didSet {
            refreshTextItem(isShow: isDeleting)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///清空
    func clearAll() {
        for i in 0..<self.textViewArr.count {
            if let temp = self.textViewArr[i] as? SF_TNTextItemView {
                temp.removeFromSuperview()
            }
        }
        
        textViewArr.removeAll()
    }
    
    ///刷新打字view的状态
    func refreshTextItem(isShow: Bool) {
        for i in 0..<self.textViewArr.count {
            if let temp = self.textViewArr[i] as? SF_TNTextItemView {
                if let subLayers = temp.textView.layer.sublayers {
                    let removeLayers = subLayers.filter {
                        $0.isKind(of: CAShapeLayer.classForCoder())
                    }
                    removeLayers.forEach {item in
                        item.removeFromSuperlayer()
                    }
                }
                temp.isShowDel = isShow
                if isShow == false {
                    temp.textView.sf.makeCustomizeBorder(color: .black, rectSide: .all, isDash: true)
                }
                temp.delBlock = {[weak self] in
                    self?.delItemView(index: i)
                }
            }
        }
    }
    
    //删除某个打字item
    func delItemView(index: Int) {
        if let temp = self.textViewArr[index] as? SF_TNTextItemView {
            self.textViewArr.remove(at: index)
            temp.removeFromSuperview()
            
            refreshTextItem(isShow: self.isDeleting)
        }
        
        if self.callBackBlock != nil {
            self.callBackBlock(self.textViewArr)
        }
    }
    
    ///检查并删除没有内容的textItemView
    func checkTextItemView() {
        var list:[UIView] = []
        var relist: [UIView] = []
        for i in 0..<self.textViewArr.count {
            if let temp = self.textViewArr[i] as? SF_TNTextItemView {
                if temp.textView.text == "" {
                    relist.append(temp)
                } else {
                    list.append(temp)
                }
            }
        }
        
        relist.forEach { item in
            item.removeFromSuperview()
        }
        
        self.textViewArr = list
        if self.callBackBlock != nil {
            self.callBackBlock(self.textViewArr)
        }
    }
    
    //MARK: - 手势
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.isDeleting == true { return }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.isDeleting == true { return }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.isDeleting == true { return }
        
        if self.isKeyboardShow == true {
            if let temp = self.textViewArr.last as? SF_TNTextItemView {
                if temp.textView.text == "" {
                    temp.resignFirstResponder()
                    temp.removeFromSuperview()
                    self.textViewArr.removeLast()
                }
            }
        } else {
            let touch = (touches as NSSet).anyObject() as AnyObject
            let point = touch.location(in: self)
            let view = SF_TNTextItemView(frame: CGRect(x: point.x - 12, y: point.y - 12, width: 40 + 12, height: 30 + 12))
            view.textView.font = UIFont.systemFont(ofSize: self.TNFont, weight: .regular)
            view.textView.textColor = TNColor
            view.textView.tintColor = TNColor
            view.isShowDel = false
            view.textView.sf.makeCustomizeBorder(color: .black, rectSide: .all, isDash: true)
            self.addSubview(view)
            self.textViewArr.append(view)
            view.textView.becomeFirstResponder()
            view.textView.addTextDidChangeHandler { kview in
                //清除虚线边框
                if let subLayers = view.textView.layer.sublayers {
                    let removeLayers = subLayers.filter {
                        $0.isKind(of: CAShapeLayer.classForCoder())
                    }
                    removeLayers.forEach {item in
                        item.removeFromSuperlayer()
                    }
                }
                //重新计算输入区域尺寸
                let size = textSizeWH(text: (kview?.text)!, font: UIFont.systemFont(ofSize: self.TNFont, weight: .regular), maxSize: CGSize(width: self.bounds.width - point.x, height: CGFLOAT_MAX), lineSpace: 0)
                view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: size.width + 12 + 20, height: size.height + 12 + 10)
                view.textView.frame = CGRect(x: 0, y: 12, width: size.width + 20, height: size.height + 10)
                //重新添加虚线边框
                view.textView.sf.makeCustomizeBorder(color: .black, rectSide: .all, isDash: true)
            }
        }
        
        if self.callBackBlock != nil {
            self.callBackBlock(self.textViewArr)
        }
    }
}
