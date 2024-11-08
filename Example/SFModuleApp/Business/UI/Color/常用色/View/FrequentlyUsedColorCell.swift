//
//  FrequentlyUsedColorCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/11/6.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import SFStyleKit

class FrequentlyUsedColorCell: BaseCollectionViewCell {
    
    override func loadData(_ model: BaseModel, indexPath: IndexPath) {
        if let m = model as? FrequentlyUsedColorModel {
            nameLabel.text = m.name
            colorLabel.text = m.hex
            colorView.backgroundColor = UIColor.sf.hexColor(hex: m.hex)
            backView.backgroundColor = m.name == "精白" ? UIColor.sf.hexColor(hex: "#f0fcff") : .white
        }
    }
    
    override func loadViews() {
        self.addSubview(backView)
        backView.addSubview(colorView)
        backView.addSubview(nameLabel)
        backView.addSubview(colorLabel)
    }
    
    override func layoutViews() {
        
        backView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        colorView.snp.makeConstraints { make in
            make.left.top.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(-30)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(colorView)
            make.top.equalTo(colorView.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        colorLabel.snp.makeConstraints { make in
            make.right.equalTo(colorView)
            make.top.equalTo(colorView.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
    lazy var backView: UIView = {
        let view = UIView()
        view.sf.backgroundColor(.white).makeRadius(15)
        return view
    }()
    
    lazy var colorView: UIView = {
        let view = UIView()
        view.sf.makeRadius(10)
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(bgColor: .clear, textColor: .label, font: UIFont.systemFont(ofSize: 12, weight: .regular), aligment: .left)
        return label
    }()
    
    lazy var colorLabel: UILabel = {
        let label = UILabel(bgColor: .clear, textColor: .label, font: UIFont.systemFont(ofSize: 12, weight: .regular), aligment: .right)
        return label
    }()
}
