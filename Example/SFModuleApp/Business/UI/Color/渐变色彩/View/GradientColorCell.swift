//
//  GradientColorCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/11/6.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import SFStyleKit

class GradientColorCell: BaseCollectionViewCell {
    
    var defLayout: FlowLayoutType = .single {
        didSet {
            colorLabel.isHidden = defLayout == .twice
        }
    }
    
    private var startColor: UIColor = .white
    private var endColor: UIColor = .white
    
    override func loadData(_ model: BaseModel, indexPath: IndexPath) {
        if let m = model as? GradientColorModel {
            nameLabel.text = m.name
            colorLabel.text = "\(m.start) -> \(m.end)"
            startColor = UIColor.sf.hexColor(hex: m.start)
            endColor = UIColor.sf.hexColor(hex: m.end)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.colorView.sf.makeGradient([startColor.cgColor, endColor.cgColor], locations: [0, 1], startPoint: CGPoint(x: 0, y: 1), endPoint: CGPoint(x: 1, y: 0))
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
            make.bottom.equalTo(-25)
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
        view.sf.backgroundColor(.white).makeRadius(10)
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
