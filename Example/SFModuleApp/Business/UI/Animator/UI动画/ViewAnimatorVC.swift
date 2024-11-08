//
//  ViewAnimatorVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/25.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import ViewAnimator

class ViewAnimatorVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = SFSymbol.symbol(name: "pencil.slash", pointSize: 25.0, weight: .regular, scale: .default, tintColor: .systemTeal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: img!, style: .plain, target: self, action: #selector(add(_:)))

        self.view.addSubview(tableView)
        self.view.addSubview(collectionView)
    }
    
    @objc func add(_ sender: UIBarButtonItem) {
        let fromAnimation = AnimationType.vector(CGVector(dx: 30, dy: 0))
        let zoomAnimation = AnimationType.zoom(scale: 0.2)
        let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
        UIView.animate(views: collectionView.visibleCells,
                       animations: [zoomAnimation, rotateAnimation],
                       duration: 0.5)
        
        UIView.animate(views: tableView.visibleCells,
                       animations: [fromAnimation, zoomAnimation], delay: 0.5)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = CGRect(x: 0, y: TopHeight, width: SCREENW, height: (SCREENH - TopHeight - SoftHeight)/2)
        tableView.frame = CGRect(x: 0, y: TopHeight + (SCREENH - TopHeight - SoftHeight)/2, width: SCREENW, height: (SCREENH - TopHeight - SoftHeight)/2)
    }
    
    //tableView
    lazy var tableView: UITableView = {
        let tabView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tabView.backgroundColor = .lightGray
        tabView.showsVerticalScrollIndicator = false
        tabView.dataSource = self
        tabView.sectionHeaderHeight = UITableView.automaticDimension
        tabView.sectionFooterHeight = UITableView.automaticDimension
        tabView.estimatedRowHeight = 120.0
        tabView.estimatedSectionFooterHeight = 20.0
        tabView.estimatedSectionHeaderHeight = 20.0
        tabView.tableFooterView = UIView()
        return tabView
    }()
    
    //collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSizeMake((SCREENW - 60)/2, 140)
        flowLayout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: SoftHeight, right: 10)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10

        let view = UICollectionView.init(frame: CGRectZero, collectionViewLayout: flowLayout)
        view.backgroundColor = UIColor.sf.hexColor(hex: "#f5f6f9")
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.dataSource = self
        view.register(SKCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(SKCollectionViewCell.self))
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = .never
        }
        return view
    }()

}

extension ViewAnimatorVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier:String = NSStringFromClass(SKTableViewCell.self)
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SKTableViewCell
        if cell == nil {
            cell = SKTableViewCell.init(style: .subtitle, reuseIdentifier: identifier)
        }
        
        return cell!
    }
    
}

extension ViewAnimatorVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(SKCollectionViewCell.self), for: indexPath) as! SKCollectionViewCell
        
        cell.backgroundColor = UIColor.red
        cell.layer.cornerRadius = 5.0
        cell.infoLabel.text = "SKCollectionViewCell - \(indexPath.item)"
        
        return cell
    }
    
    
}
