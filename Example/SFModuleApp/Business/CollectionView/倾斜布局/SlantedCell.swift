//
//  SlantedCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/17.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
//import CollectionViewSlantedLayout

let yOffsetSpeed: CGFloat = 150.0
let xOffsetSpeed: CGFloat = 100.0

class SlantedCell: CollectionViewSlantedCell {
    
    private var gradient = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadViews() {
        self.contentView.addSubview(imgView)
        imgView.addSubview(label)
        
        imgView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(all: 0))
        }
        
        label.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(all: 0))
        }
    }
    
    override func layoutSubviews() {
        if let backgroundView = backgroundView {
            gradient.colors = [UIColor.orange.cgColor, UIColor.yellow.cgColor]
            gradient.locations = [0.0, 1.0]
            gradient.frame = backgroundView.bounds
            backgroundView.layer.addSublayer(gradient)
        }
        
        super.layoutSubviews()
    }
    
    var image: UIImage = UIImage() {
        didSet {
            imgView.image = image
        }
    }

    var imageHeight: CGFloat {
        return (imgView.image?.size.height) ?? 0.0
    }

    var imageWidth: CGFloat {
        return (imgView.image?.size.width) ?? 0.0
    }

    func offset(_ offset: CGPoint) {
        imgView.frame = imgView.bounds.offsetBy(dx: offset.x, dy: offset.y)
        label.frame = label.bounds.offsetBy(dx: offset.x, dy: offset.y)
    }
    
    lazy var imgView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var label: UILabel = {
        let view = UILabel(bgColor: .clear, textColor: .white, font: UIFont.systemFont(ofSize: 60), aligment: .center)
        return view
    }()
}
