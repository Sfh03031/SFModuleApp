//
//  GifViewController.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/23.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import FLAnimatedImage

class GifViewController: BaseViewController {

    var isplaying: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(imgView)
        self.view.addSubview(btn)
        
        imgView.snp.makeConstraints { make in
            make.top.equalTo(TopHeight)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-100)
        }
        
        btn.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.size.equalTo(CGSize(width: 200, height: 44))
            make.bottom.equalTo(-SoftHeight)
        }
        
//        let gifUrl = "https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif"
//        DispatchQueue.global().async {
//            let imgData = try? Data.init(contentsOf: URL(string: gifUrl)!)
//            let image = FLAnimatedImage(gifData: imgData)
//            DispatchQueue.main.async {
//                self.imgView.animatedImage = image
//                self.imgView.startAnimating()
//            }
//        }
        
        let path = Bundle.main.path(forResource: "Dilraba", ofType: ".gif")
        let imgData = try? Data.init(contentsOf: URL.init(fileURLWithPath: path!))
        imgView.animatedImage = FLAnimatedImage(gifData: imgData)
        isplaying = true
    }
    
    @objc func btnClick(_ sender: UIButton) {
         isplaying = !isplaying
        if isplaying {
            imgView.startAnimating()
        } else {
            imgView.stopAnimating()
        }
    }
    
    lazy var imgView: FLAnimatedImageView = {
        let view = FLAnimatedImageView()
        view.contentMode = .scaleAspectFit
        view.animationRepeatCount = 0
        return view
    }()
    
    lazy var btn: UIButton = {
        let b = UIButton(type: .custom)
        b.setTitle("暂停/播放", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = .systemTeal
        b.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        return b
    }()

}
