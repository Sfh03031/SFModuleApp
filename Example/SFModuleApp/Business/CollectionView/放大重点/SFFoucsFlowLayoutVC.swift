//
//  SFFoucsFlowLayoutVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/16.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SFFocusViewLayout

class SFFoucsFlowLayoutVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = CGRect(x: 0, y: TopHeight , width: SCREENW, height: SCREENH - TopHeight - SoftHeight)
    }
    
    //collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        
        //FIXME: SFFocusViewLayout是UICollectionViewLayout的子类，而不是UICollectionViewFlowLayout的子类，
        //FIXME: 它的cell宽度默认是与collectionView宽度一致的且无法更改，只能单列cell垂直滚动
        //FIXME: 滚动过程中一直在计算cell的位置，cell非常多的话会导致滚动不流畅，一般情况下够用了
        
        let layout = SFFocusViewLayout()
        layout.standardHeight = 100// cell默认高度
        layout.focusedHeight = 280// cell重点高度
        layout.dragOffset = 180// 触发重点的偏移量
        
        let view = UICollectionView.init(frame: CGRectZero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.sf.hexColor(hex: "#f5f6f9")
        view.decelerationRate = UIScrollView.DecelerationRate.fast//滚动衰减速率
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        //MARK: 开启了PagingEnabled，行/列间距设置为0，否则滑动cell会有偏移量
//        view.isPagingEnabled = true
        view.delegate = self
        view.dataSource = self
        view.register(AnimatedLayoutCell.self, forCellWithReuseIdentifier: NSStringFromClass(AnimatedLayoutCell.self))
        view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = .never
        }
        
        return view
    }()

}

extension SFFoucsFlowLayoutVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return Int(Int16.max)
        return 200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(AnimatedLayoutCell.self), for: indexPath) as! AnimatedLayoutCell
        
        cell.backgroundColor = UIColor.sf.random
        cell.label.text = "\(arc4random_uniform(1000))"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let focusViewLayout = collectionView.collectionViewLayout as? SFFocusViewLayout else {
            fatalError("error casting focus layout from collection view")
        }

        let offset = focusViewLayout.dragOffset * CGFloat(indexPath.item)
        if collectionView.contentOffset.y != offset {
            collectionView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSizeMake(SCREENW, 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
