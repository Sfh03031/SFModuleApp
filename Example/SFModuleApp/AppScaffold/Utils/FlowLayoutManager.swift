//
//  FlowLayoutManager.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class FlowLayoutManager: NSObject {

    static let shared = FlowLayoutManager()
    
    func makeFlowLayout(scrollDirection: UICollectionView.ScrollDirection = .vertical,
                        itemSize: CGSize = CGSize(width: SCREENW - 20, height: 80),
                        sectionInset: UIEdgeInsets = UIEdgeInsets(all: 10),
                        minimumInteritemSpacing: CGFloat = 10,
                        minimumLineSpacing: CGFloat = 10) -> UICollectionViewFlowLayout {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = scrollDirection
        flowLayout.itemSize = itemSize
        flowLayout.sectionInset = sectionInset
        flowLayout.minimumInteritemSpacing = minimumInteritemSpacing
        flowLayout.minimumLineSpacing = minimumLineSpacing
        
        return flowLayout
    }
}
