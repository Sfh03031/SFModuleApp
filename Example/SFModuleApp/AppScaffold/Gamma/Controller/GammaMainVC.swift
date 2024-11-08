//
//  GammaMainVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/11/5.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import FLEX
import HandyJSON
import SFServiceKit
import UIFontComplete

class GammaMainVC: BaseCollectionViewController {
    
    let list = [
        ["name": "照片裁剪", "type": "2", "key": "G-0"],
        ["name": "涂鸦笔记", "type": "3", "key": "G-1"],
        ["name": "二维码", "type": "12", "key": "G-2"],
        ["name": "通知栏消息", "type": "16", "key": "G-3"],
        
        ["name": "国旗", "type": "28", "key": "G-5"],
        
        ["name": "直播推流", "type": "36", "key": "G-7"],
        ["name": "热门搜索", "type": "74", "key": "G-8"],
    ]
    
    let list1 = [
        ["name": "状态栏消息", "type": "19", "key": "G-4"],
        ["name": "腾讯QMUIKit", "type": "35", "key": "G-6"],
    ]

    var dataList: [GammaMainModel] = []
    var dataList1: [GammaMainModel] = []
    var defLayout: FlowLayoutType = .twice
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let img = SFSymbolManager.shared.symbol(systemName: "ladybug.fill", withConfiguration: nil, withTintColor: .systemTeal)
        let rightImg = SFSymbolManager.shared.symbol(systemName: "switch.2", withConfiguration: nil, withTintColor: .systemTeal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: img!, style: .plain, target: self, action: #selector(leftTap(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImg!, style: .plain, target: self, action: #selector(rightTap(_:)))

        self.collectionView?.register(GammaMainCell.self, forCellWithReuseIdentifier: String(describing: GammaMainCell.self))
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        
        for (_, item) in list.enumerated() {
            let dic = item as [String: Any]
            let model = JSONDeserializer<GammaMainModel>.deserializeFrom(dict: dic)
            dataList.append(model!)
        }
        for (_, item) in list1.enumerated() {
            let dic = item as [String: Any]
            let model = JSONDeserializer<GammaMainModel>.deserializeFrom(dict: dic)
            dataList1.append(model!)
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
        var target: FlowLayoutType = .twice
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
extension GammaMainVC: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? dataList.count : dataList1.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GammaMainCell.self), for: indexPath) as? GammaMainCell
    
        if indexPath.section == 0 {
            cell?.nameStr = self.dataList[indexPath.item].name
        } else {
            cell?.nameStr = self.dataList1[indexPath.item].name
        }
    
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        let model = indexPath.section == 0 ? self.dataList[indexPath.item] : self.dataList1[indexPath.item]
        if model.key == "G-0" {
            let vc = CLCameraController()
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            GammaRouterManager.shared.toTargetVC(model.key, name: model.name)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: UICollectionReusableView.self), for: indexPath)
            
            let value = indexPath.section == 0 ? "Interesting" : "Deeplink"
            let nameLabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: SCREENW, height: 50), bgColor: .white, text: value, textColor: .systemBrown, font: UIFont(font: .georgiaItalic, size: 18.0)!, aligment: .center, lines: 0, radius: 0)
            header.addSubview(nameLabel)
            
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
        return CGSize(width: SCREENW, height: section == 1 ? SoftHeight : CGFLOAT_MIN)
    }
}

//MARK: - CLCameraControllerDelegate
extension GammaMainVC: CLCameraControllerDelegate {
    
    func cameraController(_ controller: CLCameraController, didFinishTakingPhoto photo: UIImage, data: Data) {
        let vc = CLCameraResultVC()
        vc.image = photo
        self.sf.push(vc)
        controller.presentingViewController?.dismiss(animated: true)
    }

    func cameraController(_ controller: CLCameraController, didFinishTakingVideo videoURL: URL) {
        controller.presentingViewController?.dismiss(animated: true)
    }
}
