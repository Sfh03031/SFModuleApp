//
//  FontCollectionViewCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/21.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import UIFontComplete

class FontCollectionViewCell: BaseCollectionViewCell {
    
    var font:UIFontComplete.Font = .alNile {
        didSet {
            nameLabel.font = UIFont.init(font: font, size: 14.0)
            nameLabel.text = font.rawValue
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
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(bgColor: .white, textColor: .random, font: UIFont.init(font: .georgiaItalic, size: 14)!, aligment: .center, lines: 0)
        return label
    }()
}
