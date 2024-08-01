//
//  GlitchCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/30.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class GlitchCell: BaseCollectionViewCell {
    
    var mode: CGBlendMode = .lighten {
        didSet {
            label.blendMode = mode
        }
    }
    
    
    override func loadViews() {
        label.sizeToFit()
        contentView.addSubview(label)
    }
    
    override func layoutViews() {
//        label.snp.makeConstraints { make in
//            make.edges.equalTo(UIEdgeInsets.zero)
//        }
    }
    
    lazy var label: GlitchLabel = {
        let view = GlitchLabel()
        view.backgroundColor = .white
        view.text = "Hello World"
        view.textColor = .systemTeal
        view.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        view.textAlignment = .center
        view.blendMode = .lighten
        return view
    }()
}
