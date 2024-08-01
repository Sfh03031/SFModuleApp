//
//  SplitflapVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/30.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import Twinkle

class SplitflapVC: BaseViewController {
    fileprivate let words = ["Hey you", "Bonsoir", "12h15", "Arrival", "Fuck off man"]
    fileprivate var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemTeal

        view.addSubview(splitflap)
        view.addSubview(actionBtn)

        splitflap.datasource = self
        splitflap.delegate = self
        splitflap.reload()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        updateSplitFlapAction(actionBtn)
    }

    @objc func updateSplitFlapAction(_ sender: UIButton) {
        splitflap.reload()
        splitflap.setText(words[currentIndex], animated: true, completionBlock: {
            print("Display finished!")
        })
        
        if currentIndex < words.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        
        updateButtonWithTitle(words[currentIndex])

    }

    fileprivate func updateButtonWithTitle(_ title: String) {
        actionBtn.setTitle("Next: \(words[currentIndex])", for: UIControl.State())
    }
    
    //MARK: - lzyload

    lazy var splitflap: Splitflap = {
        let view = Splitflap(frame: CGRect(x: 10, y: 200, width: SCREENW - 20, height: 100))

        return view
    }()
    
    lazy var actionBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 40, y: SCREENH - SoftHeight - 60, width: SCREENW - 80, height: 44)
        btn.backgroundColor = .white
        btn.setTitle("Next:", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.addTarget(self, action: #selector(updateSplitFlapAction(_:)), for: .touchUpInside)
        return btn
    }()
}

// MARK: - Splitflap DataSource Methods
extension SplitflapVC: SplitflapDataSource {

    func numberOfFlapsInSplitflap(_ splitflap: Splitflap) -> Int {
        return words[currentIndex].count
    }

    func tokensInSplitflap(_ splitflap: Splitflap) -> [String] {
        return SplitflapTokens.AlphanumericAndSpace
    }
 
}

// MARK: - Splitflap Delegate Methods
extension SplitflapVC: SplitflapDelegate {
    
    func splitflap(_ splitflap: Splitflap, rotationDurationForFlapAtIndex index: Int) -> Double {
        return 0.05
    }

    func splitflap(_ splitflap: Splitflap, builderForFlapAtIndex index: Int) -> FlapViewBuilder {
        return FlapViewBuilder { builder in
            builder.backgroundColor = .systemOrange
            builder.cornerRadius = 5
            builder.font = UIFont(name: "Courier", size: 50)
            builder.textAlignment = .center
            builder.textColor = .systemYellow
            builder.lineColor = .systemTeal
        }
    }
}
