//
//  GravitySliderVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/21.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SFStyleKit
import GravitySliderFlowLayout

class GravitySliderVC: BaseViewController {

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
        let layout = GravitySliderFlowLayout(with: CGSize(width: SCREENW * 0.55, height: (SCREENH - TopHeight - SoftHeight) * 0.65))
        
        let view = UICollectionView.init(frame: CGRectZero, collectionViewLayout: layout)
        view.backgroundColor = .hex_F5F6F9
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.decelerationRate = UIScrollView.DecelerationRate.fast
        //MARK: 开启了PagingEnabled，行/列间距设置为0，否则滑动cell会有偏移量
//        view.isPagingEnabled = true
        view.delegate = self
        view.dataSource = self
        view.register(GravitySliderCell.self, forCellWithReuseIdentifier: NSStringFromClass(GravitySliderCell.self))
        view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = .never
        }
        
        return view
    }()

}


extension GravitySliderVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(Int16.max)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(GravitySliderCell.self), for: indexPath) as! GravitySliderCell
        
        cell.label.text = "\(indexPath.item)"
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = cell.bounds
        gradientLayer.colors = [UIColor.sf.hexColor(hex: "ff8181").cgColor, UIColor.sf.hexColor(hex: "a81382").cgColor]
        gradientLayer.cornerRadius = 21
        gradientLayer.masksToBounds = true
        cell.layer.insertSublayer(gradientLayer, at: 0)
        
        cell.layer.shadowColor = UIColor.sf.hexColor(hex: "2a002a").cgColor
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowRadius = 20
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 30)
        
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
