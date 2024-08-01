//
//  BaseView.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/16.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

open class BaseView: UIView {

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadViews()
        layoutViews()
    }
    
    open func loadViews() {}
    open func layoutViews() {}
    
    open override func updateConstraints() {
        layoutViews()
        super.updateConstraints()
    }
}
