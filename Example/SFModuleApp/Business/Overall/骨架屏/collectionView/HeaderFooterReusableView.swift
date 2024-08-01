//
//  HeaderFooterReusableView.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/6/17.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class HeaderFooterReusableView: UICollectionReusableView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isSkeletonable = true
        
        loadViews()
    }
    
    func loadViews() {
        infoLabel.isSkeletonable = true
        self.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
        }
    }
    
    lazy var infoLabel: UILabel = {
        let label = UILabel(bgColor: .systemBackground, text: "UICollectionElementKindSectionFooter", textColor: .label, font: UIFont.systemFont(ofSize: 16, weight: .medium), aligment: .center)
        
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
