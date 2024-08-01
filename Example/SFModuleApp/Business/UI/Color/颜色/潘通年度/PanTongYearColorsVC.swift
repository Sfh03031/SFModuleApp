//
//  PanTongYearColorsVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/18.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class PanTongYearColorsVC: BaseViewController {

    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    
    var dataList:[ChineseColorModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(collectionView)
        
        let list = [
            ["name": "柔和桃",   "hex": "#FFBE98", "year": "2024"],
            ["name": "非凡洋红", "hex": "#BE3455", "year": "2023"],
            ["name": "长春花蓝", "hex": "#6667AB", "year": "2022"],
            ["name": "明亮黄",   "hex": "#F5DF4D", "year": "2021"],
            
            ["name": "极致灰",   "hex": "#939597", "year": "2021"],
            ["name": "经典蓝",   "hex": "#0F4C81", "year": "2020"],
            ["name": "珊瑚橙",   "hex": "#FF6F61", "year": "2019"],
            ["name": "紫外光",   "hex": "#5F4B8B", "year": "2018"],
            
            ["name": "草木绿",   "hex": "#88B04B", "year": "2017"],
            ["name": "水晶粉",   "hex": "#F7CAC9", "year": "2016"],
            ["name": "宁静蓝",   "hex": "#92A8D1", "year": "2016"],
            ["name": "玛萨拉酒红",   "hex": "#955251", "year": "2015"],
            
            ["name": "璀璨紫兰花",   "hex": "#B565A7", "year": "2014"],
            ["name": "翡翠绿",   "hex": "#009B77", "year": "2013"],
            ["name": "探戈橘",   "hex": "#E2492F", "year": "2012"],
            ["name": "忍冬红",   "hex": "#CB6586", "year": "2011"],
            
            ["name": "松石绿",   "hex": "#45B5AA", "year": "2010"],
            ["name": "含羞草黄",   "hex": "#F0C05A", "year": "2009"],
            ["name": "鸢尾蓝",   "hex": "#5A5B9F", "year": "2008"],
            ["name": "辣椒红",   "hex": "#9B1B30", "year": "2007"],
            
            ["name": "沙色金",   "hex": "#DECDBE", "year": "2006"],
            ["name": "虎皮百合",   "hex": "#53B0AE", "year": "2005"],
            ["name": "蓝色绿松石",   "hex": "#E2583E", "year": "2004"],
            ["name": "水色天空",   "hex": "#7BC4C4", "year": "2003"],
            
            ["name": "真实红",   "hex": "#BF1932", "year": "2002"],
            ["name": "桃色玫瑰色",   "hex": "#C74375", "year": "2001"],
            ["name": "蔚蓝",   "hex": "#98B2D1", "year": "2000"],
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
        flowLayout.itemSize = CGSizeMake((SCREENW - 30)/2, 120)
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

extension PanTongYearColorsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
extension PanTongYearColorsVC: JXPagingViewListViewDelegate {
    
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
