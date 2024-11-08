//
//  BgTaskVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import HandyJSON

class BgTaskVC: BaseCollectionViewController {
    
    let list = [
        ["name": "重启开启保活", "type": "", "key": ""],
        ["name": "重启关闭保活", "type": "", "key": ""],
    ] as [[String: Any]]
    
    var dataList: [AlphaMainModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.register(AlphaMainCell.self, forCellWithReuseIdentifier: String(describing: AlphaMainCell.self))
        
        for (_, item) in list.enumerated() {
            let dic = item as [String: Any]
            let model = JSONDeserializer<AlphaMainModel>.deserializeFrom(dict: dic)
            dataList.append(model!)
        }
        
        self.collectionView.reloadData()
    }

}

// MARK: UICollectionViewDataSource
extension BgTaskVC {
    
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
        let model = self.dataList[indexPath.item]
        switch model.name {
        case "重启开启保活":
            UserDefaults.standard.setValue("1", forKey: "BgTask")
            UserDefaults.standard.synchronize()
            exit(0)
            break
        case "重启关闭保活":
            UserDefaults.standard.setValue("0", forKey: "BgTask")
            UserDefaults.standard.synchronize()
            exit(0)
            break
        default:
            break
        }
    }
}
