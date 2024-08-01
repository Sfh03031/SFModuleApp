//
//  BaseCollectionViewCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/16.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

open class BaseCollectionViewCell: UICollectionViewCell {
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if #available(iOS 14.0, *) {
            self.contentView.isHidden = self.contentView.isHidden
        }
        loadViews()
        layoutViews()
    }
    
    open func loadViews() {}
    open func layoutViews() {}
    open func loadData(_ model: BaseModel, indexPath: IndexPath) {}
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        loadViews()
        layoutViews()
    }
    
    open override func updateConstraints() {
        layoutViews()
        super.updateConstraints()
    }
}
