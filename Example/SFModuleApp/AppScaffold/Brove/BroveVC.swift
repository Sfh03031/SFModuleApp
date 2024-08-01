//
//  BroveVC.swift
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

class BroveVC: BaseViewController {
    
    var dataList: [EpsilonModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.sf.random
        
        let img_left = SFSymbol.symbol(name: "ladybug.fill", pointSize: 25.0, weight: .regular, scale: .default, tintColor: .systemTeal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: img_left!, style: .plain, target: self, action: #selector(leftTap(_:)))
        
        self.view.addSubview(self.tableView)
        
        let list = [
            ["name": "头部缩放背景", "type": "38"],
            ["name": "折叠cell", "type": "23"],
            ["name": "cell左右滑", "type": "49"],
            ["name": "cell标签", "type": "50"]
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
extension BroveVC: UITableViewDelegate, UITableViewDataSource {
    
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
        ScaffoldManager.shared.ShowVC(self: self, type: model.type ?? "0", name: model.name ?? "")
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

