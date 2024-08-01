//
//  FSPagerViewVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/19.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class FSPagerViewVC: BaseViewController {

    var titles: [String] = ["Basic", "Transformer", "PageControl"]
    var titleImgs: [String] = ["", "", ""]
    var selectedImgNames: [String] = ["indicator1", "indicator1", "indicator1"]
    var defIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "轮播"
        
        self.view.addSubview(self.pagingView)
        
        self.segmentedView.listContainer = self.pagingView.listContainerView
        
        //扣边返回处理，下面的代码要加上
        pagingView.listContainerView.scrollView.panGestureRecognizer.require(toFail: self.navigationController!.interactivePopGestureRecognizer!)
        pagingView.mainTableView.panGestureRecognizer.require(toFail: self.navigationController!.interactivePopGestureRecognizer!)
        
        loadData()
    }
    
    func loadData() {
        if self.titles.count > 4 {
            self.dataSource.itemWidth = (SCREENW - 40)/4
        } else {
            self.dataSource.itemWidth = Double(CGFloat(SCREENW - 40)/CGFloat(self.titles.count))
        }
        
        self.dataSource.titles = self.titles
        self.dataSource.normalImageInfos = self.titleImgs
        self.dataSource.selectedImageInfos = self.selectedImgNames
        self.segmentedView.dataSource = self.dataSource
        self.segmentedView.defaultSelectedIndex = self.defIndex
        self.segmentedView.reloadData()
        self.pagingView.reloadData()
    }

    lazy var dataSource: JXSegmentedTitleImageDataSource = {
        let source = JXSegmentedTitleImageDataSource()
        source.itemWidth = Double(CGFloat(SCREENW - 40)/CGFloat(self.titles.count))
        source.isItemSpacingAverageEnabled = true
        source.isTitleColorGradientEnabled = true
        source.isSelectedAnimable = true
        source.isItemWidthZoomEnabled = false
//        source.itemWidthSelectedZoomScale = 1.3
        source.titleNormalColor = UIColor.sf.hexColor(hex: "#222222")
        source.titleSelectedColor = UIColor.sf.hexColor(hex: "#008AFF")
        source.titleNormalFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        source.titleSelectedFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        source.titleImageType = .bottomImage
        source.imageSize = CGSize(width: 17, height: 4)
        source.titleImageSpacing = 5
        source.itemSpacing = 0
        return source
    }()
    
    lazy var segmentedView: JXSegmentedView = {
        let segment = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: 40))
        segment.backgroundColor = .clear
        segment.delegate = self
        segment.contentEdgeInsetLeft = 20
        segment.contentEdgeInsetRight = 20
        segment.isContentScrollViewClickTransitionAnimationEnabled = false
        return segment
    }()
    
    ///pagingView
    lazy var pagingView: JXPagingView = {
        let paging = JXPagingView(delegate: self)
        paging.frame = CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - SoftHeight)
        paging.mainTableView.gestureDelegate = self
        paging.mainTableView.backgroundColor = .clear
        paging.mainTableView.isScrollEnabled = false
        paging.listContainerView.listCellBackgroundColor = .clear
        paging.automaticallyDisplayListVerticalScrollIndicator = false
//        paging.pinSectionHeaderVerticalOffset = 100
        return paging
    }()

}

//MARK: - JXSegmentedViewDelegate
extension FSPagerViewVC: JXSegmentedViewDelegate {
    
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = (index == 0)
        
        self.defIndex = index
        print("当前次序: \(self.defIndex)")
    }
}

//MARK: - JXPagingViewDelegate
extension FSPagerViewVC: JXPagingViewDelegate {

    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        return Int(0)
    }

    func tableHeaderView(in pagingView: JXPagingView) -> UIView {
        return UIView()
    }

    func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int {
        return 40
    }

    func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView {
        return segmentedView
    }

    func numberOfLists(in pagingView: JXPagingView) -> Int {
        return titles.count
    }

    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        if index == 0 {
            return FSPagerBasicVC()
        } else if index == 1 {
            return FSPagerTransformerVC()
        } else {
            return FSPagerPageControlVC()
        }
    }
}

//MARK: - JXPagingMainTableViewGestureDelegate
extension FSPagerViewVC: JXPagingMainTableViewGestureDelegate {
    
    func mainTableViewGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        //禁止segmentedView左右滑动的时候，上下和左右都可以滚动
        if otherGestureRecognizer == segmentedView.collectionView.panGestureRecognizer {
            return false
        }
        return gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self)
    }
    
    func pagingView(_ pagingView: JXPagingView, mainTableViewDidScroll scrollView: UIScrollView) {
        print(scrollView.contentOffset)
    }
}
