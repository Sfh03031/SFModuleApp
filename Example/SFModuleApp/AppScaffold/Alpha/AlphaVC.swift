//
//  AlphaVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/15.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import HandyJSON
import SkeletonView
import WhatsNew
import FLEX
import SFStyleKit

class AlphaVC: BaseViewController {
    
    var dataList: [EpsilonModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .random

        let img_left = SFSymbol.symbol(name: "ladybug.fill", pointSize: 25.0, weight: .regular, scale: .default, tintColor: .systemTeal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: img_left!, style: .plain, target: self, action: #selector(leftTap(_:)))
        
        self.view.addSubview(self.tableView)
        
        let list = [
            ["name": "切换服务地址", "type": "0"],
            ["name": "动态AppIcon", "type": "1"],
            ["name": "轮播", "type": "6"],
            ["name": "断网页/空白页", "type": "7"],
            ["name": "骨架屏", "type": "13"],
            ["name": "载入定制字体", "type": "27"],
            ["name": "看门狗", "type": "34"],
            ["name": "新特性", "type": "39"],
            ["name": "换肤", "type": "71"],
            ["name": "后台保活", "type": "72"],
            ["name": "性能监控", "type": "73"],
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //FIXME: 因程序启动时状态栏高度尚未取到值，懒加载设置frame会导致tableview布局不正确，故重新设置了一次，只有首页会这样，其它页不会
        self.tableView.frame = CGRect.init(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - BottomHeight)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //FIXME: 因程序启动时状态栏高度尚未取到值，懒加载设置frame会导致tableview布局不正确，故重新设置了一次，只有首页会这样，其它页不会
        self.tableView.frame = CGRect.init(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - BottomHeight)
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
extension AlphaVC: UITableViewDelegate, UITableViewDataSource {
    
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

