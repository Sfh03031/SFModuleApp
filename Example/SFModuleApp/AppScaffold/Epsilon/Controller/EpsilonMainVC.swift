//
//  EpsilonMainVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/11/5.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import FLEX
import HandyJSON
import JohnWick
import SFServiceKit

class EpsilonMainVC: BaseCollectionViewController {
    
    let list = [
        ["name": "JohnWick", "Abbreviation": "JW", "path": "https://github.com/Sfh03031/JohnWick"],
        ["name": "SFStyleKit", "Abbreviation": "Style", "path": "https://github.com/Sfh03031/SFStyleKit"],
        ["name": "SFServiceKit", "Abbreviation": "Service", "path": "https://github.com/Sfh03031/SFServiceKit"],
        ["name": "SFNetworkManager", "Abbreviation": "Network", "path": "https://github.com/Sfh03031/SFNetworkManager"],
        ["name": "SFNetworkMonitor", "Abbreviation": "Monitor", "path": "https://github.com/Sfh03031/SFNetworkMonitor"],
        ["name": "SFCircleProgressView", "Abbreviation": "Progress", "path": "https://github.com/Sfh03031/SFCircleProgressView"],
        ["name": "LottieService", "Abbreviation": "Lottie+", "path": "https://github.com/Sfh03031/LottieService"],
        ["name": "DynamicAppIcon", "Abbreviation": "Dynamic", "path": "https://github.com/Sfh03031/DynamicAppIcon"]
    ]
    
    var dataList: [EpsilonMainModel] = []
    var defLayout: FlowLayoutType = .single

    override func viewDidLoad() {
        super.viewDidLoad()

        let img = SFSymbolManager.shared.symbol(systemName: "ladybug.fill", withConfiguration: nil, withTintColor: .systemTeal)
        let rightImg = SFSymbolManager.shared.symbol(systemName: "switch.2", withConfiguration: nil, withTintColor: .systemTeal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: img!, style: .plain, target: self, action: #selector(leftTap(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImg!, style: .plain, target: self, action: #selector(rightTap(_:)))

        self.collectionView?.register(EpsilonMainCell.self, forCellWithReuseIdentifier: String(describing: EpsilonMainCell.self))
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        
        for (_, item) in list.enumerated() {
            let dic = item as [String: Any]
            let model = JSONDeserializer<EpsilonMainModel>.deserializeFrom(dict: dic)
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
        self.collectionView.reloadData()
    }

}

// MARK: UICollectionViewDataSource，UICollectionViewDelegate，UICollectionViewDelegateFlowLayout
extension EpsilonMainVC: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EpsilonMainCell.self), for: indexPath) as? EpsilonMainCell
    
        cell?.nameStr = self.defLayout == .triserial ? self.dataList[indexPath.item].Abbreviation :  self.dataList[indexPath.item].name
    
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        let path = self.dataList[indexPath.item].path
        
        let vc = SFWebViewVC()
        vc.url = URL(string: path)
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .flipHorizontal
        self.present(nav, animated: true)
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
