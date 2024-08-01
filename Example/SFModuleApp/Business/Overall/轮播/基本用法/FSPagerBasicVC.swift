//
//  FSPagerBasicVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/19.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import FSPagerView

class FSPagerBasicVC: BaseViewController {
    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    
    fileprivate let sectionTitles = ["Configurations", "Decelaration Distance", "Item Size", "Interitem Spacing", "Number Of Items"]
    fileprivate let configurationTitles = ["Automatic sliding","Infinite"]
    fileprivate let decelerationDistanceOptions = ["Automatic", "1", "2"]
    fileprivate let imageNames = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg"]
    fileprivate var numberOfItems = 7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.sf.hexColor(hex: "#F5F6F9")
        self.view.addSubview(self.tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.tableView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.listViewDidScrollCallback?(scrollView)
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        switch sender.tag {
        case 1:
            let newScale = 0.5+CGFloat(sender.value)*0.5 // [0.5 - 1.0]
            self.pagerView.itemSize = self.pagerView.frame.size.applying(CGAffineTransform(scaleX: newScale, y: newScale))
        case 2:
            self.pagerView.interitemSpacing = CGFloat(sender.value) * 20 // [0 - 20]
        case 3:
            self.numberOfItems = Int(roundf(sender.value*7.0))
            self.pageControl.numberOfPages = self.numberOfItems
            self.pagerView.reloadData()
        default:
            break
        }
    }
    
    lazy var headView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: 200))
        view.addSubview(pagerView)
        view.addSubview(pageControl)
        
        pagerView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        pagerView.layoutIfNeeded()
        
        pageControl.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(30)
        }
        return view
    }()

    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRectZero, style: .grouped)
        view.backgroundColor = .clear
        view.delegate = self
        view.dataSource = self
        view.tableHeaderView = headView
        return view
    }()
    
    // 懒加载滚动图片浏览器
    private lazy var pagerView : FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.itemSize = FSPagerView.automaticSize
        return pagerView
    }()
    
    // 懒加载滚动图片浏下标
    lazy var pageControl:FSPageControl = {
        let pageControl = FSPageControl()
        pageControl.numberOfPages = self.imageNames.count
        pageControl.contentHorizontalAlignment = .right
        pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return pageControl
        
    }()

}

extension FSPagerBasicVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.configurationTitles.count
        case 1:
            return self.decelerationDistanceOptions.count
        case 2,3,4:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            // Configurations
            let identifier:String = NSStringFromClass(UITableViewCell.self)
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
            if cell == nil {
                cell = UITableViewCell.init(style: .default, reuseIdentifier: identifier)
            }
            cell?.textLabel?.text = self.configurationTitles[indexPath.row]
            if indexPath.row == 0 {
                // Automatic Sliding
                cell?.accessoryType = self.pagerView.automaticSlidingInterval > 0 ? .checkmark : .none
            } else if indexPath.row == 1 {
                // IsInfinite
                cell?.accessoryType = self.pagerView.isInfinite ? .checkmark : .none
            }
            return cell!
        case 1:
            // Decelaration Distance
            let identifier:String = NSStringFromClass(UITableViewCell.self)
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
            if cell == nil {
                cell = UITableViewCell.init(style: .default, reuseIdentifier: identifier)
            }
            cell?.textLabel?.text = self.decelerationDistanceOptions[indexPath.row]
            switch indexPath.row {
            case 0:
                cell?.accessoryType = self.pagerView.decelerationDistance == FSPagerView.automaticDistance ? .checkmark : .none
            case 1:
                cell?.accessoryType = self.pagerView.decelerationDistance == 1 ? .checkmark : .none
            case 2:
                cell?.accessoryType = self.pagerView.decelerationDistance == 2 ? .checkmark : .none
            default:
                break;
            }
            return cell!
        case 2:
            // Item Spacing
            let identifier:String = NSStringFromClass(FSPagerSliderCell.self)
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FSPagerSliderCell
            if cell == nil {
                cell = FSPagerSliderCell.init(style: .default, reuseIdentifier: identifier)
            }
            let slider = cell?.contentView.subviews.first as! UISlider
            slider.tag = 1
            slider.value = {
                let scale: CGFloat = self.pagerView.itemSize.width/self.pagerView.frame.width
                let value: CGFloat = (0.5-scale)*2
                return Float(value)
            }()
            slider.isContinuous = true
            slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
            return cell!
        case 3:
            // Interitem Spacing
            let identifier:String = NSStringFromClass(FSPagerSliderCell.self)
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FSPagerSliderCell
            if cell == nil {
                cell = FSPagerSliderCell.init(style: .default, reuseIdentifier: identifier)
            }
            let slider = cell?.contentView.subviews.first as! UISlider
            slider.tag = 2
            slider.value = Float(self.pagerView.interitemSpacing/20.0)
            slider.isContinuous = true
            slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
            return cell!
        case 4:
            // Number Of Items
            let identifier:String = NSStringFromClass(FSPagerSliderCell.self)
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FSPagerSliderCell
            if cell == nil {
                cell = FSPagerSliderCell.init(style: .default, reuseIdentifier: identifier)
            }
            let slider = cell?.contentView.subviews.first as! UISlider
            slider.tag = 3
            slider.minimumValue = 1.0 / 7
            slider.maximumValue = 1.0
            slider.value = Float(self.numberOfItems) / 7.0
            slider.isContinuous = false
            slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
            return cell!
        default:
            break
        }
        return tableView.dequeueReusableCell(withIdentifier: "cell")!
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 || indexPath.section == 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 { // Automatic Sliding
                self.pagerView.automaticSlidingInterval = 3.0 - self.pagerView.automaticSlidingInterval
            } else if indexPath.row == 1 { // IsInfinite
                self.pagerView.isInfinite = !self.pagerView.isInfinite
            }
            tableView.reloadSections([indexPath.section], with: .automatic)
        case 1:
            switch indexPath.row {
            case 0:
                self.pagerView.decelerationDistance = FSPagerView.automaticDistance
            case 1:
                self.pagerView.decelerationDistance = 1
            case 2:
                self.pagerView.decelerationDistance = 2
            default:
                break
            }
            tableView.reloadSections([indexPath.section], with: .automatic)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 40 : 20
    }
}

extension FSPagerBasicVC: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.numberOfItems
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.textLabel?.text = index.description+index.description
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
}

//MARK: - JXPagingViewListViewDelegate
extension FSPagerBasicVC: JXPagingViewListViewDelegate {
    
    func listView() -> UIView {
        return self.view
    }

    func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        self.listViewDidScrollCallback = callback
    }
    
    func listScrollView() -> UIScrollView {
        return self.tableView
    }
    
    func listWillAppear() {
        print("\(self):\(#function)")
    }

    func listDidAppear() {
        print("\(self):\(#function)")
    }

    func listWillDisappear() {
        print("\(self):\(#function)")
    }

    func listDidDisappear() {
        print("\(self):\(#function)")
    }
}
