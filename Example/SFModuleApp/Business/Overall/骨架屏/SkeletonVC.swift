//
//  SkeletonVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class SkeletonVC: BaseViewController {
    
    var isShowAni:Bool = false
    
    var dataList:[String] = ["UIView","UITableView", "UICollectionView"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
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
extension SkeletonVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier:String = NSStringFromClass(UITableViewCell.self)
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: identifier)
        }
        cell?.selectionStyle = .gray
        
        cell?.textLabel?.text = dataList[indexPath.row]
        cell?.imageView?.image = SFSymbol.symbol(name: "flag.checkered.2.crossed", pointSize: 20, tintColor: UIColor.sf.random)
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            let vc = self.isShowAni ? ViewAnimatorVC() : SKViewVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = SKTableViewVC()
            vc.isShowAni = self.isShowAni
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = SKCollectionViewVC()
            vc.isShowAni = self.isShowAni
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
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
