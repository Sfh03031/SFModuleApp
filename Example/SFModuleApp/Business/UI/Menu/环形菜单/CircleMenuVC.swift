//
//  CircleMenuVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/28.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import CircleMenu

class CircleMenuVC: BaseViewController {
    
    let items: [(icon: String, color: UIColor)] = [
        ("icon_home.pdf", UIColor.random),
        ("icon_search.pdf", UIColor.random),
        ("notifications-btn.pdf", UIColor.random),
        ("settings-btn.pdf", UIColor.random),
        ("nearby-btn.pdf", UIColor.random)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemTeal

        let button = CircleMenu(
            frame: CGRect.init(x: (SCREENW - 60) / 2, y: 350, width: 60, height: 60),
            normalIcon:"icon_menu",
            selectedIcon:"icon_close",
            buttonsCount: items.count,
            duration: 0.8,
            distance: 120)
        button.backgroundColor = UIColor.random
        button.delegate = self
        button.layer.cornerRadius = 30.0
        button.layer.masksToBounds = true
        view.addSubview(button)
        
//        button.snp.makeConstraints { make in
//            make.size.equalTo(CGSize(width: 60, height: 60))
//            make.center.equalTo(self.view)
//        }
    }
    

    // MARK: <CircleMenuDelegate>

//    func circleMenu(_: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
////        button.backgroundColor = items[atIndex].color
//
////        button.setImage(UIImage(named: items[atIndex].icon), for: .normal)
//
//        // set highlited image
////        let highlightedImage = UIImage(named: items[atIndex].icon)?.withRenderingMode(.alwaysTemplate)
////        button.setImage(highlightedImage, for: .highlighted)
////        button.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
//        
        
//    }

//    func circleMenu(_: CircleMenu, buttonWillSelected _: UIButton, atIndex: Int) {
//        print("button will selected: \(atIndex)")
//    }
//
//    func circleMenu(_: CircleMenu, buttonDidSelected _: UIButton, atIndex: Int) {
//        print("button did selected: \(atIndex)")
//    }

}

extension CircleMenuVC: CircleMenuDelegate {
    
    func circleMenu(_ circleMenu: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        print("circleMenu(_: CircleMenu, willDisplay button: UIButton, atIndex: Int)")
        
        switch atIndex {
        case 0:
            button.backgroundColor = .purple
            button.setImage(SFSymbol.symbol(name: "signature"), for: .normal)
            break
        case 1:
            button.backgroundColor = .red
            button.setImage(SFSymbol.symbol(name: "sunset"), for: .normal)
            break
        case 2:
            button.backgroundColor = .orange
            button.setImage(SFSymbol.symbol(name: "command"), for: .normal)
            break
        case 3:
            button.backgroundColor = .blue
            button.setImage(SFSymbol.symbol(name: "figure.archery"), for: .normal)
            break
        case 4:
            button.backgroundColor = .green
            button.setImage(SFSymbol.symbol(name: "figure.basketball"), for: .normal)
            break
        default:
            break
        }
    }
    
    func circleMenu(_ circleMenu: CircleMenu, buttonWillSelected button: UIButton, atIndex: Int) {
        print("button will selected: \(atIndex)")
    }
    
    func circleMenu(_ circleMenu: CircleMenu, buttonDidSelected button: UIButton, atIndex: Int) {
        print("button did selected: \(atIndex)")
    }
}
