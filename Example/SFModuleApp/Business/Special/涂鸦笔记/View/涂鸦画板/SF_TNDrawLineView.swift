//
//  SF_TNDrawLineView.swift
//  SparkBase
//
//  Created by sfh on 2023/8/4.
//  Copyright © 2023 Spark. All rights reserved.
//

import UIKit

typealias SF_TNDrawLineViewBlock = (_ list: [Any]) -> Void

class SF_TNDrawLineView: UIView {
    
    var callBackBlock: SF_TNDrawLineViewBlock!
    
    var TNWith: CGFloat = 4
    var TNColor: UIColor = UIColor.sf.hexColor(hex: "#008AFF")
    
    var tempArr: [UIView] = [] //保存承载画线且带删除的临时view
    var lines: [Any] = [] //保存所有的画线
    var path: UIBezierPath = UIBezierPath()
    var slayer: CAShapeLayer = CAShapeLayer()
    
    //是否点击了逐条删除
    var isDeleting: Bool = false {
        didSet {
            if isDeleting {
                addAllItemView()
            } else {
                DelAllItemView()
            }
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
        DelAllItemView()
        tempArr.removeAll()
        lines.removeAll()
    }
    
    ///添加涂鸦删除层
    func addAllItemView() {
        self.tempArr = []
        let klines:[Any] = self.lines
        for i in 0..<klines.count {
            if let klayer = klines[i] as? CAShapeLayer {
                let vX: CGFloat = (klayer.path?.boundingBox.minX)! - TNWith
                let vY: CGFloat = (klayer.path?.boundingBox.minY)! - TNWith - 12
                let vW: CGFloat = (klayer.path?.boundingBox.width)! + 2*TNWith + 12
                let vH: CGFloat = (klayer.path?.boundingBox.height)! + 2*TNWith + 12
                let view = SF_TNLayerItemView(frame: CGRect(x: vX, y: vY, width: vW, height: vH))
                self.addSubview(view)
                self.tempArr.append(view)
                view.delBlock = {[weak self] in
                    self?.delItemView(index: i)
                }
            }
        }
    }
    
    ///删除所有的涂鸦删除层
    func DelAllItemView() {
        for i in 0..<self.tempArr.count {
            if let view = self.tempArr[i] as? SF_TNLayerItemView {
                view.removeFromSuperview()
            }
        }
        
        self.tempArr.removeAll()
    }
    
    ///删除某个涂鸦
    func delItemView(index: Int) {
        if let layer = self.lines[index] as? CAShapeLayer {
            self.lines.remove(at: index)
            layer.removeFromSuperlayer()
            DelAllItemView()
            addAllItemView()
        }
//
//        if let view = self.tempArr[index] as? SF_TNLayerItemView {
//            self.tempArr.remove(at: index)
//            view.removeFromSuperview()
//        }
        
        
        if self.callBackBlock != nil {
            self.callBackBlock(self.lines)
        }
    }
    
    //MARK: - 手势
    
    ///手势开始
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.isDeleting == true { return }
        let touch = (touches as NSSet).anyObject() as AnyObject
        var point = touch.location(in: self)
        point = self.layer.convert(point, from: self.layer)
        if self.layer.contains(point) {
            if event?.allTouches?.count == 1 {
                let path = UIBezierPath()
                path.lineWidth = self.TNWith
                path.lineCapStyle = CGLineCap.round
                path.lineJoinStyle = CGLineJoin.round
                path.move(to: point)
                self.path = path
                
                let slayer = CAShapeLayer()
                slayer.path = path.cgPath
                slayer.backgroundColor = UIColor.clear.cgColor
                slayer.fillColor = UIColor.clear.cgColor
                slayer.lineCap = CAShapeLayerLineCap.round
                slayer.lineJoin = CAShapeLayerLineJoin.round
                slayer.strokeColor = self.TNColor.cgColor
                slayer.lineWidth = path.lineWidth
                self.layer.addSublayer(slayer)
                self.slayer = slayer
                self.lines.append(slayer)
            }
        }
    }
    
    ///手势移动
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.isDeleting == true { return }
        let touch = (touches as NSSet).anyObject() as AnyObject
        var point = touch.location(in: self)
        point = self.layer.convert(point, from: self.layer)
        if self.layer.contains(point) {
            if event?.allTouches?.count ?? 0 > 1 {
                self.superview?.touchesMoved(touches, with: event)
            } else if event?.allTouches?.count == 1 {
                self.path.addLine(to: point)
                self.slayer.path = self.path.cgPath
            }
        }
    }
    
    ///手势结束
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.isDeleting == true { return }
        let touch = (touches as NSSet).anyObject() as AnyObject
        var point = touch.location(in: self)
        point = self.layer.convert(point, from: self.layer)
        if self.layer.contains(point) {
            if event?.allTouches?.count ?? 0 > 1 {
                self.superview?.touchesMoved(touches, with: event)
            }
        }
        
        //筛掉面积太小的涂鸦
        var passArr:[Any] = []
        var lessArr:[Any] = []
        for i in 0..<lines.count {
            if let klayer = lines[i] as? CAShapeLayer {
                let vW: CGFloat = (klayer.path?.boundingBox.width)!
                let vH: CGFloat = (klayer.path?.boundingBox.height)!
                if vW >= 5 || vH >= 5 {
                    passArr.append(klayer)
                } else {
                    lessArr.append(klayer)
                }
            }
        }
        
        self.lines = passArr
        for j in 0..<lessArr.count {
            if let player = lessArr[j] as? CAShapeLayer {
                player.removeFromSuperlayer()
            }
        }
        
        //回调
        if self.callBackBlock != nil {
            self.callBackBlock(self.lines)
        }
    }

}
