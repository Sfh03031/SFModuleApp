//
//  GradientColorsVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/18.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class GradientColorsVC: BaseViewController {

    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    
    var dataList:[ChineseColorModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(collectionView)
        
        let list = [
            ["name": "橙青",   "start": "#fc5f3a", "end": "#ebc360"],
            ["name": "高贵紫",   "start": "#7514b3", "end": "#ee617c"],
            ["name": "贵族金",   "start": "#e6c75b", "end": "#f3eb64"],
            ["name": "甜甜的",   "start": "#ee674f", "end": "#f9b167"],
            
            ["name": "蜜桃橙",   "start": "#ff306a", "end": "#ff7b46"],
            ["name": "嫩木",   "start": "#38a066", "end": "#23e6c4"],
            ["name": "湖水蓝",   "start": "#4f6dee", "end": "#67bdf9"],
            ["name": "水蜜桃",   "start": "#f889cf", "end": "#fd7984"],
            
            ["name": "海洋蓝色",   "start": "#2E3192", "end": "#1bffff"],
            ["name": "乐观",   "start": "#D4145A", "end": "#FBB03B"],
            ["name": "甜美的石灰",   "start": "#009245", "end": "#FCEE21"],
            ["name": "紫色湖",   "start": "#662D8C", "end": "#ED1E79"],
            
            ["name": "新鲜的木瓜",   "start": "#ED1C24", "end": "#FCEE21"],
            ["name": "群青",   "start": "#00A8C5", "end": "#FFFF7E"],
            ["name": "桃红色糖",   "start": "#D74177", "end": "#FFE98A"],
            ["name": "柠檬毛毛雨",   "start": "#FB872B", "end": "#D9E021"],
            
            ["name": "维多利亚紫色",   "start": "#312A6C", "end": "#852D91"],
            ["name": "春天绿色",   "start": "#009E00", "end": "#FFFF96"],
            ["name": "神秘的紫红色",   "start": "#B066FE", "end": "#63E2FF"],
            ["name": "反光银",   "start": "#808080", "end": "#E6E6E6"],
            
            ["name": "霓虹灯",   "start": "#00FFA1", "end": "#00FFFF"],
            ["name": "莓果",   "start": "#8E78FF", "end": "#FC7D7B"],
            ["name": "新叶子",   "start": "#00537E", "end": "#3AA17E"],
            ["name": "棉花糖",   "start": "#FCA5F1", "end": "#B5FFFF"],
            
            ["name": "仙尘",   "start": "#D585FF", "end": "#00FFEE"],
            ["name": "泡芙桃子",   "start": "#F24645", "end": "#EBC08D"],
            ["name": "甜蜜的梦",   "start": "#3A3897", "end": "#A3A1FF"],
            ["name": "火砖",   "start": "#45145A", "end": "#FF5300"],
            
            ["name": "锻铁",   "start": "#333333", "end": "#5a5454"],
            ["name": "深海",   "start": "#4F00BC", "end": "29ABE2"],
            ["name": "沿海微风",   "start": "#00B7FF", "end": "#FFFFC7"],
            ["name": "晚上欢欣",   "start": "#93278F", "end": "#00A99D"],
        ]
        
        for (_, item) in list.enumerated() {
            let model = JSONDeserializer<ChineseColorModel>.deserializeFrom(dict: item)
            self.dataList.append(model!)
        }
        
        self.collectionView.reloadData()
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
    }

    //collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSizeMake(SCREENW - 30, 150)
        flowLayout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: SoftHeight, right: 10)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10

        let view = UICollectionView.init(frame: CGRectZero, collectionViewLayout: flowLayout)
        view.backgroundColor = UIColor.sf.hexColor(hex: "#f5f6f9")
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.register(ChineseColorCell.self, forCellWithReuseIdentifier: NSStringFromClass(ChineseColorCell.self))
        view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = .never
        }
        return view
    }()

}

extension GradientColorsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.listViewDidScrollCallback?(scrollView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ChineseColorCell.self), for: indexPath) as! ChineseColorCell
        
        cell.loadData(self.dataList[indexPath.item], indexPath: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let header:UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: SCREENW, height: 50), bgColor: .systemBackground, text: "共\(self.dataList.count)种", textColor: .label, font: UIFont.systemFont(ofSize: 16, weight: .medium), aligment: .center)
            header.addSubview(label)
            
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: SCREENW, height: 50)
    }
    
}

//MARK: - JXPagingViewListViewDelegate
extension GradientColorsVC: JXPagingViewListViewDelegate {
    
    func listView() -> UIView {
        return self.view
    }

    func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        self.listViewDidScrollCallback = callback
    }
    
    func listScrollView() -> UIScrollView {
        return self.collectionView
    }
    
    func listWillAppear() {
        print("\(self):\(#function)")
    }

    func listDidAppear() {
        print("\(self):\(#function)")
    }

    func listWillDisappear() {
        print("\(self):\(#function)")
    }

    func listDidDisappear() {
        print("\(self):\(#function)")
    }
}
