//
//  Target_Delta.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/15.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

public class Target_Delta: NSObject {

    @objc func Action_toDelta(_ param: [String: Any]) -> UIViewController? {
        let vc = DeltaMainVC(collectionViewLayout: FlowLayoutManager.shared.makeFlowLayout(itemSize: CGSize(width: (SCREENW - 40) / 3, height: 80)))
        vc.title = param["title"] as? String ?? ""
        return vc
    }
}
