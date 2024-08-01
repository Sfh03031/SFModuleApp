//
//  CarLensVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/21.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SFStyleKit
//import CarLensCollectionViewLayout

class CarLensVC: BaseViewController {

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
        //FIXME: 只支持水平滚动
        let option = CarLensCollectionViewLayoutOptions.init(minimumSpacing: 10, decelerationRate: UIScrollViewDecelerationRateFast, shouldShowScrollIndicator: false, itemSize: CGSize(width: SCREENW - 40, height: SCREENH - TopHeight - SoftHeight - 20))
        let layout = CarLensCollectionViewLayout.init(options: option)
        
        let view = UICollectionView.init(frame: CGRectZero, collectionViewLayout: layout)
        view.backgroundColor = .hex_F5F6F9
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.decelerationRate = UIScrollViewDecelerationRateFast
        //MARK: 开启了PagingEnabled，行/列间距设置为0，否则滑动cell会有偏移量
//        view.isPagingEnabled = true
        view.delegate = self
        view.dataSource = self
        view.register(CarLensCell.self, forCellWithReuseIdentifier: NSStringFromClass(CarLensCell.self))
        view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = .never
        }
        
        return view
    }()

}


extension CarLensVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(Int16.max)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(CarLensCell.self), for: indexPath) as? CarLensCell else {
            return UICollectionViewCell()
        }
        
        cell.upperView.text = "== \(indexPath.item) =="
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSizeMake(SCREENW * 0.85, (SCREENH - TopHeight - SoftHeight) * 0.85)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
    
}
