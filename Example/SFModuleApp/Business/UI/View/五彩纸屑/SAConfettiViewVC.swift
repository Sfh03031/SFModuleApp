//
//  SAConfettiViewVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/31.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
//import SAConfettiView

class SAConfettiViewVC: BaseViewController {

    var isRainingConfetti = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(infoLabel)
        self.view.addSubview(confettiView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (isRainingConfetti) {
            // Stop confetti
            confettiView.stopConfetti()
            infoLabel.text = "停止下五彩纸屑雨 🙁"
        } else {
            // Start confetti
            confettiView.startConfetti()
            infoLabel.text = "开始下五彩纸屑雨 🙂"
        }
        isRainingConfetti = !isRainingConfetti
    }
    
    lazy var confettiView: SAConfettiView = {
        let view = SAConfettiView(frame: CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - SoftHeight))
        // default colors are red, green and blue
        view.colors = [UIColor(red:0.95, green:0.40, blue:0.27, alpha:1.0),
                       UIColor(red:1.00, green:0.78, blue:0.36, alpha:1.0),
                       UIColor(red:0.48, green:0.78, blue:0.64, alpha:1.0),
                       UIColor(red:0.30, green:0.76, blue:0.85, alpha:1.0),
                       UIColor(red:0.58, green:0.39, blue:0.55, alpha:1.0)]
        // from 0 - 1, default intensity is 0.5
        view.intensity = 0.5
//        view.type = .diamond
//        view.type = .confetti
        view.type = .star
//        view.type = .triangle
//        view.type = .image(SFSymbol.symbol(name: "figure.archery", pointSize: 10.0, tintColor: .random)!)
        return view
    }()

    lazy var infoLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - SoftHeight))
        label.text = "停止下五彩纸屑雨 🙁"
        label.textColor = .random
        label.font = UIFont.systemFont(ofSize: 100, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

}
