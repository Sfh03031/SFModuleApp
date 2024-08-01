//
//  StarRatingCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/22.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import HCSStarRatingView

class StarRatingCell: BaseTableViewCell {

    override func loadViews() {
        self.contentView.addSubview(rateView)
        self.contentView.addSubview(resLabel)
    }
    
    override func layoutViews() {
        rateView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(20)
            make.right.equalTo(-10)
            make.height.equalTo(40)
        }
        
        resLabel.snp.makeConstraints { make in
            make.top.equalTo(rateView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
        }
    }
    
    @objc func didChangeValue(_ sender: HCSStarRatingView) {
        resLabel.text = "\(sender.value)"
    }
    
    lazy var rateView: HCSStarRatingView = {
        let view = HCSStarRatingView()
        view.backgroundColor = .clear
        view.maximumValue = 5
        view.minimumValue = 0
        view.value = 1
//        view.tintColor = UIColor.sf.random
//        view.allowsHalfStars = true
//        view.emptyStarImage = UIImage(named: "heart-empty")?.withRenderingMode(.alwaysTemplate)
//        view.halfStarImage = UIImage(named: "heart-half")?.withRenderingMode(.alwaysTemplate)
//        view.filledStarImage = UIImage(named: "heart-full")?.withRenderingMode(.alwaysTemplate)
        view.addTarget(self, action: #selector(didChangeValue(_:)), for: .valueChanged)
        return view
    }()
    
    lazy var resLabel: UILabel = {
        let label = UILabel(bgColor: .clear, textColor: UIColor.sf.random, font: UIFont.systemFont(ofSize: 16), aligment: .center)
        return label
    }()

}
