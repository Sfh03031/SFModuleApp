//
//  EpsilonVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/15.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import HandyJSON
import PopMenu
//import InAppViewDebugger
import FLEX
import SFStyleKit
import UIFontComplete

class EpsilonVC: BaseViewController {

    var dataList: [EpsilonSecModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let img_left = SFSymbol.symbol(name: "ladybug.fill", pointSize: 25.0, weight: .regular, scale: .default, tintColor: .systemTeal)
        let img_right = SFSymbol.symbol(name: "list.star", pointSize: 25.0, weight: .regular, scale: .default, tintColor: .systemTeal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: img_left!, style: .plain, target: self, action: #selector(leftTap(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: img_right!, style: .plain, target: self, action: #selector(rightTap(_:)))
        
        self.view.addSubview(self.tableView)
        
        let list = [
            ["name": "color", "list": [
                ["name": "色彩", "type": "4"],
            ]],
            ["name": "view", "list": [
                ["name": "刮刮乐", "type": "9"],
                ["name": "星星评分", "type": "10"],
                ["name": "闪烁", "type": "18"],
                ["name": "钻石闪耀", "type": "37"],
                ["name": "时间卡尺", "type": "51"],
                ["name": "时间线", "type": "52"],
                ["name": "多标签", "type": "59"],
                ["name": "雷达波", "type": "60"],
                ["name": "水波浪", "type": "61"],
                ["name": "渐变加载条", "type": "62"],
                ["name": "数字变形", "type": "63"],
                ["name": "五彩纸屑", "type": "64"],
                ["name": "高斯模糊", "type": "65"],
                ["name": "脉冲动画", "type": "66"],
                ["name": "弹出提示", "type": "68"],
                ["name": "分段进度", "type": "69"],
            ]],
            ["name": "button", "list": [
                ["name": "一键三连", "type": "53"],
//                ["name": "流体浮动", "type": "54"],
                ["name": "悬浮", "type": "55"],
                ["name": "登录", "type": "56"],
                ["name": "转场动效", "type": "57"],
            ]],
            ["name": "label", "list": [
                ["name": "滚动", "type": "15"],
                ["name": "变形", "type": "24"],
                ["name": "翻转", "type": "25"],
                ["name": "混合", "type": "26"],
                ["name": "标签", "type": "29"],
//                ["name": "倒计时", "type": "30"],
                ["name": "展开收起", "type": "31"],
            ]],
            ["name": "image", "list": [
                ["name": "加载gif图", "type": "11"],
            ]],
            ["name": "slider", "list": [
                ["name": "带气泡的进度条", "type": "22"],
                ["name": "环形进度", "type": "70"],
            ]],
            ["name": "switch", "list": [
                ["name": "开关特效", "type": "67"],
            ]],
            ["name": "charts", "list": [
                ["name": "学习数据", "type": "5"],
                ["name": "电子表格", "type": "17"],
                ["name": "图表", "type": "21"],
            ]],
            ["name": "menu", "list": [
                ["name": "弹窗菜单", "type": "8"],
                ["name": "环形菜单", "type": "58"],
            ]],
            ["name": "animator", "list": [
                ["name": "UI动画", "type": "14"],
            ]],
        ]
        
        for (_, item) in list.enumerated() {
            let dic = item as [String: Any]
            let model = JSONDeserializer<EpsilonSecModel>.deserializeFrom(dict: dic)
            dataList.append(model!)
        }
        
        self.tableView.reloadData()
        
        
        ScreenRotator.shared.orientationMaskDidChange = { orientationMask in
            print("orientationMask is: \(orientationMask)")
        }
    }
    
    @objc func leftTap(_ sender: UIBarButtonItem) {
//        InAppViewDebugger.presentForViewController(self)
        FLEXManager.shared.showExplorer()
    }
    
    @objc func rightTap(_ sender: UIBarButtonItem) {
        
        
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
extension EpsilonVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList[section].list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = dataList[indexPath.section].list ?? []
        let model = list[indexPath.row]
        
        let identifier:String = NSStringFromClass(EpsilonCell.self)
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? EpsilonCell
        if cell == nil {
            cell = EpsilonCell.init(style: .default, reuseIdentifier: identifier)
        }
        
        cell?.loadData(model, indexPath: indexPath)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let list = dataList[indexPath.section].list ?? []
        let model = list[indexPath.row]
        ScaffoldManager.shared.ShowVC(self: self, type: model.type ?? "0", name: model.name ?? "")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFLOAT_MIN
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .hex_F5F6F9
        
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: SCREENW - 40, height: 60),
                            bgColor: .clear,
                            text: self.dataList[section].name ?? "",
                            textColor: .alizarin,
                            font: UIFont.init(font: .georgiaItalic, size: 18)!,
                            aligment: .left)
        header.addSubview(label)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}
