//
//  BroveMainVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import FLEX
import HandyJSON
import SFServiceKit
import UIFontComplete
import PopMenu
import JohnWick

class BroveMainVC: BaseCollectionViewController {
    
    let tableList = [
        ["name": "头部缩放背景", "type": "38", "key": "B-T-0"],
        ["name": "折叠cell", "type": "23", "key": "B-T-1"],
        ["name": "cell左右滑", "type": "49", "key": "B-T-2"],
        ["name": "cell标签", "type": "50", "key": "B-T-3"]
    ] as [[String: Any]]
    
    let collectionList = [
        ["name": "过渡动画", "type": "32", "key": "B-C-0"],
        ["name": "弹簧阻尼", "type": "33", "key": "B-C-1"],
        ["name": "放大重点", "type": "40", "key": "B-C-2"],
        ["name": "横竖嵌套", "type": "41", "key": "B-C-3"],
        ["name": "控制方向", "type": "42", "key": "B-C-4"],
        ["name": "倾斜布局", "type": "43", "key": "B-C-5"],
        ["name": "卡片堆叠", "type": "44", "key": "B-C-6"],
        ["name": "卡片轮转", "type": "45", "key": "B-C-7"],
        ["name": "上下分块", "type": "46", "key": "B-C-8"],
        ["name": "旋转木马", "type": "47", "key": "B-C-9"],
        ["name": "波浪过渡", "type": "48", "key": "B-C-10"],
    ]
    
    var tableDataList: [BroveMainModel] = []
    var collectionDataList: [BroveMainModel] = []
    var defLayout: FlowLayoutType = .twice

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = SFSymbolManager.shared.symbol(systemName: "ladybug.fill", withConfiguration: nil, withTintColor: .systemTeal)
        let rightImg = SFSymbolManager.shared.symbol(systemName: "switch.2", withConfiguration: nil, withTintColor: .systemTeal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: img!, style: .plain, target: self, action: #selector(leftTap(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImg!, style: .plain, target: self, action: #selector(rightTap(_:)))

        self.collectionView?.register(BroveMainCell.self, forCellWithReuseIdentifier: String(describing: BroveMainCell.self))
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        
        for (_, item) in tableList.enumerated() {
            let dic = item as [String: Any]
            let model = JSONDeserializer<BroveMainModel>.deserializeFrom(dict: dic)
            tableDataList.append(model!)
        }
        
        for (_, item) in collectionList.enumerated() {
            let dic = item as [String: Any]
            let model = JSONDeserializer<BroveMainModel>.deserializeFrom(dict: dic)
            collectionDataList.append(model!)
        }
        
        self.collectionView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.collectionView.frame = CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - BottomHeight)
    }
    
    @objc func leftTap(_ sender: UIBarButtonItem) {
        FLEXManager.shared.showExplorer()
    }
    
    @objc func rightTap(_ sender: UIBarButtonItem) {
        var target: FlowLayoutType = .twice
        var targetSize = CGSize(width: SCREENW - 20, height: 80)
        switch self.defLayout {
        case .single:
            target = .twice
            targetSize = CGSize(width: (SCREENW - 30) / 2, height: 80)
        case .twice:
            target = .triserial
            targetSize = CGSize(width: (SCREENW - 40) / 3, height: 80)
        case .triserial:
            target = .single
            targetSize = CGSize(width: SCREENW - 20, height: 80)
        case .tetrastichous:
            target = .single
            targetSize = CGSize(width: SCREENW - 20, height: 80)
        }
        
        self.defLayout = target
        self.collectionView.collectionViewLayout = FlowLayoutManager.shared.makeFlowLayout(itemSize: targetSize)
    }

}

// MARK: UICollectionViewDataSource，UICollectionViewDelegate，UICollectionViewDelegateFlowLayout
extension BroveMainVC: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? tableDataList.count : collectionDataList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BroveMainCell.self), for: indexPath) as? BroveMainCell
    
        if indexPath.section == 0 {
            cell?.nameStr = self.tableDataList[indexPath.item].name
        } else {
            cell?.nameStr = self.collectionDataList[indexPath.item].name
        }
    
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        if indexPath.section == 0 {
            let model = self.tableDataList[indexPath.item]
            BroveRouterManager.shared.toTargetVC(model.key, name: model.name)
        } else {
            let model = self.collectionDataList[indexPath.item]
            if model.key == "B-C-0" {
                let manager = PopMenuManager.default
                manager.actions = [
                    PopMenuDefaultAction(title: "CrossFade", image: UIImage(systemName: "line.3.crossed.swirl.circle.fill"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)),
                    PopMenuDefaultAction(title: "Cube", image: UIImage(systemName: "shippingbox.fill"), color: #colorLiteral(red: 0.9816910625, green: 0.5655395389, blue: 0.4352460504, alpha: 1)),
                    PopMenuDefaultAction(title: "Linear", image: UIImage(systemName: "pencil.and.outline"), color: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)),
                    PopMenuDefaultAction(title: "Page", image: UIImage(systemName: "figure.walk.motion"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)),
                    PopMenuDefaultAction(title: "Parallax", image: UIImage(systemName: "paragraphsign"), color: #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)),
                    PopMenuDefaultAction(title: "RotateInOut", image: UIImage(systemName: "crop.rotate"), color: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)),
                    PopMenuDefaultAction(title: "SnapIn", image: UIImage(systemName: "link.circle.fill"), color: #colorLiteral(red: 0.9816910625, green: 0.5655395389, blue: 0.4352460504, alpha: 1)),
                    PopMenuDefaultAction(title: "ZoomInOut", image: UIImage(systemName: "fan.oscillation"), color: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)),
                ]
                manager.popMenuAppearance.popMenuFont = UIFont(name: "AvenirNext-DemiBold", size: 16)!
                manager.popMenuAppearance.popMenuBackgroundStyle = .blurred(.light)
                manager.popMenuShouldDismissOnSelection = true
                manager.popMenuDelegate = self
                manager.present()
            } else {
                BroveRouterManager.shared.toTargetVC(model.key, name: model.name)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: UICollectionReusableView.self), for: indexPath)
            
            let value = indexPath.section == 0 ? "UITableView" : "UICollectionView"
            let nameLabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: SCREENW, height: 50), bgColor: .white, text: value, textColor: .systemBrown, font: UIFont(font: .georgiaItalic, size: 18.0)!, aligment: .center, lines: 0, radius: 0)
            header.addSubview(nameLabel)
            
            return header
        } else {
            let footer: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: UICollectionReusableView.self), for: indexPath)
            footer.backgroundColor = .clear
            
            return footer
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: SCREENW, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: SCREENW, height: section == 1 ? SoftHeight : CGFLOAT_MIN)
    }
}

// MARK: PopMenuViewControllerDelegate
extension BroveMainVC: PopMenuViewControllerDelegate {
    func popMenuDidSelectItem(_ popMenuViewController: PopMenuViewController, at index: Int) {
        let list = ["CrossFade","Cube","Linear","Page","Parallax","RotateInOut","SnapIn","ZoomInOut"]
        
        let vc = CollectionViewLayoutVC()
        vc.title = list[index] + "AttributesAnimator"
        vc.index = index
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
