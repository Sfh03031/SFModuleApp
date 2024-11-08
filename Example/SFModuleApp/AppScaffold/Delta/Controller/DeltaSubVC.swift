//
//  DeltaSubVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/25.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import HandyJSON
import SFServiceKit

class DeltaSubVC: BaseCollectionViewController {
    
    var defLayout: FlowLayoutType = .twice
    var dataList: [DeltaMainModel] = []
    
    var itemType: String = "" {
        didSet {
            self.title = itemType
            checkData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let rightImg = SFSymbolManager.shared.symbol(systemName: "switch.2", withConfiguration: nil, withTintColor: .systemTeal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImg!, style: .plain, target: self, action: #selector(rightTap(_:)))
        self.collectionView?.register(DeltaSubCell.self, forCellWithReuseIdentifier: String(describing: DeltaSubCell.self))
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: UICollectionReusableView.self))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.collectionView.frame = CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight)
    }
    
    @objc func rightTap(_ sender: UIBarButtonItem) {
        var target: FlowLayoutType = .single
        var targetSize = CGSize(width: SCREENW - 20, height: 60)
        switch self.defLayout {
        case .single:
            target = .twice
            targetSize = CGSize(width: (SCREENW - 30) / 2, height: 60)
        case .twice:
//            target = .triserial
//            targetSize = CGSize(width: (SCREENW - 40) / 3, height: 120)
            target = .single
            targetSize = CGSize(width: SCREENW - 20, height: 60)
        case .triserial:
            target = .single
            targetSize = CGSize(width: SCREENW - 20, height: 60)
        case .tetrastichous:
            target = .single
            targetSize = CGSize(width: SCREENW - 20, height: 60)
        }
        
        self.defLayout = target
        self.collectionView.collectionViewLayout = FlowLayoutManager.shared.makeFlowLayout(itemSize: targetSize)
        self.collectionView.reloadData()
    }

    func checkData() {
        var list: [[String: Any]] = []
        
        switch itemType {
        case "Font":
            list = [
                ["name": "字体枚举", "type": "75", "key": "D-Font-0"],
                ["name": "载入定制字体", "type": "27", "key": "D-Font-1"],
            ]
            break
        case "Color":
            list = [
                ["name": "常用色", "type": "4", "key": "D-Color-0"],
                ["name": "中国色彩", "type": "4", "key": "D-Color-1"],
                ["name": "潘通年度", "type": "4", "key": "D-Color-2"],
                ["name": "渐变色彩", "type": "4", "key": "D-Color-3"],
                ["name": "色彩搭配", "type": "4", "key": "D-Color-4"],
            ]
            break
        case "View":
            list = [
                ["name": "刮刮乐", "type": "9", "key": "D-View-0"],
                ["name": "星星评分", "type": "10", "key": "D-View-1"],
                ["name": "闪烁", "type": "18", "key": "D-View-2"],
                ["name": "加载指示器", "type": "20", "key": "D-View-3"],
                ["name": "钻石闪耀", "type": "37", "key": "D-View-4"],
                ["name": "时间卡尺", "type": "51", "key": "D-View-5"],
                ["name": "时间线", "type": "52", "key": "D-View-6"],
                ["name": "多标签", "type": "59", "key": "D-View-7"],
                ["name": "雷达波", "type": "60", "key": "D-View-8"],
                ["name": "水波浪", "type": "61", "key": "D-View-9"],
                ["name": "渐变加载条", "type": "62", "key": "D-View-10"],
                ["name": "数字变形", "type": "63", "key": "D-View-11"],
                ["name": "五彩纸屑", "type": "64", "key": "D-View-12"],
                ["name": "高斯模糊", "type": "65", "key": "D-View-13"],
                ["name": "脉冲动画", "type": "66", "key": "D-View-14"],
                ["name": "弹出提示", "type": "68", "key": "D-View-15"],
                ["name": "分段进度", "type": "69", "key": "D-View-16"],
            ]
            break
        case "Button":
            list = [
                ["name": "一键三连", "type": "53", "key": "D-Button-0"],
                ["name": "流体浮动", "type": "54", "key": "D-Button-1"],
                ["name": "悬浮", "type": "55", "key": "D-Button-2"],
                ["name": "登录", "type": "56", "key": "D-Button-3"],
                ["name": "转场动效", "type": "57", "key": "D-Button-4"],
            ]
            break
        case "Label":
            list = [
                ["name": "滚动", "type": "15", "key": "D-Label-0"],
                ["name": "变形", "type": "24", "key": "D-Label-1"],
                ["name": "翻转", "type": "25", "key": "D-Label-2"],
                ["name": "混合", "type": "26", "key": "D-Label-3"],
                ["name": "标签", "type": "29", "key": "D-Label-4"],
                ["name": "倒计时", "type": "30", "key": "D-Label-5"],
                ["name": "展开收起", "type": "31", "key": "D-Label-6"],
            ]
            break
        case "Image":
            list = [
                ["name": "加载gif图", "type": "11", "key": "D-Image-0"],
            ]
            break
        case "Slider":
            list = [
                ["name": "气泡进度", "type": "22", "key": "D-Slider-0"],
                ["name": "环形进度", "type": "70", "key": "D-Slider-1"],
            ]
            break
        case "Switch":
            list = [
                ["name": "开关特效", "type": "67", "key": "D-Switch-0"],
            ]
            break
        case "Charts":
            list = [
                ["name": "学习数据", "type": "5", "key": "D-Charts-0"],
                ["name": "电子表格", "type": "17", "key": "D-Charts-1"],
                ["name": "图表", "type": "21", "key": "D-Charts-2"],
            ]
            break
        case "Menu":
            list = [
                ["name": "弹窗菜单", "type": "8", "key": "D-Menu-0"],
                ["name": "环形菜单", "type": "58", "key": "D-Menu-1"],
            ]
            break
        case "Animator":
            list = [
                ["name": "UI动画", "type": "14", "key": "D-Animator-0"],
            ]
            break
        case "Picker":
            list = [
                ["name": "文件选择器", "type": "76", "key": "D-Picker-0"],
                ["name": "地址选择器", "type": "77", "key": "D-Picker-1"],
                ["name": "日期选择器", "type": "78", "key": "D-Picker-2"],
                ["name": "标签选择器", "type": "79", "key": "D-Picker-3"],
                ["name": "自定选择器", "type": "80", "key": "D-Picker-4"],
            ]
            break
        default:
            break
        }
        
        for (_, item) in list.enumerated() {
            let dic = item as [String: Any]
            let model = JSONDeserializer<DeltaMainModel>.deserializeFrom(dict: dic)
            dataList.append(model!)
        }
        self.collectionView.reloadData()
    }

}

// MARK: UICollectionViewDataSource，UICollectionViewDelegate，UICollectionViewDelegateFlowLayout
extension DeltaSubVC: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DeltaSubCell.self), for: indexPath) as? DeltaSubCell
    
        let model = self.dataList[indexPath.item]
        cell?.loadData(model, indexPath: indexPath)
    
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        let model = self.dataList[indexPath.item]
        DeltaRouterManager.shared.toTargetVC(model.key, name: model.name)
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
