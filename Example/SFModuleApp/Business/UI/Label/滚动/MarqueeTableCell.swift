//
//  MarqueeTableCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/25.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import MarqueeLabel

class MarqueeTableCell: BaseTableViewCell {

    override func loadViews() {
        self.contentView.addSubview(label)
    }
    
    override func layoutViews() {
        label.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        }
    }
    
    lazy var label: MarqueeLabel = {
        return MarqueeLabel()
    }()

}
