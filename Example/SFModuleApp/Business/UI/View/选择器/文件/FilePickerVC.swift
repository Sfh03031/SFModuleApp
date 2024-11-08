//
//  FilePickerVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/22.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import JohnWick
import SFStyleKit

class FilePickerVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .hex_F5F5F9
        
        self.view.addSubview(AlphaBtn)
        AlphaBtn.center = self.view.center
    }
    
    func tapBtn() {
        SFFilePickerVC { url, data in
            SFFileBrowser.init(fileUrl: url).show()
        }.show()
    }
    

    lazy var AlphaBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.sf.backgroundColor(.random).frame(CGRect(x: 0, y: 0, width: 200, height: 50)).title("tap").tintColor(.white).titleFont(UIFont.systemFont(ofSize: 16.0, weight: .medium)).makeRadius(5.0).addTapAction { view in
            self.tapBtn()
        }
        return btn
    }()

}
