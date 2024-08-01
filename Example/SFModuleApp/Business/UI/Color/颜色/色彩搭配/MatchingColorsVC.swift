//
//  MatchingColorsVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/19.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class MatchingColorsVC: BaseViewController {

    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    
    var dataList:[MatchingColorModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(collectionView)
        
        let list = [
            ["color1": "#ff5959", "color2": "#676fa3", "color3": "#cddeff", "color4": "#eef2ff"],
            ["color1": "#a0937d", "color2": "#e7d4b5", "color3": "#f6e6cb", "color4": "#e3cdc1"],
            ["color1": "#eef2f5", "color2": "#ea168e", "color3": "#612570", "color4": "#1eafed"],
            ["color1": "#139487", "color2": "#86c6f4", "color3": "#fff1ce", "color4": "#d29d2b"],
            
            ["color1": "#08d9d6", "color2": "#252a34", "color3": "#ff2e63", "color4": "#eaeaea"],
            ["color1": "#da5c53", "color2": "#a8e4b1", "color3": "#4aa3ba", "color4": "#306d75"],
            ["color1": "#535238", "color2": "#4bbb8b", "color3": "#6ddabe", "color4": "#c9ffc7"],
            ["color1": "#17139c", "color2": "#dd3e3e", "color3": "#ffe5e1", "color4": "#f2f2f2"],
            
            ["color1": "#860f44", "color2": "#bb3939", "color3": "#ea5f2d", "color4": "#eec89f"],
            ["color1": "#248888", "color2": "#e6e6e6", "color3": "#e7475e", "color4": "#f0d879"],
            ["color1": "#e0ece4", "color2": "#ff4b5c", "color3": "#056674", "color4": "#66bfbf"],
            ["color1": "#5628b4", "color2": "#d80e70", "color3": "#e7455f", "color4": "#f7b236"],
            
            ["color1": "#fcf9ea", "color2": "#badfdb", "color3": "#f8a978", "color4": "#ffc5a1"],
            ["color1": "#f1ed63", "color2": "#d97d97", "color3": "#9862ae", "color4": "#815a8f"],
            ["color1": "#e0fcff", "color2": "#bde4f4", "color3": "#404969", "color4": "#ff7f50"],
            ["color1": "#a1eafb", "color2": "#fdfdfd", "color3": "#ffcef3", "color4": "#cabbe9"],
            
            ["color1": "#191919", "color2": "#2d4263", "color3": "#c84b31", "color4": "#ecdbba"],
            ["color1": "#bdf9f7", "color2": "#93c4ff", "color3": "#b67ccf", "color4": "#765a60"],
            ["color1": "#a1eafb", "color2": "#fdfdfd", "color3": "#ffcef3", "color4": "#cabbe9"],
            ["color1": "#293462", "color2": "#216583", "color3": "#f76262", "color4": "#fff1c1"],
            
            ["color1": "#ffa0c2", "color2": "#f9f5ce", "color3": "#e3ce8b", "color4": "#9e7e44"],
            ["color1": "#ea5c2b", "color2": "#ff7f3f", "color3": "#f6d860", "color4": "#95cd41"],
            ["color1": "#ddfee4", "color2": "#28cc9e", "color3": "#196b69", "color4": "#132f2b"],
            ["color1": "#f1f3de", "color2": "#eb8f8f", "color3": "#ec0101", "color4": "#cd0a0a"],
            
            ["color1": "#2d4059", "color2": "#ea5455", "color3": "#decdc3", "color4": "#e5e5e5"],
            ["color1": "#9bcb3c", "color2": "#eff669", "color3": "#f29f3d", "color4": "#cf3333"],
            ["color1": "#FFCA28", "color2": "#F07A1E", "color3": "#D7263D", "color4": "#4A235A"],
            ["color1": "#F9A826", "color2": "#F2D7A6", "color3": "#3E4C59", "color4": "#FFCF9F"],
            
            ["color1": "#FFCF48", "color2": "#A0C544", "color3": "#4F9153", "color4": "#2A5A63"],
            ["color1": "#FFC0CB", "color2": "#FFB6C1", "color3": "#FFC9D4", "color4": "#F1A9A0"],
            ["color1": "#FFC857", "color2": "#FFE0B3", "color3": "#F9AFAF", "color4": "#9C4DCC"],
            ["color1": "#A7C5BD", "color2": "#F7E967", "color3": "#F9AEAC", "color4": "#647D8E"],
            
            ["color1": "#D2C7A3", "color2": "#7B9F80", "color3": "#4A7A5E", "color4": "#2B5A41"],
            ["color1": "#FFC3A0", "color2": "#FFAFBD", "color3": "#FFD7D3", "color4": "#F8F3E9"],
            ["color1": "#EECC99", "color2": "#F2C94C", "color3": "#A3B86C", "color4": "#5C7A29"],
            ["color1": "#D8E2DC", "color2": "#F4A7B9", "color3": "#9C8CB9", "color4": "#FFD393"],
            
            ["color1": "#F4E04D", "color2": "#FFCF7F", "color3": "#A6A6A6", "color4": "#2A2A2A"],
            ["color1": "#8A2BE2", "color2": "#FFC0CB", "color3": "#FF8C00", "color4": "#4B0082"],
            ["color1": "#FFC3A0", "color2": "#FFAFBD", "color3": "#DBDBDB", "color4": "#EAEAEA"],
            ["color1": "#F2D7EE", "color2": "#A8B2D1", "color3": "#85A3BF", "color4": "#5D8CAE"],
            
            ["color1": "#F5A9A9", "color2": "#F7D358", "color3": "#FCF3CF", "color4": "#D0E0E3"],
            ["color1": "#9F7A49", "color2": "#F7D9B9", "color3": "#D7A972", "color4": "#4F4E48"],
            ["color1": "#F7E967", "color2": "#F9D423", "color3": "#FFCD00", "color4": "#FF9E2C"],
            ["color1": "#F8B195", "color2": "#F67280", "color3": "#C06C84", "color4": "#6C5B7B"],
            
            ["color1": "#D2B4DE", "color2": "#A18FBA", "color3": "#9F7FBA", "color4": "#845F9C"],
            ["color1": "#F7F7F7", "color2": "#D2D2D2", "color3": "#A3A3A3", "color4": "#737373"],
            ["color1": "#0e2431", "color2": "#fc3a52", "color3": "#f9b248", "color4": "#e8d5b7"],
            ["color1": "#a66cff", "color2": "#9c9efe", "color3": "#afb4ff", "color4": "#b1e1ff"],
            
            ["color1": "#29c6cd", "color2": "#f6e4c4", "color3": "#fea386", "color4": "#f19584"],
            ["color1": "#f1d4d4", "color2": "#ddb6c6", "color3": "#ac8daf", "color4": "#484c7f"],
            ["color1": "#eeebdd", "color2": "#ce1212", "color3": "#810000", "color4": "#1b1717"],
            ["color1": "#80558c", "color2": "#af7ab3", "color3": "#cba0ae", "color4": "#e4d192"],
            
            ["color1": "#f6eb9a", "color2": "#5853bc", "color3": "#362391", "color4": "#1c0c59"],
            ["color1": "#8fc9ae", "color2": "#548e87", "color3": "#385b66", "color4": "#bddaa5"],
            ["color1": "#143a52", "color2": "#6e828a", "color3": "#cde3eb", "color4": "#e3eff3"],
            ["color1": "#3ec1d3", "color2": "#f6f7d7", "color3": "#ff9a00", "color4": "#ff165d"],
            
            ["color1": "#1b262c", "color2": "#0f4c75", "color3": "#3282b8", "color4": "#bbe1fa"],
            ["color1": "#691a40", "color2": "#9e3668", "color3": "#f6a9ce", "color4": "#fde3f0"],
            ["color1": "#7c203a", "color2": "#f85959", "color3": "#ff9f68", "color4": "#feff89"],
            ["color1": "#f0f0ef", "color2": "#edd690", "color3": "#b1bd5d", "color4": "#955a47"],
            
            ["color1": "#ec4646", "color2": "#663f3f", "color3": "#51c2d5", "color4": "#bbf1fa"],
            ["color1": "#865858", "color2": "#8e7f7f", "color3": "#bbbbbb", "color4": "#e2d5d5"],
            ["color1": "#364f6b", "color2": "#3fc1c9", "color3": "#f5f5f5", "color4": "#fc5185"],
            ["color1": "#2daf94", "color2": "#3ec8ac", "color3": "#4be4c5", "color4": "#c8f6ed"],
            
            ["color1": "#525252", "color2": "#414141", "color3": "#313131", "color4": "#ca3e47"],
            ["color1": "#f2cd5c", "color2": "#f2921d", "color3": "#a61f69", "color4": "#400e32"],
            ["color1": "#F6A19B", "color2": "#F9D9A9", "color3": "#FFC48C", "color4": "#FF9F80"],
            ["color1": "#F73859", "color2": "#3FBCE9", "color3": "#FFCF3F", "color4": "#A2D8F4"],
            
            ["color1": "#F2A9A3", "color2": "#FFCF8F", "color3": "#F8E2A7", "color4": "#F9D9A4"],
            ["color1": "#FFCA58", "color2": "#FF7A45", "color3": "#FF3800", "color4": "#7F3C8D"],
            ["color1": "#F7CAC9", "color2": "#A9CCE3", "color3": "#FFF2CC", "color4": "#D2B4DE"],
            ["color1": "#F1E7E0", "color2": "#A7C0CE", "color3": "#8F8F8F", "color4": "#3F48CC"],
            
            ["color1": "#F2D5B3", "color2": "#F9A722", "color3": "#F25C54", "color4": "#4A90E2"],
            ["color1": "#F6F6F6", "color2": "#A2D9CE", "color3": "#F1948A", "color4": "#F7DC6F"],
            ["color1": "#FFC857", "color2": "#F29492", "color3": "#A2D9CE", "color4": "#647D8E"],
            ["color1": "#F9A826", "color2": "#2F3A59", "color3": "#F2E9E4", "color4": "#A7C5BD"],
            
            ["color1": "#FF7F50", "color2": "#FFC0CB", "color3": "#00FFFF", "color4": "#FF0000"],
            ["color1": "#FFCF48", "color2": "#3A3A3A", "color3": "#2F7F9E", "color4": "#F2F2F2"],
            ["color1": "#F2E2C5", "color2": "#D9A6A9", "color3": "#9C8FBC", "color4": "#6F6F83"],
            ["color1": "#FFA07A", "color2": "#F08080", "color3": "#E0FFFF", "color4": "#FA8072"],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
            ["color1": "", "color2": "", "color3": "", "color4": ""],
        ]
        
        for (_, item) in list.enumerated() {
            let model = JSONDeserializer<MatchingColorModel>.deserializeFrom(dict: item)
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
        view.register(MatchingColorsCell.self, forCellWithReuseIdentifier: NSStringFromClass(MatchingColorsCell.self))
        view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = .never
        }
        return view
    }()

}

extension MatchingColorsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.listViewDidScrollCallback?(scrollView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(MatchingColorsCell.self), for: indexPath) as! MatchingColorsCell
        
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
extension MatchingColorsVC: JXPagingViewListViewDelegate {
    
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
