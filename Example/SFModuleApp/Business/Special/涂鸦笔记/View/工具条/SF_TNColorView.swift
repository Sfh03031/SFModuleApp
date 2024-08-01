//
//  SF_TNColorView.swift
//  SparkBase
//
//  Created by sfh on 2023/7/31.
//  Copyright © 2023 Spark. All rights reserved.
//

import UIKit

typealias SF_TNColorViewBlock = (_ color: String)->Void

class SF_TNColorView: UIScrollView {
    
    var tapColorBlock: SF_TNColorViewBlock!
    
    var colorArr:[String] = ["#FF3A2F", "#FECC01", "#008AFF", "#32C759", "#000000"]
    var btnArr:[UIButton] = []
    
    var index: Int = 0 {
        didSet {
            for i in 0..<btnArr.count {
                let btn:UIButton = btnArr[i]
                if index == i {
                    btn.setImage(UIImage(named: "做笔记_选中颜色"), for: .normal)
                } else {
                    btn.setImage(nil, for: .normal)
                }
            }
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.isScrollEnabled = true
        self.bounces = true
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        loadViews()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadViews() {
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        btnArr = []
        
        for i in 0..<colorArr.count {
            let color = colorArr[i]
            let btn = UIButton(type: .custom)
            btn.backgroundColor = UIColor.sf.hexColor(hex: color)
            btn.layer.cornerRadius = 3
            btn.layer.masksToBounds = true
            btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
            self.addSubview(btn)
            btnArr.append(btn)
            if index == i {
                btn.setImage(UIImage(named: "做笔记_选中颜色"), for: .normal)
            }
            btn.snp.makeConstraints { make in
                if i == 0 {
                    make.left.equalTo(20)
                } else {
                    make.left.equalTo(btnArr[i-1].snp.right).offset(18)
                }
                make.size.equalTo(CGSize(width: 15, height: 15))
                make.centerY.equalTo(self.snp.centerY)
            }
        }
    }
    
    @objc func btnClick(_ sender: UIButton) {
        for i in 0..<btnArr.count {
            let btn:UIButton = btnArr[i]
            if btn != sender {
                btn.setImage(nil, for: .normal)
            } else {
                btn.setImage(UIImage(named: "做笔记_选中颜色"), for: .normal)
                index = i
            }
        }
        
        if self.tapColorBlock != nil {
            self.tapColorBlock(colorArr[index])
        }
    }

}
