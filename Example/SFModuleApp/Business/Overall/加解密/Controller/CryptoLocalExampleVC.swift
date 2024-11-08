//
//  CryptoLocalExampleVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/11/5.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

// 【Window -> Devices and Simulators -> 选中对应app点开下面的带三个...的图标 -> Download Container -> 找到下载的.xcappdata文件,右键显示包内容 -> 在目录里找到存放的文件】
// 加密前后重复上述操作，可对比加密效果，加密后即使拿到视频资源也无法播放
// 最理想的状态是资源本身就是加密状态，播放时去解密，即HLS资源加解密，需要服务端提前把资源加密，加密过程视资源大小与多少可能会耗费大量时间与服务器资源

import UIKit
import JohnWick
import AVKit

class CryptoLocalExampleVC: BaseViewController {
    
    var value = "快速实现大文件的加密解密功能，可以为任何二进制文件加密解密。\n加密原理是一个二进制数与另一个二进制数异或一次后就是另一个数，异或两次后就是它本身。\n加密步骤:\n 先定义一个共用的key，先读取文件的前100个字符，与key进行与或操作，这个文件就加密了，为了标记该文件为加密状态，把key补文件的末尾。\n解密步骤:\n 从文件中读取末位一个长度为key的长度字符串，然后与key进行对比，如果相同则为加密文件，否则为未加密文件，就不需要解密。 与key进行与或运算后，然后截取末尾长度未key的字符串后，所产生的新字符串就是未加密的源文件。"

    var fileName = "测试视频文件.mp4"
    var filePath = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .hex_F5F6F9
        self.view.addSubview(targetLabel)
        self.view.addSubview(nameLabel)
        self.view.addSubview(encryBtn)
        self.view.addSubview(decryBtn)
        self.view.addSubview(playBtn)
        
        var docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last ?? ""
        docPath = (docPath as NSString).appendingPathComponent(fileName)
        filePath = docPath
        nameLabel.text = "本地资源地址: \(filePath)"
        
        if UserDefaults.standard.object(forKey: "CryptoLocalFirst") == nil {
            let path = Bundle.main.path(forResource: fileName, ofType: nil) ?? ""
            
            do {
                try FileManager.default.copyItem(atPath: path, toPath: docPath)
            } catch {
                debugPrint(error.localizedDescription)
            }
            
            UserDefaults.standard.set("1", forKey: "CryptoLocalFirst")
        }
        
    }
    
    /// 加密
    func encrypto() {
        ZXYFileEncrypt.encryptFile(withFilePath: self.filePath) { msg in
            print("加密完成: \(String(describing: msg))")
            SF.WINDOW?.makeToast(msg)
        }
    }
    
    /// 解密
    func decrypto() {
        ZXYFileEncrypt.decryptFile(withFilePath: self.filePath) { decryptFilePath in
            print("解密完成: \(String(describing: decryptFilePath))")
            SF.WINDOW?.makeToast("文件已解密, 可正常播放")
        }
    }
    
    /// 播放
    func play() {
        let vc = AVPlayerViewController()
        vc.player = AVPlayer.init(url: URL.init(fileURLWithPath: self.filePath))
        vc.view.frame = CGRect.init(x: 0, y: 0, width: SCREENH, height:SCREENW)
        vc.view.center = CGPoint.init(x: SCREENW/2, y: SCREENH/2)
        let transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi/2))
        vc.view.transform = transform
        self.view.addSubview((vc.view)!)
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: lazyload
    
    lazy var targetLabel: UILabel = {
        let label = UILabel()
        label.sf.frame(CGRectMake(15, 100, SCREENW - 30, 250))
            .text("\(value)")
            .textColor(.label)
            .font(UIFont.systemFont(ofSize: 14.0, weight: .medium))
            .alignment(.left)
            .lines(0)
            .makeRadius(10.0)
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.sf.frame(CGRectMake(15, 370, SCREENW - 30, 60))
            .text("\(value)")
            .textColor(.label)
            .font(UIFont.systemFont(ofSize: 14.0, weight: .medium))
            .alignment(.center)
            .lines(0)
            .makeRadius(10.0)
        return label
    }()
    
    lazy var encryBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.sf.frame(CGRectMake(15, 450, SCREENW/2 - 30, 40))
            .title("加密", for: .normal)
            .titleFont(UIFont.systemFont(ofSize: 14.0, weight: .medium))
            .titleColor(.label)
            .makeBorder(color: .blue, with: 1.0)
            .makeRadius(10.0)
            .addTapAction { view in
            self.encrypto()
        }
        
        return btn
    }()
    
    lazy var decryBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.sf.frame(CGRectMake(SCREENW/2 + 15, 450, SCREENW/2 - 30, 40))
            .title("解密", for: .normal)
            .titleFont(UIFont.systemFont(ofSize: 14.0, weight: .medium))
            .titleColor(.label)
            .makeBorder(color: .blue, with: 1.0)
            .makeRadius(10.0)
            .addTapAction { view in
            self.decrypto()
        }
        
        return btn
    }()
    
    lazy var playBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.sf.frame(CGRectMake(15, 510, SCREENW - 30, 40))
            .title("播放视频", for: .normal)
            .titleFont(UIFont.systemFont(ofSize: 14.0, weight: .medium))
            .titleColor(.label)
            .makeBorder(color: .blue, with: 1.0)
            .makeRadius(10.0)
            .addTapAction { view in
            self.play()
        }
        
        return btn
    }()

}
