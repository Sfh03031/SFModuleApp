//
//  NVIndicatorCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/28.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SFStyleKit
import NVActivityIndicatorView

class NVIndicatorCell: BaseCollectionViewCell {
    
    var type: NVActivityIndicatorType? = nil {
        didSet {
            self.indicator.stopAnimating()
            self.indicator.type = type!
            self.indicator.startAnimating()
        }
    }
    
    override func loadViews() {
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(indicator)
    }
    
    override func layoutViews() {
        indicator.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    lazy var indicator: NVActivityIndicatorView = {
        let view = NVActivityIndicatorView(frame: self.contentView.bounds, color: UIColor.sf.random, padding: 10.0)
        return view
    }()
}
