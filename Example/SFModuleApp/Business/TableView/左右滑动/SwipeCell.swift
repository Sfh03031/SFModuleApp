//
//  SwipeCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/22.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeCell: SwipeTableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        loadViews()
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadViews() {
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(subLabel)
    }
    
    func layoutViews() {
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(5)
            make.right.equalTo(-20)
            make.height.equalTo(30)
        }
        
        subLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.right.equalTo(-20)
            make.bottom.equalTo(-5)
        }
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    lazy var subLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

}
