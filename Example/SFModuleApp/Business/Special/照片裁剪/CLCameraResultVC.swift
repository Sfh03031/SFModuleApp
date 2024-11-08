//
//  CLCameraResultVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/18.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import ScreenRotator

class CLCameraResultVC: BaseViewController {

    var image: UIImage?
    var intrStr: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "结果"
        self.view.addSubview(imgView)
        self.view.addSubview(intrLabel)
        
        imgView.snp.makeConstraints { make in
            make.top.equalTo(TopHeight + 10)
            make.centerX.equalTo(self.view.snp.centerX)
            make.size.equalTo(CGSizeMake(SCREENW - 20, 500))
        }
        
        intrLabel.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.bottom).offset(10)
            make.left.right.equalTo(imgView)
            make.bottom.equalTo(-SoftHeight)
        }
        
        imgView.image = self.image
        intrLabel.text = self.intrStr
    }
    
    lazy var intrLabel: UILabel = {
        let label = UILabel.init(textColor: .systemRed, font: UIFont.systemFont(ofSize: 14, weight: .regular), aligment: .center, lines: 0)
        return label
    }()

    lazy var imgView: UIImageView = {
        let view = UIImageView()
        view.sf.backgroundColor(.lightGray).contentMode(.scaleAspectFit)
        return view
    }()

}
