//
//  ChineseColorsVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/18.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class ChineseColorsVC: BaseViewController {
    
    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    
    var dataList:[ChineseColorModel] = []
    /// 是否是常用色
    var isCommon:Bool = true
    
    var arr1 = [
        ["name": "文字", "hex": "#222222"],
        ["name": "文字",   "hex": "#AFB3BF"],
        ["name": "文字",   "hex": "#C4CBDE"],
        ["name": "背景",   "hex": "#FFC800"],
        
        ["name": "背景", "hex": "#F5F6F9"],
        ["name": "背景",   "hex": "#F9FAFC"],
        ["name": "背景",   "hex": "#F5F5F9"],
        ["name": "背景", "hex": "#FFF2EB"],
        
        ["name": "分割线",   "hex": "#EDEFF0"],
        ["name": "主题&点缀",   "hex": "#008AFF"],
        ["name": "主题&点缀",   "hex": "#E7F4FF"],
        ["name": "主题&点缀",   "hex": "#32D2FF"],
        
        ["name": "正误", "hex": "#62CA00"],
        ["name": "正误",   "hex": "#DFFADC"],
        ["name": "正误",   "hex": "#FF2E00"],
        ["name": "正误",   "hex": "#FFE6E0"],
        
        ["name": "金额&拼团", "hex": "#FF3B00"],
        ["name": "金额&拼团",   "hex": "#FF5200"],
        ["name": "提示",   "hex": "#FFAF00"],
        ["name": "提示",   "hex": "#FFFAC8"],
        
        ["name": "异常&评论", "hex": "#FF7800"],
        ["name": "异常&评论",   "hex": "#FFF6E3"],
        ["name": "完成&预约",   "hex": "#15D25F"],
        ["name": "完成&预约",   "hex": "#E6FFF0"],
    ]
    
    var arr2 = [
        ["name": "丁香色", "hex": "#cca4e3"],
        ["name": "雪青",   "hex": "#b0a4e3"],
        ["name": "群青",   "hex": "#4c8dae"],
        ["name": "紫棠",   "hex": "#56004f"],
        
        ["name": "绀青",   "hex": "#003371"],
        ["name": "紫檀",   "hex": "#4c221b"],
        ["name": "酱紫",   "hex": "#815476"],
        ["name": "紫酱",   "hex": "#815463"],
        
        ["name": "紫色",   "hex": "#8d4bbb"],
        ["name": "黛紫",   "hex": "#574266"],
        ["name": "黛蓝",   "hex": "#425066"],
        ["name": "黛绿",   "hex": "#426666"],
        
        ["name": "黛",     "hex": "#4a4266"],
        ["name": "藏蓝",   "hex": "#3b2e7e"],
        ["name": "藏青",   "hex": "#2e4e7e"],
        ["name": "蓝灰",   "hex": "#a1afc9"],
        
        ["name": "宝蓝",   "hex": "#4b5cc4"],
        ["name": "花青",   "hex": "#003472"],
        ["name": "靛蓝",   "hex": "#065279"],
        ["name": "靛青",   "hex": "#177cb0"],
        
        ["name": "石青",   "hex": "#1685a9"],
        ["name": "碧蓝",   "hex": "#3eede7"],
        ["name": "蓝",     "hex": "#44cef6"],
        ["name": "蔚蓝",   "hex": "#70f3ff"],
        
        ["name": "玄色",   "hex": "#622a1d"],
        ["name": "栗色",   "hex": "#60281e"],
        ["name": "胭脂",   "hex": "#9d2933"],
        ["name": "赤",     "hex": "#c3272b"],
        
        ["name": "银朱",   "hex": "#bf242a"],
        ["name": "赫赤",   "hex": "#c91f37"],
        ["name": "殷红",   "hex": "#be002f"],
        ["name": "枣红",   "hex": "#c32136"],
        
        ["name": "洋红",   "hex": "#ff0097"],
        ["name": "嫣红",   "hex": "#ef7a82"],
        ["name": "檀",     "hex": "#b36d61"],
        ["name": "绾",     "hex": "#a98175"],
        
        ["name": "茜色",   "hex": "#cb3a56"],
        ["name": "炎",     "hex": "#ff3300"],
        ["name": "酡红",   "hex": "#dc3023"],
        ["name": "彤",     "hex": "#f35336"],
        
        ["name": "丹",     "hex": "#ff4e20"],
        ["name": "朱红",   "hex": "#ff4c00"],
        ["name": "绯红",   "hex": "#c83c23"],
        
        ["name": "绛紫",   "hex": "#8c4356"],
        ["name": "石榴红", "hex": "#f20c00"],
        ["name": "大红",   "hex": "#ff2121"],
        ["name": "银红",   "hex": "#f05654"],
        
        ["name": "酡颜",   "hex": "#f9906f"],
        ["name": "樱桃色", "hex": "#c93756"],
        ["name": "海棠红", "hex": "#db5a6b"],
        ["name": "桃红",   "hex": "#f47983"],
        
        ["name": "粉红",   "hex": "#ffb3a7"],
        ["name": "品红",   "hex": "#f00056"],
        ["name": "洋红",   "hex": "#ff4777"],
        ["name": "妃色",   "hex": "#ed5736"],
        
        ["name": "朱膘",   "hex": "#f36838"],
        ["name": "火红",   "hex": "#ff2d51"],
        ["name": "朱砂",   "hex": "#ff461f"],
        ["name": "酒红",   "hex": "#f04155"],
        
        ["name": "黯",    "hex": "#41555d"],
        ["name": "鸦青",   "hex": "#424c50"],
        ["name": "墨色",   "hex": "#50616d"],
        ["name": "墨灰",   "hex": "#758a99"],
        
        ["name": "竹青",   "hex": "#789262"],
        ["name": "铜绿",   "hex": "#549688"],
        ["name": "青碧",   "hex": "#48c0a3"],
        ["name": "碧色",   "hex": "#1bd1a5"],
        
        ["name": "石青",   "hex": "#7bcfa6"],
        ["name": "艾绿",   "hex": "#a4e2c6"],
        ["name": "缥",     "hex": "#7fecad"],
        ["name": "玉色",   "hex": "#2edfa3"],
        
        ["name": "碧绿",   "hex": "#2add9c"],
        ["name": "翡翠色", "hex": "#3de1ad"],
        ["name": "青色",   "hex": "#00e09e"],
        ["name": "青翠",   "hex": "#00e079"],
        
        ["name": "草绿",   "hex": "#40de5a"],
        ["name": "绿色",   "hex": "#00e500"],
        ["name": "绿沈",   "hex": "#0c8918"],
        ["name": "松花绿",  "hex": "#057748"],
        
        ["name": "松柏绿",  "hex": "#21a675"],
        ["name": "石绿",   "hex": "#16a951"],
        ["name": "青葱",   "hex": "#0aa344"],
        ["name": "葱青",   "hex": "#0eb83a"],
        
        ["name": "葱绿",   "hex": "#9ed900"],
        ["name": "油绿",   "hex": "#00bc12"],
        ["name": "豆青",   "hex": "#96ce54"],
        ["name": "豆绿",   "hex": "#9ed048"],

        ["name": "葱黄",   "hex": "#a3d900"],
        ["name": "柳绿",   "hex": "#afdd22"],
        ["name": "嫩绿",   "hex": "#bddd22"],
        
        ["name": "嫩黄",   "hex": "#c9dd22"],
        ["name": "松花色",  "hex": "#bce672"],
        ["name": "赭石",   "hex": "#845a33"],
        ["name": "赭色",   "hex": "#955539"],
        
        ["name": "棕黑",   "hex": "#7c4b00"],
        ["name": "褐色",   "hex": "#6e511e"],
        ["name": "棕绿",   "hex": "#827100"],
        ["name": "秋色",   "hex": "#896c39"],
        
        ["name": "驼色",   "hex": "#a88462"],
        ["name": "赭",     "hex": "#9c5333"],
        ["name": "棕红",   "hex": "#9b4400"],
        ["name": "茶色",   "hex": "#b35c44"],
        
        ["name": "棕色",   "hex": "#b25d25"],
        ["name": "琥珀",   "hex": "#ca6924"],
        ["name": "棕黄",   "hex": "#ae7000"],
        ["name": "昏黄",   "hex": "#c89b40"],
        
        ["name": "乌金",   "hex": "#a78e44"],
        ["name": "黄栌",   "hex": "#e29c45"],
        ["name": "枯黄",   "hex": "#d3b17d"],
        ["name": "牙色",   "hex": "#eedeb0"],
        
        ["name": "金色",   "hex": "#eacd76"],
        ["name": "秋香色",  "hex": "#d9b611"],
        ["name": "雄黄",   "hex": "#e9bb1d"],
        ["name": "缃色",   "hex": "#f0c239"],
        
        ["name": "赤金",   "hex": "#f2be45"],
        ["name": "雌黄",   "hex": "#ffc64b"],
        ["name": "姜黄",   "hex": "#ffc773"],
        ["name": "藤黄",   "hex": "#ffb61e"],
        
        ["name": "橘红",   "hex": "#ff7500"],
        ["name": "橘黄",   "hex": "#ff8936"],
        ["name": "杏红",   "hex": "#ff8c31"],
        ["name": "橙色",   "hex": "#fa8c35"],
        
        ["name": "橙黄",   "hex": "#ffa400"],
        ["name": "杏黄",   "hex": "#ffa631"],
        ["name": "鸭黄",   "hex": "#faff72"],
        ["name": "鹅黄",   "hex": "#fff143"],
        
        ["name": "樱草色",  "hex": "#eaff56"],
        ["name": "黑色",   "hex": "#000000"],
        ["name": "漆黑",   "hex": "#161823"],
        ["name": "煤黑",   "hex": "#312520"],
        
        ["name": "缁色",   "hex": "#493131"],
        ["name": "黝黑",   "hex": "#665757"],
        ["name": "黧",     "hex": "#5d513c"],
        ["name": "黎",     "hex": "#75664d"],
        
        ["name": "乌黑",   "hex": "#392f41"],
        ["name": "玄青",   "hex": "#3d3b4f"],
        ["name": "乌色",   "hex": "#725e82"],
        ["name": "黝",     "hex": "#6b6882"],
        
        ["name": "水色",   "hex": "#88ada6"],
        ["name": "苍色",   "hex": "#75878a"],
        ["name": "灰色",   "hex": "#808080"],
        ["name": "老银",   "hex": "#bacac6"],
        
        ["name": "花白",   "hex": "#c2ccd0"],
        ["name": "蟹壳青",  "hex": "#bbcdc5"],
        ["name": "青白",   "hex": "#c0ebd7"],
        ["name": "素",     "hex": "#e0f0e9"],
        
        ["name": "鸭卵青",   "hex": "#e0eee8"],
        ["name": "茶白",     "hex": "#f3f9f1"],
        ["name": "藕荷色",   "hex": "#e4c6d0"],
        ["name": "藕色",     "hex": "#edd1d8"],
        
        ["name": "白粉",      "hex": "#fff2df"],
        ["name": "鱼肚白",    "hex": "#fcefe8"],
        ["name": "缟",        "hex": "#f2ecde"],
        ["name": "象牙白",    "hex": "#fffbf0"],
        
        ["name": "月白",      "hex": "#d6ecf0"],
        ["name": "莹白",      "hex": "#e3f9fd"],
        ["name": "雪白",      "hex": "#f0fcff"],
        ["name": "霜色",      "hex": "#e9f1f6"],
        
        ["name": "铅白",      "hex": "#f0f0f4"],
        ["name": "银白",      "hex": "#e9e7ef"],
        ["name": "精白",      "hex": "#ffffff"],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(collectionView)
        
        let list = isCommon ? arr1 : arr2
        
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

extension ChineseColorsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
extension ChineseColorsVC: JXPagingViewListViewDelegate {
    
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
