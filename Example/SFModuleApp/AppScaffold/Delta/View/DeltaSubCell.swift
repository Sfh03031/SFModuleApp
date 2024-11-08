//
//  DeltaSubCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/25.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SFStyleKit
import SFServiceKit

class DeltaSubCell: BaseCollectionViewCell {
    
    override func loadViews() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = true
        
        self.addSubview(iconImgView)
        self.addSubview(nameLabel)
        self.addSubview(nextImgView)
    }
    
    override func layoutViews() {
        iconImgView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.size.equalTo(CGSize(width: 20, height: 40))
            make.centerY.equalTo(self.snp.centerY)
        }
        
        nextImgView.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.size.equalTo(CGSize(width: 20, height: 40))
            make.centerY.equalTo(self.snp.centerY)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImgView.snp.right).offset(10)
            make.right.equalTo(nextImgView.snp.left).offset(-10)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
    override func loadData(_ model: BaseModel, indexPath: IndexPath) {
        if let m = model as? DeltaMainModel {
            nameLabel.text = m.name
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.sf.makeGradient([UIColor.sf.hexColor(hex: "#FCA5F1").cgColor, UIColor.sf.hexColor(hex: "#B5FFFF").cgColor], locations: [0, 1], startPoint: CGPoint(x: 0, y: 1), endPoint: CGPoint(x: 1, y: 0))
    }
    
    // MARK: lazyload
    
    lazy var iconImgView: UIImageView = {
        let img = SFSymbolManager.shared.symbol(systemName: "laurel.leading", withConfiguration: nil, withTintColor: .hex_00e079)
        
        let view = UIImageView()
        view.image = img!
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(bgColor: .clear, textColor: .hex_21a675, font: UIFont.systemFont(ofSize: 16.0, weight: .medium), aligment: .center)
        return label
    }()
    
    lazy var nextImgView: UIImageView = {
        let img = SFSymbolManager.shared.symbol(systemName: "laurel.trailing", withConfiguration: nil, withTintColor: .hex_00e079)
        
        let view = UIImageView()
        view.image = img!
        return view
    }()
    
}
