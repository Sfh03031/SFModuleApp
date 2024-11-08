//
//  ServiceSettingCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SFStyleKit
import UIFontComplete

class ServiceSettingCell: BaseCollectionViewCell {
    
    var chooseTapBlock:(()->())?
    var delTapBlock:(()->())?
    
    public func loadCell(model: ServiceSettingModel, isChoosed: Bool = false) {
        nameLabel.text = model.name
        nameLabel.textColor = isChoosed ? .hex_008AFF : .hex_7c4b00
        
        addressLabel.text = model.address
        addressLabel.textColor = isChoosed ? .hex_008AFF : .hex_7c4b00
        
        if model.address == HOST_URL_DEV || model.address == HOST_URL_TEST || model.address == HOST_URL_RELEASE || model.address == HOST_URL_DEV1 || model.address == HOST_URL_DEV2 || isChoosed {
            delLabel.isHidden = true
        } else {
            delLabel.isHidden = false
        }
    }
    
    override func loadViews() {
        contentView.addSubview(backView)
        backView.addSubview(nameLabel)
        backView.addSubview(addressLabel)
        backView.addSubview(delLabel)
        
        isSkeletonable = true
        backView.isSkeletonable = true
        nameLabel.isSkeletonable = true
        addressLabel.isSkeletonable = true
        delLabel.isSkeletonable = true
    }
    
    override func layoutViews() {
        backView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(0)
        }
        
        delLabel.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 20))
        }
    }
    
    //MARK: - lazyload
    
    fileprivate lazy var backView: UIView = {
        let view = UIView()
        view.sf.backgroundColor(.white).makeRadius(10.0).addTapAction { view in
            self.chooseTapBlock?()
        }
        return view
    }()
    
    fileprivate lazy var nameLabel: UILabel = {
        let label = UILabel(bgColor: .clear, textColor: .label, font: UIFont.systemFont(ofSize: 17, weight: .medium), aligment: .center)
        return label
    }()
    
    fileprivate lazy var addressLabel: UILabel = {
        let label = UILabel(bgColor: .clear, textColor: .label, font: UIFont(font: .georgiaItalic, size: 14.0)!, aligment: .center)
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate lazy var delLabel: UILabel = {
        let label = UILabel(bgColor: .systemPink, text: "删除", textColor: .white, font: UIFont(font: .georgia, size: 12.0)!, aligment: .center, radius: 10.0)
        label.sf.addTapAction { view in
            self.delTapBlock?()
        }
        return label
    }()
}
