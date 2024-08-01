//
//  CarLensCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/21.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SFStyleKit

class CarLensCell: CarLensCollectionViewCell {
    
    var upperView: UILabel = {
        var label = UILabel()
        //FIXME: 必须设置为false，CarLensCollectionViewCell内部有自己的布局方式
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 60)
        label.textAlignment = .center
        label.textColor = .systemTeal
        label.text = "CarLens"
        return label
    }()
    
    private var bottomView: UIView = {
        var view = UIView()
        //FIXME: 必须设置为false，CarLensCollectionViewCell内部有自己的布局方式
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .random
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure(topView: upperView, cardView: bottomView, topViewHeight: 200)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
