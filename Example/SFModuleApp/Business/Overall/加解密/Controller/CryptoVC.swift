//
//  CryptoVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/11/4.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import HandyJSON
import JohnWick

class CryptoVC: BaseCollectionViewController {
    
    var list = [
        ["name": "相关文章", "path": "https://blog.51cto.com/u_14273/9840611", "key": "Crypto-0"],
        ["name": "资源链接加解密", "path": "", "key": "Crypto-1"],
        ["name": "本地资源加解密", "path": "", "key": "Crypto-2"],
    ]
    var dataList: [CryptoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.register(CryptoCell.self, forCellWithReuseIdentifier: String(describing: CryptoCell.self))
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        
        for (_, item) in list.enumerated() {
            let dic = item as [String: Any]
            let model = JSONDeserializer<CryptoModel>.deserializeFrom(dict: dic)
            dataList.append(model!)
        }
        
        self.collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.collectionView.frame = CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - BottomHeight)
    }

}

// MARK: UICollectionViewDataSource，UICollectionViewDelegate，UICollectionViewDelegateFlowLayout
extension CryptoVC: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CryptoCell.self), for: indexPath) as? CryptoCell
    
        cell?.nameStr = self.dataList[indexPath.item].name
    
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        let model = self.dataList[indexPath.item]
        
        switch model.key {
        case "Crypto-0":
            let vc = SFWebViewVC()
            vc.url = URL(string: model.path)
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
            break
        case "Crypto-1":
            let vc = CryptoExampleVC()
            vc.title = model.name
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case "Crypto-2":
            let vc = CryptoLocalExampleVC()
            vc.title = model.name
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
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
