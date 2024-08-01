//
//  GammaVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/15.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import HandyJSON
import SkeletonView
import NotificationBannerSwift
import PopMenu
//import InAppViewDebugger
import WhatsNew
import FLEX

class GammaVC: BaseViewController {
    
    var dataList: [EpsilonModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.sf.random
        
        let img_left = SFSymbol.symbol(name: "ladybug.fill", pointSize: 25.0, weight: .regular, scale: .default, tintColor: .systemTeal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: img_left!, style: .plain, target: self, action: #selector(leftTap(_:)))
        
        self.view.addSubview(self.tableView)
        
        let list = [
            ["name": "照片裁剪", "type": "2"],
            ["name": "涂鸦笔记", "type": "3"],
            ["name": "二维码", "type": "12"],
            ["name": "通知栏消息", "type": "16"],
            ["name": "状态栏消息", "type": "19"],
            ["name": "加载指示器", "type": "20"],
            ["name": "国旗", "type": "28"],
            ["name": "腾讯QMUIKit", "type": "35"],
            ["name": "直播推流", "type": "36"],
            ["name": "热门搜索", "type": "74"],
        ]
        
        for (_, item) in list.enumerated() {
            let dic = item as [String: Any]
            let model = JSONDeserializer<EpsilonModel>.deserializeFrom(dict: dic)
            dataList.append(model!)
        }
        
        self.tableView.reloadData()
        
        
        ScreenRotator.shared.orientationMaskDidChange = { orientationMask in
            print("orientationMask is: \(orientationMask)")
        }
    }
    
    @objc func leftTap(_ sender: UIBarButtonItem) {
        FLEXManager.shared.showExplorer()
    }

    //MARK: - lazyload
    
    //tableView
    lazy var tableView: UITableView = {
        let tabView = UITableView.init(frame: CGRect.init(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - BottomHeight), style: .grouped)
        tabView.backgroundColor = .clear
        tabView.separatorStyle = .none
        tabView.showsVerticalScrollIndicator = false
        tabView.delegate = self
        tabView.dataSource = self
        return tabView
    }()

}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension GammaVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier:String = NSStringFromClass(EpsilonCell.self)
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? EpsilonCell
        if cell == nil {
            cell = EpsilonCell.init(style: .default, reuseIdentifier: identifier)
        }
        
        cell?.loadData(self.dataList[indexPath.row], indexPath: indexPath)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let model = self.dataList[indexPath.row]
        let type = Int(model.type ?? "0")
        
        switch type {
        case 2:
            let vc = CLCameraController()
            vc.delegate = self
            self.sf.present(vc)
        default:
            ScaffoldManager.shared.ShowVC(self: self, type: model.type ?? "0", name: model.name ?? "")
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFLOAT_MIN
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFLOAT_MIN
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

//MARK: - CLCameraControllerDelegate
extension GammaVC: CLCameraControllerDelegate {
    func cameraController(_ controller: CLCameraController, didFinishTakingPhoto photo: UIImage, data: Data) {
        let vc = CLCameraResultVC()
        vc.image = photo
        self.sf.push(vc)
        controller.presentingViewController?.dismiss(animated: true)
    }

    func cameraController(_ controller: CLCameraController, didFinishTakingVideo videoURL: URL) {
        controller.presentingViewController?.dismiss(animated: true)
    }
}

