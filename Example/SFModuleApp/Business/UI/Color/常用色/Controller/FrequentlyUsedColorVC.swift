//
//  FrequentlyUsedColorVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/11/6.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import HandyJSON
import SFServiceKit

class FrequentlyUsedColorVC: BaseCollectionViewController {

    var defLayout: FlowLayoutType = .twice
    var dataList: [FrequentlyUsedColorModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let rightImg = SFSymbolManager.shared.symbol(systemName: "switch.2", withConfiguration: nil, withTintColor: .systemTeal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImg!, style: .plain, target: self, action: #selector(rightTap(_:)))
        
        self.collectionView?.register(FrequentlyUsedColorCell.self, forCellWithReuseIdentifier: String(describing: FrequentlyUsedColorCell.self))
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        
        for (_, item) in frequentlyUsedColor.enumerated() {
            let dic = item as [String: Any]
            let model = JSONDeserializer<FrequentlyUsedColorModel>.deserializeFrom(dict: dic)
            dataList.append(model!)
        }
        
        self.collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.collectionView.frame = CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight)
    }

    @objc func rightTap(_ sender: UIBarButtonItem) {
        var target: FlowLayoutType = .triserial
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
    }
}

// MARK: UICollectionViewDataSource，UICollectionViewDelegate，UICollectionViewDelegateFlowLayout
extension FrequentlyUsedColorVC: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FrequentlyUsedColorCell.self), for: indexPath) as? FrequentlyUsedColorCell
    
        cell?.loadData(self.dataList[indexPath.item], indexPath: indexPath)
    
        return cell!
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
