//
//  DeltaMainCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import UIFontComplete

class DeltaMainCell: BaseCollectionViewCell {
    
    override func loadViews() {
        self.addSubview(nameLabel)
    }
    
    override func layoutViews() {
        nameLabel.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    func loadData(_ model: BaseModel, type: FlowLayoutType) {
        if let m = model as? DeltaMainModel {
            if type == .triserial {
                nameLabel.text = m.type
            } else {
                nameLabel.text = "\(m.name) \(m.type)"
            }
        }
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(bgColor: .white, textColor: .random, font: UIFont.init(font: .georgiaItalic, size: 16.0)!, aligment: .center)
        label.layer.cornerRadius = 15.0
        label.layer.masksToBounds = true
        return label
    }()
}
