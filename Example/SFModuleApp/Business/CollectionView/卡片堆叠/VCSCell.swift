//
//  VCSCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/21.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import VerticalCardSwiper

class VCSCell: CardCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 12
        super.layoutSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .random
        self.addSubview(nameLabel)
        self.addSubview(ageLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var nameLabel: UILabel = {
        let view = UILabel(frame: CGRect(x: 10, y: 10, width: 200, height: 30), bgColor: .systemTeal, textColor: .white, aligment: .left)
        return view
    }()
    
    lazy var ageLabel: UILabel = {
        let view = UILabel(frame: CGRect(x: 10, y: 50, width: 100, height: 30), bgColor: .systemTeal, textColor: .white, aligment: .left)
        return view
    }()
}
