//
//  SF_TNWithView.swift
//  SparkBase
//
//  Created by sfh on 2023/7/31.
//  Copyright © 2023 Spark. All rights reserved.
//

import UIKit

typealias SF_TNWithViewBlock = (_ with: CGFloat) -> Void

class SF_TNWithView: UIScrollView {
    
    var tapWithBlock: SF_TNWithViewBlock!
    
    var normalArr:[String] = [
        "做笔记_画笔粗细_1_未选中",
        "做笔记_画笔粗细_2_未选中",
        "做笔记_画笔粗细_3_未选中",
        "做笔记_画笔粗细_4_未选中"
    ]
    var selectedArr:[String] = [
        "做笔记_画笔粗细_1_已选中",
        "做笔记_画笔粗细_2_已选中",
        "做笔记_画笔粗细_3_已选中",
        "做笔记_画笔粗细_4_已选中"
    ]
    var withArr:[CGFloat] = [1, 2, 4, 7]
    var btnArr:[UIButton] = []
    
    var index: Int = 0 {
        didSet {
            for i in 0..<btnArr.count {
                let btn:UIButton = btnArr[i]
                if index == i {
                    btn.isSelected = true
                } else {
                    btn.isSelected = false
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
        
        for i in 0..<normalArr.count {
            let normalStr = normalArr[i]
            let selectedStr = selectedArr[i]
            let btn = UIButton(type: .custom)
            btn.setImage(UIImage(named: normalStr), for: .normal)
            btn.setImage(UIImage(named: selectedStr), for: .selected)
            btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
            self.addSubview(btn)
            btnArr.append(btn)
            btn.isSelected = index == i
            btn.snp.makeConstraints { make in
                if i == 0 {
                    make.left.equalTo(6)
                } else {
                    make.left.equalTo(btnArr[i-1].snp.right).offset(10)
                }
                make.size.equalTo(CGSize(width: 20, height: 20))
                make.centerY.equalTo(self.snp.centerY)
            }
        }
    }
    
    @objc func btnClick(_ sender: UIButton) {
        sender.isSelected = true
        for i in 0..<btnArr.count {
            let btn:UIButton = btnArr[i]
            if btn != sender {
                btn.isSelected = false
            } else {
                index = i
            }
        }
        
        if self.tapWithBlock != nil {
            self.tapWithBlock(withArr[index])
        }
    }

}
