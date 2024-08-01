//
//  SparkViewsService.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/16.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import LYEmptyView

class SparkViewsService: LYEmptyView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func prepare() {
        super.prepare()
        
    }
    
    static func getEmptyView() -> LYEmptyView {
        return LYEmptyView.emptyView(withCustomView: SparkEmptyView())
    }
    
    static func getNoNetView() -> LYEmptyView {
        return LYEmptyView.emptyView(withCustomView: SparkNoNetworkView())
    }
    
    static func getVisitView() -> LYEmptyView {
        return LYEmptyView.emptyView(withCustomView: SparkNoNetworkView())
    }

}
