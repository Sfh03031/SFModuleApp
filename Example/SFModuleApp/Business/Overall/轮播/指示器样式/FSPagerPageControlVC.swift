//
//  FSPagerPageControlVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/19.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import FSPagerView
import JXPagingView

class FSPagerPageControlVC: BaseViewController {
    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    
    fileprivate let imageNames = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg"]
    fileprivate let pageControlStyles = ["Default", "Ring", "UIImage", "UIBezierPath - Star", "UIBezierPath - Heart"]
    fileprivate let pageControlAlignments = ["Right", "Center", "Left"]
    fileprivate let sectionTitles = ["Style", "Item Spacing", "Interitem Spacing", "Horizontal Alignment"]
    
    fileprivate var styleIndex = 0 {
        didSet {
            // Clean up
            self.pageControl.setStrokeColor(nil, for: .normal)
            self.pageControl.setStrokeColor(nil, for: .selected)
            self.pageControl.setFillColor(nil, for: .normal)
            self.pageControl.setFillColor(nil, for: .selected)
            self.pageControl.setImage(nil, for: .normal)
            self.pageControl.setImage(nil, for: .selected)
            self.pageControl.setPath(nil, for: .normal)
            self.pageControl.setPath(nil, for: .selected)
            switch self.styleIndex {
            case 0:
                // Default
                break
            case 1:
                // Ring
                self.pageControl.setStrokeColor(.green, for: .normal)
                self.pageControl.setStrokeColor(.green, for: .selected)
                self.pageControl.setFillColor(.green, for: .selected)
            case 2:
                // Image
                self.pageControl.setImage(UIImage(named:"icon_footprint"), for: .normal)
                self.pageControl.setImage(UIImage(named:"icon_cat"), for: .selected)
            case 3:
                // UIBezierPath - Star
                self.pageControl.setStrokeColor(.yellow, for: .normal)
                self.pageControl.setStrokeColor(.yellow, for: .selected)
                self.pageControl.setFillColor(.yellow, for: .selected)
                self.pageControl.setPath(self.starPath, for: .normal)
                self.pageControl.setPath(self.starPath, for: .selected)
            case 4:
                // UIBezierPath - Heart
                let color = UIColor(red: 255/255.0, green: 102/255.0, blue: 255/255.0, alpha: 1.0)
                self.pageControl.setStrokeColor(color, for: .normal)
                self.pageControl.setStrokeColor(color, for: .selected)
                self.pageControl.setFillColor(color, for: .selected)
                self.pageControl.setPath(self.heartPath, for: .normal)
                self.pageControl.setPath(self.heartPath, for: .selected)
            default:
                break
            }
        }
    }
    fileprivate var alignmentIndex = 0 {
        didSet {
            self.pageControl.contentHorizontalAlignment = [.right,.center,.left][self.alignmentIndex]
        }
    }
    
    // ⭐️
    fileprivate var starPath: UIBezierPath {
        let width = self.pageControl.itemSpacing
        let height = self.pageControl.itemSpacing
        let starPath = UIBezierPath()
        starPath.move(to: CGPoint(x: width*0.5, y: 0))
        starPath.addLine(to: CGPoint(x: width*0.677, y: height*0.257))
        starPath.addLine(to: CGPoint(x: width*0.975, y: height*0.345))
        starPath.addLine(to: CGPoint(x: width*0.785, y: height*0.593))
        starPath.addLine(to: CGPoint(x: width*0.794, y: height*0.905))
        starPath.addLine(to: CGPoint(x: width*0.5, y: height*0.8))
        starPath.addLine(to: CGPoint(x: width*0.206, y: height*0.905))
        starPath.addLine(to: CGPoint(x: width*0.215, y: height*0.593))
        starPath.addLine(to: CGPoint(x: width*0.025, y: height*0.345))
        starPath.addLine(to: CGPoint(x: width*0.323, y: height*0.257))
        starPath.close()
        return starPath
    }
    
