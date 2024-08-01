//
//  DeltaVC.swift
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

class DeltaVC: BaseViewController {
    
    var dataList: [EpsilonModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.sf.random
        
        let img_left = SFSymbol.symbol(name: "ladybug.fill", pointSize: 25.0, weight: .regular, scale: .default, tintColor: .systemTeal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: img_left!, style: .plain, target: self, action: #selector(leftTap(_:)))
        
        self.view.addSubview(self.tableView)
        
        let list = [
            ["name": "过渡动画", "type": "32"],
            ["name": "弹簧阻尼", "type": "33"],
            ["name": "放大重点", "type": "40"],
            ["name": "横竖嵌套", "type": "41"],
            ["name": "控制方向", "type": "42"],
            ["name": "倾斜布局", "type": "43"],
            ["name": "卡片堆叠", "type": "44"],
            ["name": "卡片轮转", "type": "45"],
            ["name": "上下分块", "type": "46"],
            ["name": "旋转木马", "type": "47"],
            ["name": "波浪过渡", "type": "48"],
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
//        InAppViewDebugger.presentForViewController(self)
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
extension DeltaVC: UITableViewDelegate, UITableViewDataSource {
    
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
        case 32:
            let manager = PopMenuManager.default
            manager.actions = [
                PopMenuDefaultAction(title: "CrossFade", image: SFSymbol.symbol(name: "line.3.crossed.swirl.circle.fill"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)),
                PopMenuDefaultAction(title: "Cube", image: SFSymbol.symbol(name: "shippingbox.fill"), color: #colorLiteral(red: 0.9816910625, green: 0.5655395389, blue: 0.4352460504, alpha: 1)),
                PopMenuDefaultAction(title: "Linear", image: SFSymbol.symbol(name: "pencil.and.outline"), color: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)),
                PopMenuDefaultAction(title: "Page", image: SFSymbol.symbol(name: "figure.walk.motion"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)),
                PopMenuDefaultAction(title: "Parallax", image: SFSymbol.symbol(name: "paragraphsign"), color: #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)),
                PopMenuDefaultAction(title: "RotateInOut", image: SFSymbol.symbol(name: "crop.rotate"), color: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)),
                PopMenuDefaultAction(title: "SnapIn", image: SFSymbol.symbol(name: "link.circle.fill"), color: #colorLiteral(red: 0.9816910625, green: 0.5655395389, blue: 0.4352460504, alpha: 1)),
                PopMenuDefaultAction(title: "ZoomInOut", image: SFSymbol.symbol(name: "fan.oscillation"), color: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)),
            ]
            manager.popMenuAppearance.popMenuFont = UIFont(name: "AvenirNext-DemiBold", size: 16)!
            manager.popMenuAppearance.popMenuBackgroundStyle = .blurred(.light)
            manager.popMenuShouldDismissOnSelection = true
            manager.popMenuDelegate = self
            manager.present()
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

// MARK: - PopMenuViewControllerDelegate
extension DeltaVC: PopMenuViewControllerDelegate {
    
    func popMenuDidSelectItem(_ popMenuViewController: PopMenuViewController, at index: Int) {
        let list = ["CrossFade","Cube","Linear","Page","Parallax","RotateInOut","SnapIn","ZoomInOut"]
        
        let vc = CollectionViewLayoutVC()
        vc.title = list[index] + "AttributesAnimator"
        vc.index = index
        self.sf.push(vc)
    }
    
}
