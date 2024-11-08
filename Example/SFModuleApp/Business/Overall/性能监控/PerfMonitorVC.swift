//
//  PerfMonitorVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/23.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import HandyJSON
import SFStyleKit
import UIFontComplete
import GDPerformanceView_Swift

class PerfMonitorVC: BaseCollectionViewController {

    let list = [
        ["name": "显示", "type": "", "key": ""],
        ["name": "隐藏", "type": "", "key": ""],
        ["name": "暂停", "type": "", "key": ""],
        ["name": "继续", "type": "", "key": ""],
        ["name": "所有信息", "type": "", "key": ""],
        ["name": "默认信息", "type": "", "key": ""],
        ["name": "暗色", "type": "", "key": ""],
        ["name": "亮色", "type": "", "key": ""],
        ["name": "自定样式", "type": "", "key": ""],
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.collectionView.frame = CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - BottomHeight)
    }
}

// MARK: UICollectionViewDataSource
extension PerfMonitorVC {
    
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
        case "显示":
            PerformanceMonitor.shared().show()
            break
        case "隐藏":
            PerformanceMonitor.shared().hide()
            break
        case "暂停":
            PerformanceMonitor.shared().pause()
            break
        case "继续":
            PerformanceMonitor.shared().start()
            break
        case "所有信息":
            PerformanceMonitor.shared().performanceViewConfigurator.options = .all
            break
        case "默认信息":
            PerformanceMonitor.shared().performanceViewConfigurator.options = .default
            break
        case "暗色":
            PerformanceMonitor.shared().performanceViewConfigurator.style = .dark
            break
        case "亮色":
            PerformanceMonitor.shared().performanceViewConfigurator.style = .light
            break
        case "自定样式":
            PerformanceMonitor.shared().performanceViewConfigurator.style = .custom(backgroundColor: .random, borderColor: .random, borderWidth: 1.0, cornerRadius: 5.0, textColor: .random, font: UIFont.init(font: .georgiaItalic, size: 8)!)
            break
        default:
            break
        }
    }
}
