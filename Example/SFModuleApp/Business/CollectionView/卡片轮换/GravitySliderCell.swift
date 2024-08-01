//
//  GravitySliderCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/21.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class GravitySliderCell: BaseCollectionViewCell {
    
    override func loadViews() {
        self.backgroundColor = .clear
        self.contentView.layer.cornerRadius = 21
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(label)
    }
    
    override func layoutViews() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    lazy var label: UILabel = {
        let view = UILabel(bgColor: .clear, textColor: .white, font: UIFont.systemFont(ofSize: 60), aligment: .center)
        return view
    }()
}
