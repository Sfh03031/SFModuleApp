//
//  CryptoExampleVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/11/4.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SFStyleKit
import CryptoSwift

class CryptoExampleVC: BaseViewController {
    
    var targetStr = "https://ksdb.sparke.cn/video/english/2024/3/2036971665844500544_t.mp4"
    var aesKey = "2K3s3A5261a724p5"
    var aesIv = "25p82S94k54E6265"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .hex_F5F6F9
        self.view.addSubview(targetLabel)
        self.view.addSubview(keyLabel)
        self.view.addSubview(keyBtn)
        self.view.addSubview(ivLabel)
        self.view.addSubview(ivBtn)
        self.view.addSubview(cryptoBtn)
    }
    
    /// 秘钥转base64
    func keyToBase64() {
        keyBtn.isSelected = !keyBtn.isSelected
        if keyBtn.isSelected == true {
            keyLabel.text = "base64格式: \(String(describing: aesKey.sf.toBase64()))"
        } else {
            keyLabel.text = "原始秘钥: \(aesKey)"
        }
    }
    
    /// 偏移量转base64
    func ivToBase64() {
        ivBtn.isSelected = !ivBtn.isSelected
        if ivBtn.isSelected == true {
            ivLabel.text = "base64格式: \(String(describing: aesIv.sf.toBase64()))"
        } else {
            ivLabel.text = "原始偏移量: \(aesIv)"
        }
    }
    
    func crypto() {
        let encryptRes = CryptoManager.shared.aes_encryptToBase64(targetStr, aesKey: aesKey, iv: aesIv)
        let decrypyRes = CryptoManager.shared.aes_decryptBase64ToString(encryptRes, aesKey: aesKey, iv: aesIv)
        cryptoBtn.isSelected = !cryptoBtn.isSelected
        if cryptoBtn.isSelected == true {
            targetLabel.text = "加密结果(base64格式):\n\(encryptRes)"
        } else {
            targetLabel.text = "解密结果:\n\(decrypyRes)"
        }
    }

    // MARK: - lazyload
    
    lazy var targetLabel: UILabel = {
        let label = UILabel()
        label.sf.frame(CGRectMake(15, 100, SCREENW - 30, 100))
            .text("需要加密链接:\n \(targetStr)")
            .textColor(.label)
            .font(UIFont.systemFont(ofSize: 14.0, weight: .medium))
            .alignment(.center)
            .lines(0)
            .makeRadius(10.0)
        return label
    }()
    
    lazy var cryptoBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.sf.frame(CGRectMake(50, 210, SCREENW - 100, 40))
            .title("加密", for: .normal)
            .title("解密", for: .selected)
            .titleFont(UIFont.systemFont(ofSize: 14.0, weight: .medium))
            .titleColor(.label)
            .makeBorder(color: .blue, with: 1.0)
            .makeRadius(10.0)
            .addTapAction { view in
            self.crypto()
        }
        
        return btn
    }()

    lazy var keyLabel: UILabel = {
        let label = UILabel()
        label.sf.frame(CGRectMake(15, 280, SCREENW - 30, 80))
            .text("原始秘钥: \(aesKey)")
            .textColor(.label)
            .font(UIFont.systemFont(ofSize: 12.0, weight: .medium))
            .alignment(.center)
            .lines(0)
            .makeRadius(10.0)
        return label
    }()
    
    lazy var keyBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.sf.frame(CGRectMake(50, 370, SCREENW - 100, 40))
            .title("转为base64格式", for: .normal)
            .title("还原", for: .selected)
            .titleFont(UIFont.systemFont(ofSize: 14.0, weight: .medium))
            .titleColor(.label)
            .makeBorder(color: .blue, with: 1.0)
            .makeRadius(10.0)
            .addTapAction { view in
            self.keyToBase64()
        }
        
        return btn
    }()
    
    lazy var ivLabel: UILabel = {
        let label = UILabel()
        label.sf.frame(CGRectMake(15, 440, SCREENW - 30, 80))
            .text("原始偏移量: \(aesIv)")
            .textColor(.label)
            .font(UIFont.systemFont(ofSize: 12.0, weight: .medium))
            .alignment(.center)
            .lines(0)
            .makeRadius(10.0)
        return label
    }()
    
    lazy var ivBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.sf.frame(CGRectMake(50, 530, SCREENW - 100, 40))
            .title("转为base64格式", for: .normal)
            .title("还原", for: .selected)
            .titleFont(UIFont.systemFont(ofSize: 14.0, weight: .medium))
            .titleColor(.label)
            .makeBorder(color: .blue, with: 1.0)
            .makeRadius(10.0)
            .addTapAction { view in
            self.ivToBase64()
        }
        
        return btn
    }()
    
    

}
