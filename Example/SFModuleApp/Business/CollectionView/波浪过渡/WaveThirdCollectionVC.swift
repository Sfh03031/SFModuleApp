//
//  WaveThirdCollectionVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/21.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class WaveThirdCollectionVC: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self))
    }
}

extension WaveThirdCollectionVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(UICollectionViewCell.self), for: indexPath)

        cell.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
        
        selectedIndexPath = indexPath
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (SCREENW - 60) / 5, height: (SCREENW - 60) / 5)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(all: 10)
        
        let vc = WaveFourthCollectionVC.init(collectionViewLayout: layout)
        vc.title = "UICollectionViewController子类"
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
