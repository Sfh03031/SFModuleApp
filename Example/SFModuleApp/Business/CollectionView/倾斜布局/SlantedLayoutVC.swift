//
//  SlantedLayoutVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/17.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SFStyleKit
//import CollectionViewSlantedLayout

class SlantedLayoutVC: BaseViewController {
    
    internal var covers = [[String: String]]()

    let reuseIdentifier = "customViewCell"

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        collectionView.reloadData()
//        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img_right = SFSymbol.symbol(name: "list.star", pointSize: 25.0, weight: .regular, scale: .default, tintColor: .systemTeal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: img_right!, style: .plain, target: self, action: #selector(rightTap(_:)))

        collectionView.frame = CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - SoftHeight)
        self.view.addSubview(collectionView)
        
        if let url = Bundle.main.url(forResource: "covers", withExtension: "plist"),
            let contents = NSArray(contentsOf: url) as? [[String: String]] {
            covers = contents
            collectionView.reloadData()
        }
    }
    
    @objc func rightTap(_ sender: UIBarButtonItem) {
        let vc = SlantedSettingVC()
        vc.slantingDirection = self.collectionViewLayout.slantingDirection
        vc.scrollDirection = self.collectionViewLayout.scrollDirection
        vc.zIndexOrder = self.collectionViewLayout.zIndexOrder
        vc.isFirstCellExcluded = self.collectionViewLayout.isFirstCellExcluded
        vc.isLastCellExcluded = self.collectionViewLayout.isLastCellExcluded
        vc.slantingSize = self.collectionViewLayout.slantingSize
        vc.lineSpacing = self.collectionViewLayout.lineSpacing
        vc.collectionViewLayout = self.collectionViewLayout
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
        vc.slantDirectionBlock = { [weak self] value in
            self?.collectionViewLayout.slantingDirection = value
            self?.collectionView.collectionViewLayout = self!.collectionViewLayout
            self?.collectionView.reloadData()
        }
        
        vc.scrollDirectionBlock = { [weak self] value in
            self?.collectionViewLayout.scrollDirection = value
            self?.collectionView.collectionViewLayout = self!.collectionViewLayout
            self?.collectionView.reloadData()
        }
        
        vc.zIndexOrderBlock = { [weak self] value in
            self?.collectionViewLayout.zIndexOrder = value
            self?.collectionView.collectionViewLayout = self!.collectionViewLayout
            self?.collectionView.reloadData()
        }
        
        vc.excludeFirstBlock = { [weak self] value in
            self?.collectionViewLayout.isFirstCellExcluded = value
            self?.collectionView.collectionViewLayout = self!.collectionViewLayout
            self?.collectionView.reloadData()
        }
        
        vc.excludeLastBlock = { [weak self] value in
            self?.collectionViewLayout.isLastCellExcluded = value
            self?.collectionView.collectionViewLayout = self!.collectionViewLayout
            self?.collectionView.reloadData()
        }
        
        vc.slantingSizeBlock = { [weak self] value in
            self?.collectionViewLayout.slantingSize = value
            self?.collectionView.collectionViewLayout = self!.collectionViewLayout
            self?.collectionView.reloadData()
        }
        
        vc.lineSpacingBlock = { [weak self] value in
            self?.collectionViewLayout.lineSpacing = value
            self?.collectionView.collectionViewLayout = self!.collectionViewLayout
            self?.collectionView.reloadData()
        }
    }

    //MARK: - lazyload
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .hex_F5F6F9
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SlantedCell.self, forCellWithReuseIdentifier: String(describing: SlantedCell.self))
//        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        return collectionView
    }()
    
    lazy var collectionViewLayout: CollectionViewSlantedLayout = {
        let layout = CollectionViewSlantedLayout()
        layout.isFirstCellExcluded = true
        layout.isLastCellExcluded = true
        layout.slantingDirection = .downward
        return layout
    }()

}

extension SlantedLayoutVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return covers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SlantedCell.self), for: indexPath) as? SlantedCell else {
            fatalError()
        }

        cell.image = UIImage(named: covers[indexPath.row]["picture"]!)!
        cell.label.text = "== \(indexPath.row) =="

        if let layout = collectionView.collectionViewLayout as? CollectionViewSlantedLayout {
            //FIXME: 在计算slantingAngle时可能会崩溃，在计算时取collectionView宽度有可能会取不到，collectionView不存在导致分母等于0，进而导致崩溃
            print(layout.slantingAngle)
            cell.contentView.transform = CGAffineTransform(rotationAngle: layout.slantingAngle)
        }

        return cell
    }
}

extension SlantedLayoutVC: CollectionViewDelegateSlantedLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NSLog("Did select item at indexPath: [\(indexPath.section)][\(indexPath.row)]")
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: CollectionViewSlantedLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGFloat {
        return collectionViewLayout.scrollDirection == .vertical ? SCREENW : (SCREENH - TopHeight - SoftHeight)
    }
}

extension SlantedLayoutVC: UIScrollViewDelegate {
    
    //FIXME: 在滑动过程中改变视觉效果，会对isLastCellExcluded属性有影响，不要也无所谓
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let visibleCells = self.collectionView.visibleCells as? [SlantedCell] else {return}
        for parallaxCell in visibleCells {
            let yOffset = (collectionView.contentOffset.y - parallaxCell.frame.origin.y) / parallaxCell.imageHeight
            let xOffset = (collectionView.contentOffset.x - parallaxCell.frame.origin.x) / parallaxCell.imageWidth
            parallaxCell.offset(CGPoint(x: xOffset * xOffsetSpeed, y: yOffset * yOffsetSpeed))
        }
    }
}