    // ❤️
    fileprivate var heartPath: UIBezierPath {
        let width = self.pageControl.itemSpacing
        let height = self.pageControl.itemSpacing
        let heartPath = UIBezierPath()
        heartPath.move(to: CGPoint(x: width*0.5, y: height))
        heartPath.addCurve(
            to: CGPoint(x: 0, y: height*0.25),
            controlPoint1: CGPoint(x: width*0.5, y: height*0.75) ,
            controlPoint2: CGPoint(x: 0, y: height*0.5)
        )
        heartPath.addArc(
            withCenter: CGPoint(x: width*0.25,y: height*0.25),
            radius: width * 0.25,
            startAngle: .pi,
            endAngle: 0,
            clockwise: true
        )
        heartPath.addArc(
            withCenter: CGPoint(x: width*0.75, y: height*0.25),
            radius: width * 0.25,
            startAngle: .pi,
            endAngle: 0,
            clockwise: true
        )
        heartPath.addCurve(
            to: CGPoint(x: width*0.5, y: height),
            controlPoint1: CGPoint(x: width, y: height*0.5),
            controlPoint2: CGPoint(x: width*0.5, y: height*0.75)
        )
        heartPath.close()
        return heartPath
    }
    
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
            self.pageControl.itemSpacing = 6.0 + CGFloat(sender.value*10.0) // [6 - 16]
            // Redraw UIBezierPath
            if [3,4].contains(self.styleIndex) {
                let index = self.styleIndex
                self.styleIndex = index
            }
        case 2:
            self.pageControl.interitemSpacing = 6.0 + CGFloat(sender.value*10.0) // [6 - 16]
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
        
        pageControl.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(30)
        }
        return view
    }()

    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height), style: .grouped)
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
        return pagerView
    }()
    
    // 懒加载滚动图片浏下标
    lazy var pageControl:FSPageControl = {
        let pageControl = FSPageControl()
        pageControl.numberOfPages = self.imageNames.count
        pageControl.contentHorizontalAlignment = .right
        pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        pageControl.hidesForSinglePage = true
        return pageControl
    }()

}

extension FSPagerPageControlVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionTitles.count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.pageControlStyles.count
        case 1,2:
            return 1
        case 3:
            return self.pageControlAlignments.count
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let identifier:String = NSStringFromClass(UITableViewCell.self)
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
            if cell == nil {
                cell = UITableViewCell.init(style: .default, reuseIdentifier: identifier)
            }
            cell?.textLabel?.text = self.pageControlStyles[indexPath.row]
            cell?.accessoryType = self.styleIndex==indexPath.row ? .checkmark : .none
            return cell!
        case 1:
            let identifier:String = NSStringFromClass(FSPagerSliderCell.self)
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FSPagerSliderCell
            if cell == nil {
                cell = FSPagerSliderCell.init(style: .default, reuseIdentifier: identifier)
            }
            let slider = cell?.contentView.subviews.first as! UISlider
            slider.tag = indexPath.section
            slider.value = Float((self.pageControl.itemSpacing-6.0)/10.0)
            slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
            return cell!
        case 2:
            let identifier:String = NSStringFromClass(FSPagerSliderCell.self)
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FSPagerSliderCell
            if cell == nil {
                cell = FSPagerSliderCell.init(style: .default, reuseIdentifier: identifier)
            }
            let slider = cell?.contentView.subviews.first as! UISlider
            slider.tag = indexPath.section
            slider.value = Float((self.pageControl.interitemSpacing-6.0)/10.0)
            slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
            return cell!
        case 3:
            let identifier:String = NSStringFromClass(UITableViewCell.self)
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
            if cell == nil {
                cell = UITableViewCell.init(style: .default, reuseIdentifier: identifier)
            }
            cell?.textLabel?.text = self.pageControlAlignments[indexPath.row]
            cell?.accessoryType = self.alignmentIndex==indexPath.row ? .checkmark : .none
            return cell!
        default:
            break
        }
        return tableView.dequeueReusableCell(withIdentifier: "cell")!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return [0,3].contains(indexPath.section) // 0 or 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            self.styleIndex = indexPath.row
            tableView.reloadSections([indexPath.section], with: .automatic)
        case 3:
            self.alignmentIndex = indexPath.row
            tableView.reloadSections([indexPath.section], with: .automatic)
        default:
            break
        }
    }
}

extension FSPagerPageControlVC: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.imageNames.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFill
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
    }
    
    // MARK:- FSPagerViewDelegate
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
}

//MARK: - JXPagingViewListViewDelegate
extension FSPagerPageControlVC: JXPagingViewListViewDelegate {
    
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
