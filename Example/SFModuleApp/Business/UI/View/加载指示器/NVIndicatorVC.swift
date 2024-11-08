//
//  NVIndicatorVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/11/7.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SFServiceKit
import NVActivityIndicatorView

class NVIndicatorVC: BaseCollectionViewController {
    
    var defLayout: FlowLayoutType = .triserial
    var dataList = NVActivityIndicatorType.allCases.filter { $0 != .blank }

    override func viewDidLoad() {
        super.viewDidLoad()

        let rightImg = SFSymbolManager.shared.symbol(systemName: "switch.2", withConfiguration: nil, withTintColor: .systemTeal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImg!, style: .plain, target: self, action: #selector(rightTap(_:)))
        self.collectionView?.register(NVIndicatorCell.self, forCellWithReuseIdentifier: String(describing: NVIndicatorCell.self))
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        
        self.collectionView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.collectionView.frame = CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight)
    }
    
    @objc func rightTap(_ sender: UIBarButtonItem) {
        var target: FlowLayoutType = .tetrastichous
        var targetSize = CGSize(width: (SCREENW - 50) / 4, height: (SCREENW - 50) / 4)
        switch self.defLayout {
        case .single:
            target = .twice
            targetSize = CGSize(width: (SCREENW - 30) / 2, height: (SCREENW - 30) / 2)
        case .twice:
            target = .triserial
            targetSize = CGSize(width: (SCREENW - 40) / 3, height: (SCREENW - 40) / 3)
        case .triserial:
            target = .tetrastichous
            targetSize = CGSize(width: (SCREENW - 50) / 4, height: (SCREENW - 50) / 4)
        case .tetrastichous:
            target = .twice
            targetSize = CGSize(width: (SCREENW - 30) / 2, height: (SCREENW - 30) / 2)
        }
        
        self.defLayout = target
        self.collectionView.collectionViewLayout = FlowLayoutManager.shared.makeFlowLayout(itemSize: targetSize)
    }

}

// MARK: UICollectionViewDataSource，UICollectionViewDelegate，UICollectionViewDelegateFlowLayout
extension NVIndicatorVC: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NVIndicatorCell.self), for: indexPath) as? NVIndicatorCell
    
        cell?.type = self.dataList[indexPath.item]
    
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: UICollectionReusableView.self), for: indexPath)
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: SCREENW, height: 50), bgColor: .systemBackground, text: "共\(self.dataList.count)种，颜色随机", textColor: UIColor.sf.random, font: UIFont.systemFont(ofSize: 16, weight: .medium), aligment: .center)
            header.addSubview(label)
            
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
        return CGSize(width: SCREENW, height: SoftHeight)
    }
}
