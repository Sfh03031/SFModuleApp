//
//  SKCollectionViewCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/25.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class SKCollectionViewCell: BaseCollectionViewCell {
    
    override func loadViews() {
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(infoLabel)
        
        isSkeletonable = true
//        self.contentView.isSkeletonable = true
        infoLabel.isSkeletonable = true
    }
    
    override func layoutViews() {
        infoLabel.snp.makeConstraints { make in
            make.center.equalTo(self.contentView.snp.center)
        }
    }
    
    
    lazy var infoLabel: UILabel = {
        let label = UILabel(bgColor: .clear, textColor: .label, font: UIFont.systemFont(ofSize: 13, weight: .regular), aligment: .center)
        return label
    }()
}
