//
//  AlphaMainVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/23.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import FLEX
import HandyJSON
import SFServiceKit
import ScreenRotator

class AlphaMainVC: BaseCollectionViewController {

    let list = [
        ["name": "切换服务地址", "type": "0", "key": "A-0"],
        ["name": "动态AppIcon", "type": "1", "key": "A-1"],
        ["name": "轮播", "type": "6", "key": "A-2"],
        ["name": "断网页/空白页", "type": "7", "key": "A-3"],
        ["name": "骨架屏", "type": "13", "key": "A-4"],
        ["name": "看门狗", "type": "34", "key": "A-5"],
        ["name": "新特性", "type": "39", "key": "A-6"],
        ["name": "换肤", "type": "71", "key": "A-7"],
        ["name": "后台保活", "type": "72", "key": "A-8"],
        ["name": "性能监控", "type": "73", "key": "A-9"],
        ["name": "屏幕旋转", "type": "73", "key": "A-10"],
        ["name": "AES加解密", "type": "", "key": "A-11"],
        ["name": "下载器", "type": "", "key": "A-12"],
    ] as [[String: Any]]
    
    var dataList: [AlphaMainModel] = []
    var defLayout: FlowLayoutType = .single
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        ScreenRotator.shared.isLockOrientationWhenDeviceOrientationDidChange = true
        ScreenRotator.shared.rotationToPortrait()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftImg = SFSymbolManager.shared.symbol(systemName: "ladybug.fill", withConfiguration: nil, withTintColor: .systemTeal)
        let rightImg = SFSymbolManager.shared.symbol(systemName: "switch.2", withConfiguration: nil, withTintColor: .systemTeal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftImg!, style: .plain, target: self, action: #selector(leftTap(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImg!, style: .plain, target: self, action: #selector(rightTap(_:)))
        
        self.collectionView?.register(AlphaMainCell.self, forCellWithReuseIdentifier: String(describing: AlphaMainCell.self))
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        
        for (_, item) in list.enumerated() {
            let dic = item as [String: Any]
            let model = JSONDeserializer<AlphaMainModel>.deserializeFrom(dict: dic)
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
        var target: FlowLayoutType = .single
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
extension AlphaMainVC: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AlphaMainCell.self), for: indexPath) as? AlphaMainCell
    
        cell?.nameStr = self.dataList[indexPath.item].name
    
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        let model = self.dataList[indexPath.item]
        AlphaRouterManager.shared.toTargetVC(model.key, name: model.name)
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
