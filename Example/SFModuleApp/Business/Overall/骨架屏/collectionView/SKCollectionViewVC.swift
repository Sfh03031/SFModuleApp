//
//  SKCollectionViewVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SkeletonView
import ViewAnimator

class SKCollectionViewVC: BaseViewController {
    
    var isShowAni:Bool = false
    private var items = [Any?]()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let animations = [AnimationType.vector((CGVector(dx: 0, dy: 30)))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(collectionView)
        if isShowAni == true { // Animator
            let img1 = SFSymbol.symbol(name: "autostartstop", pointSize: 25.0, weight: .regular, scale: .default, tintColor: .systemTeal)
            let item1 = UIBarButtonItem(image: img1!, style: .plain, target: self, action: #selector(resetTapped(_:)))
            let img2 = SFSymbol.symbol(name: "gobackward", pointSize: 25.0, weight: .regular, scale: .default, tintColor: .systemTeal)
            let item2 = UIBarButtonItem(image: img2!, style: .plain, target: self, action: #selector(animateTapped(_:)))
            self.navigationItem.rightBarButtonItems = [item1, item2]
            
            setupActivityIndicator()
            
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellid")
            
            activityIndicator.stopAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) {
                self.items = Array(repeating: nil, count: 5)
                self.collectionView.reloadData()
                self.collectionView.performBatchUpdates({
                    UIView.animate(views: self.collectionView.orderedVisibleCells,
                                   animations: self.animations, completion: {
                        
                        })
                }, completion: nil)
            }
        } else { // skeleton
            let img = SFSymbol.symbol(name: "pencil.slash", pointSize: 25.0, weight: .regular, scale: .default, tintColor: .systemTeal)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: img!, style: .plain, target: self, action: #selector(add(_:)))
            
            collectionView.isSkeletonable = true
            
            doSkeletion()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - SoftHeight)
    }
    
    //MARK: - skeleton
    @objc func add(_ sender: UIBarButtonItem) {
        doSkeletion()
    }
    
    func doSkeletion() {
        if self.collectionView.sk.isSkeletonActive {
            self.collectionView.hideSkeleton()
        } else {
            self.collectionView.showAnimatedSkeleton()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.collectionView.hideSkeleton()
            }
        }
    }
    
    //MARK: - Animator
    private func setupActivityIndicator() {
        activityIndicator.center = CGPoint(x: view.center.x, y: view.center.y)
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    @objc func animateTapped(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        activityIndicator.stopAnimating()
        items = Array(repeating: nil, count: 5)
        collectionView.reloadData()
        collectionView.performBatchUpdates({
            UIView.animate(views: self.collectionView.orderedVisibleCells,
                animations: animations, options: [.curveEaseInOut], completion: {
                sender.isEnabled = true
                })
        }, completion: nil)
    }
    
    @objc func resetTapped(_ sender: UIBarButtonItem) {
        items.removeAll()
        UIView.animate(views: collectionView.orderedVisibleCells,
                       animations: animations, reversed: true,
                       initialAlpha: 1.0,
                       finalAlpha: 0.0,
                       options: [.curveEaseIn],
                       completion: {
                        self.collectionView.reloadData()
                        self.activityIndicator.startAnimating()
        })
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
        view.register(SKCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(SKCollectionViewCell.self))
        view.register(HeaderFooterReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        view.register(HeaderFooterReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footerId")
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = .never
        }
        return view
    }()

}

extension SKCollectionViewVC: SkeletonCollectionViewDataSource {
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return NSStringFromClass(SKCollectionViewCell.self)
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(SKCollectionViewCell.self), for: indexPath) as! SKCollectionViewCell
        
        cell.infoLabel.text = "SKCollectionViewCell - \(indexPath.item)"
        
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, supplementaryViewIdentifierOfKind: String, at indexPath: IndexPath) -> ReusableCellIdentifier? {
        if supplementaryViewIdentifierOfKind == UICollectionView.elementKindSectionHeader {
            return "headerId"
        } else {
            return "footerId"
        }
    }
}

extension SKCollectionViewVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return isShowAni ? 2 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isShowAni ? items.count : 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isShowAni {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath)
            let color: UIColor = indexPath.section % 2 == 0 ? .red : .blue
            cell.contentView.backgroundColor = color
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(SKCollectionViewCell.self), for: indexPath) as! SKCollectionViewCell
            
            cell.infoLabel.text = "SKCollectionViewCell - \(indexPath.item)"
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header:HeaderFooterReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! HeaderFooterReusableView
            
            header.infoLabel.text = "UICollectionElementKindSectionHeader"
            
            return header
        } else {
            let footer:HeaderFooterReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footerId", for: indexPath) as! HeaderFooterReusableView
            
            footer.infoLabel.text = "UICollectionElementKindSectionFooter"
            
            return footer
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: SCREENW, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: SCREENW, height: 50)
    }
    
}
