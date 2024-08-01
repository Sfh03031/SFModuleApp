//
//  TableHeadAutoScaleVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/16.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class TableHeadAutoScaleVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
        
        // 头部缩放背景
        self.tableView.yz_headerScaleImage = UIImage(named: "Girl2.jpg")
        // 设置tableView头部视图，必须设置头部视图背景颜色为clearColor,否则会被挡住
        let head = UIView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: 200))
        head.backgroundColor = .clear
        self.tableView.tableHeaderView = head
    }
    
    //MARK: - lazyload
    
    //tableView
    lazy var tableView: UITableView = {
        let tabView = UITableView.init(frame: CGRect.init(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - SoftHeight), style: .grouped)
        tabView.backgroundColor = .clear
        tabView.separatorStyle = .singleLine
        tabView.showsVerticalScrollIndicator = false
        tabView.delegate = self
        tabView.dataSource = self
        return tabView
    }()

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TableHeadAutoScaleVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier:String = NSStringFromClass(UITableViewCell.self)
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: identifier)
        }
        cell?.selectionStyle = .gray
        
        cell?.textLabel?.text = "======> \(indexPath.row) <======"
        cell?.imageView?.image = SFSymbol.symbol(name: "snowflake", pointSize: 20, tintColor: .random)
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFLOAT_MIN
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFLOAT_MIN
    }
    
}
