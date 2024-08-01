//
//  ChineseColorCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/18.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class ChineseColorCell: BaseCollectionViewCell {
    
    var startColor: UIColor = .white
    var endColor: UIColor = .white
    
    override func loadViews() {
        self.contentView.addSubview(backView)
        backView.addSubview(colorView)
        backView.addSubview(nameLabel)
        backView.addSubview(colorLabel)
        colorView.addSubview(yearLabel)
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
        
        yearLabel.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.colorView.sf.makeGradient([startColor.cgColor, endColor.cgColor], locations: [0, 1], startPoint: CGPoint(x: 0, y: 1), endPoint: CGPoint(x: 1, y: 0))
    }
    
    override func loadData(_ model: BaseModel, indexPath: IndexPath) {
        if let m = model as? ChineseColorModel {
            nameLabel.text = m.name
            if m.start != nil && m.end != nil {
                colorLabel.text = m.start! + " -> " + m.end!
                yearLabel.text = m.year
                startColor = UIColor.sf.hexColor(hex: m.start!)
                endColor = UIColor.sf.hexColor(hex: m.end!)
            } else {
                colorLabel.text = m.hex
                yearLabel.text = m.year
                colorView.backgroundColor = UIColor.sf.hexColor(hex: m.hex ?? "#000000")
                backView.backgroundColor = m.name == "精白" ? UIColor.sf.hexColor(hex: "#f0fcff") : .white
            }
            
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
    
    lazy var yearLabel: UILabel = {
        let label = UILabel(bgColor: .clear, textColor: .white, font: UIFont.systemFont(ofSize: 18, weight: .bold), aligment: .right)
        return label
    }()
}
