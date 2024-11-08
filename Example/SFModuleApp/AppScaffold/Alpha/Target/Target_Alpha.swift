//
//  Target_Alpha.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/15.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

public class Target_Alpha: NSObject {

    @objc func Action_toAlpha(_ param: [String: Any]) -> UIViewController? {
        let vc = AlphaMainVC(collectionViewLayout: FlowLayoutManager.shared.makeFlowLayout())
        vc.title = param["title"] as? String ?? ""
        return vc
    }
}
