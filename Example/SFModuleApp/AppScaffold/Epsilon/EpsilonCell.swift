//
//  EpsilonCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/15.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class EpsilonCell: BaseTableViewCell {

    override func loadViews() {
        self.contentView.addSubview(imgView1)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(lineView)
        
        isSkeletonable = true
        imgView1.isSkeletonable = true
        nameLabel.isSkeletonable = true
        imgView.isSkeletonable = true
        lineView.isSkeletonable = true
    }
    
    override func layoutViews() {
        
        imgView1.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.width.height.equalTo(22)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalTo(50)
            make.bottom.equalTo(-20)
            make.right.equalTo(-50)
        }
        
        imgView.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.width.height.equalTo(22)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        lineView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    override func loadData(_ model: BaseModel, indexPath: IndexPath) {
        if let model = model as? EpsilonModel {
            nameLabel.text = model.name
        }
    }
    
    //MARK: - lazyload
    
    fileprivate lazy var imgView1: UIImageView = {
        let view = UIImageView()
        view.image = SFSymbol.symbol(name: "wand.and.rays", pointSize: 22, tintColor: .random)
        return view
    }()
    
    fileprivate lazy var nameLabel: UILabel = {
        let label = UILabel(bgColor: .clear, textColor: .random, font: UIFont.systemFont(ofSize: 16, weight: .regular), aligment: .left, lines: 0)
        return label
    }()
    
    fileprivate lazy var imgView: UIImageView = {
        let view = UIImageView()
        view.image = SFSymbol.symbol(name: "lines.measurement.horizontal", pointSize: 22, tintColor: .random)
        return view
    }()
    
    fileprivate lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .opaqueSeparator
        return view
    }()

}
