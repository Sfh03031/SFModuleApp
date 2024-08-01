//
//  FSPagerSliderCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/19.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class FSPagerSliderCell: BaseTableViewCell {

    override func loadViews() {
        self.contentView.addSubview(slider)
    }
    
    override func layoutViews() {
        slider.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
    override func loadData(_ model: BaseModel, indexPath: IndexPath) {
        
    }
    
    lazy var slider: UISlider = {
        let view = UISlider.init()
        view.minimumTrackTintColor = .blue
        view.maximumTrackTintColor = .lightGray
        view.maximumValue = 1
        view.minimumValue = 0
        return view
    }()

}
