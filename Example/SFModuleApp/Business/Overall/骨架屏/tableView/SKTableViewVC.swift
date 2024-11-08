//
//  SKTableViewVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SkeletonView
import ViewAnimator

class SKTableViewVC: BaseViewController {

    var isShowAni:Bool = false
    private var items = [Any?]()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let animations = [AnimationType.vector(CGVector(dx: 0, dy: 30))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        if isShowAni == true { // Animator
            let img1 = SFSymbol.symbol(name: "autostartstop", pointSize: 25.0, weight: .regular, scale: .default, tintColor: .systemTeal)
            let item1 = UIBarButtonItem(image: img1!, style: .plain, target: self, action: #selector(resetTapped(_:)))
            let img2 = SFSymbol.symbol(name: "gobackward", pointSize: 25.0, weight: .regular, scale: .default, tintColor: .systemTeal)
            let item2 = UIBarButtonItem(image: img2!, style: .plain, target: self, action: #selector(animateTapped(_:)))
            self.navigationItem.rightBarButtonItems = [item1, item2]
            
            setupActivityIndicator()
        } else { // skeleton
            let img = SFSymbol.symbol(name: "pencil.slash", pointSize: 25.0, weight: .regular, scale: .default, tintColor: .systemTeal)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: img!, style: .plain, target: self, action: #selector(add(_:)))
            
            tableView.isSkeletonable = true
 
            doSkeletion()
        }
    }
    
    //MARK: - skeleton
    @objc func add(_ sender: UIBarButtonItem) {
        doSkeletion()
    }
    
    func doSkeletion() {
        if self.tableView.sk.isSkeletonActive {
            self.tableView.hideSkeleton()
        } else {
            self.tableView.showAnimatedSkeleton()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.tableView.hideSkeleton()
            }
        }
    }
    
    //MARK: - Animator
    private func setupActivityIndicator() {
        activityIndicator.center = CGPoint(x: view.center.x, y: 100.0)
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    @objc func animateTapped(_ sender: UIBarButtonItem) {
        sender.isEnabled = false
        activityIndicator.stopAnimating()
        items = Array(repeating: nil, count: 20)
        tableView.reloadData()
        UIView.animate(views: tableView.visibleCells, animations: animations, completion: {
            sender.isEnabled = true
        })
    }
    
    @objc func resetTapped(_ sender: UIBarButtonItem) {
        items.removeAll()
        UIView.animate(views: tableView.visibleCells, animations: animations, reversed: true,
                       initialAlpha: 1.0, finalAlpha: 0.0, completion: {
            self.tableView.reloadData()
            self.activityIndicator.startAnimating()
        })
    }
    
    //MARK: - lazyload
    
    //tableView
    lazy var tableView: UITableView = {
        let tabView = UITableView.init(frame: CGRect.init(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - SoftHeight), style: .grouped)
        tabView.backgroundColor = .lightGray
        tabView.showsVerticalScrollIndicator = false
        tabView.delegate = self
        tabView.dataSource = self
        tabView.sectionHeaderHeight = UITableView.automaticDimension
        tabView.sectionFooterHeight = UITableView.automaticDimension
        tabView.estimatedRowHeight = 120.0
        tabView.estimatedSectionFooterHeight = 20.0
        tabView.estimatedSectionHeaderHeight = 20.0
        tabView.register(HeaderFooterSection.self, forHeaderFooterViewReuseIdentifier: "HeaderIdentifier")
        tabView.register(HeaderFooterSection.self, forHeaderFooterViewReuseIdentifier: "FooterIdentifier")
        return tabView
    }()

}

//MARK: - SkeletonTableViewDataSource
extension SKTableViewVC: SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return NSStringFromClass(SKTableViewCell.self)
    }
    
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 3
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        let identifier:String = NSStringFromClass(SKTableViewCell.self)
        var cell = skeletonView.dequeueReusableCell(withIdentifier: identifier) as? SKTableViewCell
        if cell == nil {
            cell = SKTableViewCell.init(style: .subtitle, reuseIdentifier: identifier)
        }
        
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, prepareCellForSkeleton cell: UITableViewCell, at indexPath: IndexPath) {
        let cell = cell as? SKTableViewCell
        
        // 在骨架屏的cell上做一些操作，在显示cell时记得还原
//        cell?.iconView.isHidden = indexPath.row == 0
    }
}

//MARK: - SkeletonTableViewDelegate
extension SKTableViewVC: SkeletonTableViewDelegate {
    func collectionSkeletonView(_ skeletonView: UITableView, identifierForHeaderInSection section: Int) -> ReusableHeaderFooterIdentifier? {
        return "HeaderIdentifier"
    }

    func collectionSkeletonView(_ skeletonView: UITableView, identifierForFooterInSection section: Int) -> ReusableHeaderFooterIdentifier? {
        return "FooterIdentifier"
    }

}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension SKTableViewVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier:String = NSStringFromClass(SKTableViewCell.self)
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SKTableViewCell
        if cell == nil {
            cell = SKTableViewCell.init(style: .subtitle, reuseIdentifier: identifier)
        }
        
        cell?.iconView.isHidden = false
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderIdentifier") as! HeaderFooterSection
        header.titleLabel.text = "header -> \(section)"
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FooterIdentifier") as! HeaderFooterSection
        footer.titleLabel.text = "footer -> \(section)"
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44
    }
    
}
