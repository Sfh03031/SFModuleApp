//
//  BadgeCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/22.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import TDBadgedCell

class BadgeCell: TDBadgedCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
