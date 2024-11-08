//
//  Target_Gamma.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/15.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

public class Target_Gamma: NSObject {

    @objc func Action_toGamma(_ param: [String: Any]) -> UIViewController? {
        let vc = GammaMainVC(collectionViewLayout: FlowLayoutManager.shared.makeFlowLayout(itemSize: CGSize(width: (SCREENW - 30) / 2, height: 80)))
        vc.title = param["title"] as? String ?? ""
        return vc
    }
}
