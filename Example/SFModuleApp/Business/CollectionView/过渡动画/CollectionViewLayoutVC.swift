//
//  CollectionViewLayoutVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/7.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import PopMenu
import AnimatedCollectionViewLayout

class CollectionViewLayoutVC: BaseViewController {
    
    fileprivate var direction: UICollectionView.ScrollDirection = .horizontal
    
    var index: Int = 0
    
    fileprivate var animator: [LayoutAttributesAnimator] = [
        CrossFadeAttributesAnimator(),
        CubeAttributesAnimator(),
        LinearCardAttributesAnimator(),
        PageAttributesAnimator(),
        ParallaxAttributesAnimator(),
        RotateInOutAttributesAnimator(),
        SnapInAttributesAnimator(),
        ZoomInOutAttributesAnimator()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = SFSymbol.symbol(name: "list.star", pointSize: 25.0, weight: .regular, scale: .default, tintColor: .systemTeal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: img!, style: .plain, target: self, action: #selector(add(_:)))

        self.view.addSubview(collectionView)
        
        let layout = AnimatedCollectionViewLayout()
        layout.animator = self.animator[self.index]
        layout.scrollDirection = direction
        collectionView.collectionViewLayout = layout
        collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = CGRect(x: 0, y: TopHeight , width: SCREENW, height: SCREENH - TopHeight - SoftHeight)
    }
    
    @objc func add(_ sender: UIBarButtonItem) {
        let manager = PopMenuManager.default
        manager.actions = [
            PopMenuDefaultAction(title: "horizontal", image: SFSymbol.symbol(name: "line.3.crossed.swirl.circle.fill"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)),
            PopMenuDefaultAction(title: "vertical", image: SFSymbol.symbol(name: "shippingbox.fill"), color: #colorLiteral(red: 0.9816910625, green: 0.5655395389, blue: 0.4352460504, alpha: 1)),
        ]
        manager.popMenuAppearance.popMenuFont = UIFont(name: "AvenirNext-DemiBold", size: 16)!
        manager.popMenuAppearance.popMenuBackgroundStyle = .blurred(.light)
        manager.popMenuShouldDismissOnSelection = true
        manager.popMenuDelegate = self
        manager.present(sourceView: sender)
    }

    //collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = AnimatedCollectionViewLayout()
        layout.scrollDirection = .vertical
        layout.animator = ParallaxAttributesAnimator()
        
        let view = UICollectionView.init(frame: CGRectZero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.sf.hexColor(hex: "#f5f6f9")
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        //MARK: 开启了PagingEnabled，行/列间距设置为0，否则滑动cell会有偏移量
        view.isPagingEnabled = true
        view.delegate = self
        view.dataSource = self
        view.register(AnimatedLayoutCell.self, forCellWithReuseIdentifier: NSStringFromClass(AnimatedLayoutCell.self))
        view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = .never
        }
        
        return view
    }()

}

// MARK: - PopMenuViewControllerDelegate
extension CollectionViewLayoutVC: PopMenuViewControllerDelegate {
    
    func popMenuDidSelectItem(_ popMenuViewController: PopMenuViewController, at index: Int) {
        let layout = AnimatedCollectionViewLayout()
        layout.animator = self.animator[self.index]
        layout.scrollDirection = index == 0 ? .horizontal : .vertical
        collectionView.collectionViewLayout = layout
    }
    
}

extension CollectionViewLayoutVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(Int16.max)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(AnimatedLayoutCell.self), for: indexPath) as! AnimatedLayoutCell
        
        cell.backgroundColor = UIColor.sf.random
        cell.label.text = "\(arc4random_uniform(1000))"
        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSizeMake(SCREENW, SCREENH - TopHeight - SoftHeight)
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
