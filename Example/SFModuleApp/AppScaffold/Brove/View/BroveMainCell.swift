//
//  BroveMainCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import UIFontComplete

class BroveMainCell: BaseCollectionViewCell {
    var nameStr: String = "" {
        didSet {
            nameLabel.text = nameStr
        }
    }
    
    override func loadViews() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
        
        self.addSubview(nameLabel)
    }
    
    override func layoutViews() {
        nameLabel.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    fileprivate lazy var nameLabel: UILabel = {
        let label = UILabel(bgColor: .white, textColor: .random, font: UIFont(font: .georgiaItalic, size: 16.0)!, aligment: .center)
        return label
    }()
}
