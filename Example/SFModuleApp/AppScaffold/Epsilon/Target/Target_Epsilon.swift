//
//  Target_Epsilon.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/15.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

public class Target_Epsilon: NSObject {

    @objc func Action_toEpsilon(_ param: [String: Any]) -> UIViewController? {
        let vc = EpsilonMainVC(collectionViewLayout: FlowLayoutManager.shared.makeFlowLayout(itemSize: CGSize(width: SCREENW - 20, height: 80)))
        vc.title = param["title"] as? String ?? ""
        return vc
    }
}
