//
//  Target_Brove.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/15.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

public class Target_Brove: NSObject {

    @objc func Action_toBrove(_ param: [String: Any]) -> UIViewController? {
        let vc = BroveMainVC(collectionViewLayout: FlowLayoutManager.shared.makeFlowLayout(itemSize: CGSize(width: (SCREENW - 30) / 2, height: 80)))
        vc.title = param["title"] as? String ?? ""
        return vc
    }
}
