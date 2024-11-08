//
//  DeltaMainVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import FLEX
import HandyJSON
import SFServiceKit

class DeltaMainVC: BaseCollectionViewController {
    
    let list = [
        ["name": "字体", "type": "Font"],
        ["name": "颜色", "type": "Color", "key": "D-1"],
        ["name": "文字", "type": "Label", "key": "D-2"],
        ["name": "按钮", "type": "Button", "key": "D-3"],
        ["name": "图片", "type": "Image", "key": "D-4"],
        ["name": "进度条", "type": "Slider", "key": "D-5"],
        ["name": "开关", "type": "Switch", "key": "D-6"],
        ["name": "视图", "type": "View", "key": "D-7"],
        ["name": "图表", "type": "Charts", "key": "D-8"],
        ["name": "菜单", "type": "Menu", "key": "D-9"],
        ["name": "选择器", "type": "Picker", "key": "D-10"],
        ["name": "动画", "type": "Animator", "key": "D-11"],
    ] as [[String: Any]]
    
    var dataList: [DeltaMainModel] = []
    var defLayout: FlowLayoutType = .triserial

    override func viewDidLoad() {
        super.viewDidLoad()

        let leftImg = SFSymbolManager.shared.symbol(systemName: "ladybug.fill", withConfiguration: nil, withTintColor: .systemTeal)
        let rightImg = SFSymbolManager.shared.symbol(systemName: "switch.2", withConfiguration: nil, withTintColor: .systemTeal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftImg!, style: .plain, target: self, action: #selector(leftTap(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImg!, style: .plain, target: self, action: #selector(rightTap(_:)))
        
        self.collectionView?.register(DeltaMainCell.self, forCellWithReuseIdentifier: String(describing: DeltaMainCell.self))
        self.collectionView?.register(DeltaMainCell.self, forCellWithReuseIdentifier: "TriserialCell")
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        
        for (_, item) in list.enumerated() {
            let dic = item as [String: Any]
            let model = JSONDeserializer<DeltaMainModel>.deserializeFrom(dict: dic)
            dataList.append(model!)
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
        var target: FlowLayoutType = .triserial
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
        self.collectionView.reloadData()
    }

}


// MARK: UICollectionViewDataSource，UICollectionViewDelegate，UICollectionViewDelegateFlowLayout
extension DeltaMainVC: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.defLayout == .triserial { // 防止因复用导致显示问题
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TriserialCell", for: indexPath) as? DeltaMainCell
        
            let model = self.dataList[indexPath.item]
            cell?.loadData(model, type: self.defLayout)
        
            return cell!
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DeltaMainCell.self), for: indexPath) as? DeltaMainCell
        
            let model = self.dataList[indexPath.item]
            cell?.loadData(model, type: self.defLayout)
        
            return cell!
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        let model = self.dataList[indexPath.item]
        
        let vc = DeltaSubVC(collectionViewLayout: FlowLayoutManager.shared.makeFlowLayout(itemSize: CGSize(width: (SCREENW - 30) / 2, height: 60)))
        vc.itemType = model.type
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: UICollectionReusableView.self), for: indexPath)
            
            return header
        } else {
            let footer: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: UICollectionReusableView.self), for: indexPath)
            footer.backgroundColor = .clear
            
            return footer
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: SCREENW, height: CGFLOAT_MIN)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: SCREENW, height: SoftHeight)
    }
}
