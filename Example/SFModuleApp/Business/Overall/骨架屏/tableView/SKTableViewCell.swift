//
//  SKTableViewCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class SKTableViewCell: BaseTableViewCell {

    override func loadViews() {
        self.contentView.addSubview(iconView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(lineView)
        
        isSkeletonable = true
        iconView.isSkeletonable = true
        nameLabel.isSkeletonable = true
        lineView.isSkeletonable = true
    }
    
    override func layoutViews() {
        iconView.snp.makeConstraints { make in
            make.left.top.equalTo(15)
            make.bottom.equalTo(-15)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.right.equalTo(-15)
            make.top.equalTo(15)
            make.bottom.equalTo(-15)
        }
        
        lineView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(0)
            make.height.equalTo(1)
        }
    }
    
    lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.image = UIImage(named: "DanielWu.jpg")
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(text: "4月22日至23日，习近平总书记在重庆市考察调研，了解当地加快建设西部陆海新通道、实施城市更新和保障改善民生、提高城市治理现代化水平等情况。", textColor: .systemRed, font: UIFont.systemFont(ofSize: 14), aligment: .center, lines: 0)
        return label
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemTeal
        return view
    }()

}
