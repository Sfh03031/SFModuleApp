//
//  WaveFirstCollectionVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/21.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

//FIXME: 必须是UICollectionViewController的子类，只需在点击事件里实现‘selectedIndexPath = indexPath’
//FIXME: 注意点击事件里不要调用‘deselectItem’方法
class WaveFirstCollectionVC: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self))
    }

}

extension WaveFirstCollectionVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(UICollectionViewCell.self), for: indexPath)

        cell.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
        
        selectedIndexPath = indexPath
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (SCREENW - 40) / 3, height: (SCREENW - 40) / 3)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(all: 10)
        
        let vc = WaveSecondCollectionVC.init(collectionViewLayout: layout)
        vc.title = "UICollectionViewController子类"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
