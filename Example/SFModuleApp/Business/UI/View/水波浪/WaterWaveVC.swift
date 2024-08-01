//
//  WaterWaveVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/31.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import YXWaveView

class WaterWaveVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let avatarView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        avatarView.layer.cornerRadius = 30
        avatarView.layer.masksToBounds = true
        avatarView.layer.borderColor  = UIColor.white.cgColor
        avatarView.layer.borderWidth = 3
//        avatarView.layer.contents = SFSymbol.symbol(name: "figure.basketball", pointSize: 30, tintColor: .random)?.cgImage
        avatarView.image = SFSymbol.symbol(name: "figure.basketball", pointSize: 30, tintColor: .random)
        
        let waterView = YXWaveView(frame: CGRect(x: 0, y: TopHeight, width: SCREENW, height: 250), color: .white)
        waterView.backgroundColor = .random
        waterView.addOverView(avatarView)
        waterView.waveCurvature = 1.2
        waterView.waveHeight = 12
        waterView.waveSpeed = 0.8
        waterView.realWaveColor = UIColor.white // 覆盖了init方法里的color属性
        waterView.maskWaveColor = UIColor.clear
        self.view.addSubview(waterView)
        
        waterView.start()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
