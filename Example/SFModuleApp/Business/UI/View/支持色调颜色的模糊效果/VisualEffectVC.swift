//
//  VisualEffectVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/6/3.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import VisualEffectView

class VisualEffectVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(imgView)
        self.view.addSubview(slider)
        imgView.addSubview(effectView)
        
        imgView.snp.makeConstraints { make in
            make.top.equalTo(TopHeight)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-SoftHeight-60)
        }
        
        slider.snp.makeConstraints { make in
            make.left.height.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(-SoftHeight-20)
        }
        
        effectView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    @objc func valueChange(_ sender: UISlider) {
        effectView.blurRadius = CGFloat(sender.value)
    }
    

    lazy var imgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Girl3.jpg")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var effectView: VisualEffectView = {
        let view = VisualEffectView()
        view.colorTint = .random
        view.colorTintAlpha = 0.2
        view.blurRadius = 0
        view.scale = 1
        return view
    }()
    
    lazy var slider: UISlider = {
        let view = UISlider.init()
        view.minimumTrackTintColor = .blue
        view.maximumTrackTintColor = .lightGray
        view.maximumValue = 20
        view.minimumValue = 0
        view.addTarget(self, action: #selector(valueChange(_ :)), for: .valueChanged)
        return view
    }()

}
