//
//  BaseTableViewCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/16.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

open class BaseTableViewCell: UITableViewCell {
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
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

    open override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
