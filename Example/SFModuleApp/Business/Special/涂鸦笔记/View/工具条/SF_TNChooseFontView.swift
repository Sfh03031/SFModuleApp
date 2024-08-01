//
//  SF_TNChooseFontView.swift
//  SparkBase
//
//  Created by sfh on 2023/7/31.
//  Copyright © 2023 Spark. All rights reserved.
//

import UIKit

typealias SF_TNChooseFontViewBlock = (_ font: CGFloat) -> Void

class SF_TNChooseFontView: UIView {
    
    var chooseFontBlock: SF_TNChooseFontViewBlock!
    
    var fontArr: [CGFloat] = [16, 20, 24, 30, 36, 48, 56]
    var index: Int = 0
    var labelArr: [UILabel] = []
    var pointArr: [UIView] = []
    
    var fontSize: CGFloat = 16 {
        didSet {
            for i in 0..<fontArr.count {
                if fontSize == fontArr[i] {
                    index = i
                }
            }
            
            for i in 0..<labelArr.count {
                let label:UILabel = labelArr[i]
                if index == i {
                    label.textColor = UIColor.sf.hexColor(hex: "#008AFF")
                } else {
                    label.textColor = UIColor.sf.hexColor(hex: "#222222")
                }
            }
            
            for j in 0..<pointArr.count {
                let point:UIView = pointArr[j]
                if index == j {
                    point.backgroundColor = UIColor.sf.hexColor(hex: "#008AFF")
                } else {
                    point.backgroundColor = UIColor.sf.hexColor(hex: "#CFD2D9")
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.05).cgColor
        
        loadViews()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadViews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.equalTo(15)
            make.height.width.equalTo(nameLabel)
        }
        
        labelArr = []
        pointArr = []
        
        for i in 0..<fontArr.count {
            let label = UILabel(text: "\(Int(fontArr[i]))", textColor: UIColor.sf.hexColor(hex: "#222222"), font: UIFont.systemFont(ofSize: fontArr[i], weight: .regular), aligment: .center)
            label.backgroundColor = .clear
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTap(_:))))
            self.addSubview(label)
            labelArr.append(label)
            label.snp.makeConstraints { make in
                if i == 0 {
                    make.left.equalTo(15)
                } else {
                    make.left.equalTo(labelArr[i-1].snp.right).offset(15)
                }
                make.bottom.equalTo(-20)
                make.width.height.equalTo(label)
            }
            label.layoutIfNeeded()
            
            let point = UIView()
            point.backgroundColor = UIColor.sf.hexColor(hex: "#CFD2D9")
            point.isOpaque = false
            point.layer.cornerRadius = 3
            point.layer.masksToBounds = true
            self.addSubview(point)
            pointArr.append(point)
            point.snp.makeConstraints { make in
                make.size.equalTo(CGSize(width: 6, height: 6))
                make.centerX.equalTo(label.snp.centerX)
                make.bottom.equalTo(-12)
            }
            point.layoutIfNeeded()
            
            if index == i {
                label.textColor = UIColor.sf.hexColor(hex: "#008AFF")
                point.backgroundColor = UIColor.sf.hexColor(hex: "#008AFF")
            } else {
                label.textColor = UIColor.sf.hexColor(hex: "#222222")
                point.backgroundColor = UIColor.sf.hexColor(hex: "#CFD2D9")
            }
        }
        
        if let first = pointArr.first, let last = pointArr.last {
            let lineView = UIView()
            lineView.backgroundColor = UIColor.black.withAlphaComponent(0.08)
            self.addSubview(lineView)
            lineView.snp.makeConstraints { make in
                make.left.equalTo(first.snp.right).offset(0)
                make.right.equalTo(last.snp.left).offset(0)
                make.height.equalTo(0.5)
                make.centerY.equalTo(first.snp.centerY).offset(0)
            }
        }
         
    }
    
    @objc func labelTap(_ sender: UITapGestureRecognizer) {
        for i in 0..<labelArr.count {
            let label:UILabel = labelArr[i]
            if label != sender.view {
                label.textColor = UIColor.sf.hexColor(hex: "#222222")
            } else {
                label.textColor = UIColor.sf.hexColor(hex: "#008AFF")
                index = i
            }
        }
        
        for j in 0..<pointArr.count {
            let point:UIView = pointArr[j]
            if index == j {
                point.backgroundColor = UIColor.sf.hexColor(hex: "#008AFF")
            } else {
                point.backgroundColor = UIColor.sf.hexColor(hex: "#CFD2D9")
            }
        }
        
        if self.chooseFontBlock != nil {
            self.chooseFontBlock(fontArr[index])
        }
    }
    
    // MARK: - lazyload
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(text: "点击数字即切换为该字号", textColor: .black.withAlphaComponent(0.2), font: UIFont.systemFont(ofSize: 12, weight: .regular), aligment: .left)
        label.backgroundColor = .clear
        return label
    }()

}
