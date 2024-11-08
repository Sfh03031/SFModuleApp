//
//  GradientColorVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/11/6.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import HandyJSON
import SFServiceKit

class GradientColorVC: BaseCollectionViewController {
    
    var defLayout: FlowLayoutType = .twice
    var dataList: [GradientColorModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightImg = SFSymbolManager.shared.symbol(systemName: "switch.2", withConfiguration: nil, withTintColor: .systemTeal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImg!, style: .plain, target: self, action: #selector(rightTap(_:)))

        self.collectionView?.register(GradientColorCell.self, forCellWithReuseIdentifier: String(describing: GradientColorCell.self))
        self.collectionView?.register(GradientColorCell.self, forCellWithReuseIdentifier: "GradientColorCellTwice")
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        
        for (_, item) in gradientColor.enumerated() {
            let dic = item as [String: Any]
            let model = JSONDeserializer<GradientColorModel>.deserializeFrom(dict: dic)
            dataList.append(model!)
        }
        
        self.collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.collectionView.frame = CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight)
    }
    
    @objc func rightTap(_ sender: UIBarButtonItem) {
        var target: FlowLayoutType = .single
        var targetSize = CGSize(width: SCREENW - 20, height: 120)
        switch self.defLayout {
        case .single:
            target = .twice
            targetSize = CGSize(width: (SCREENW - 30) / 2, height: 120)
        case .twice:
//            target = .triserial
//            targetSize = CGSize(width: (SCREENW - 40) / 3, height: 120)
            target = .single
            targetSize = CGSize(width: SCREENW - 20, height: 120)
        case .triserial:
            target = .single
            targetSize = CGSize(width: SCREENW - 20, height: 120)
        case .tetrastichous:
            target = .single
            targetSize = CGSize(width: SCREENW - 20, height: 120)
        }
        
        self.defLayout = target
        self.collectionView.collectionViewLayout = FlowLayoutManager.shared.makeFlowLayout(itemSize: targetSize)
        self.collectionView.reloadData()
    }

}

// MARK: UICollectionViewDataSource，UICollectionViewDelegate，UICollectionViewDelegateFlowLayout
extension GradientColorVC: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.defLayout == .single {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GradientColorCell.self), for: indexPath) as? GradientColorCell
        
            cell?.defLayout = self.defLayout
            cell?.loadData(self.dataList[indexPath.item], indexPath: indexPath)
        
            return cell!
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GradientColorCellTwice", for: indexPath) as? GradientColorCell
        
            cell?.defLayout = self.defLayout
            cell?.loadData(self.dataList[indexPath.item], indexPath: indexPath)
        
            return cell!
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
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
        return CGSize(width: SCREENW, height: CGFLOAT_MIN)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: SCREENW, height: SoftHeight)
    }
}
