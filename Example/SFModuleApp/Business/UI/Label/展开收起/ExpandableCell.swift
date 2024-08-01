//
//  ExpandableCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/6.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class ExpandableCell: BaseTableViewCell {

    override func loadViews() {
        contentView.addSubview(expandLabel)
    }
    
    override func layoutViews() {
        expandLabel.snp.makeConstraints { make in
            make.left.top.equalTo(10)
            make.right.bottom.equalTo(-10)
        }
    }
    
    lazy var expandLabel: ExpandableLabel = {
        let label = ExpandableLabel()
        label.text = nil
        label.textColor = UIColor.sf.random
        label.collapsed = true
        label.customTextAlignment = .left
        label.ellipsis = NSAttributedString(string: "...")
        label.collapsedAttributedLink = NSAttributedString(string: "展开")
        label.expandedAttributedLink = NSAttributedString(string: "收起")
        // 必须设置，否则代理不走
        label.isUserInteractionEnabled = true
        return label
    }()

}
