//
//  PYSearchExampleVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/6/18.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import PYSearch
import SFStyleKit
import UIFontComplete


class PYSearchExampleVC: BaseViewController {
    
    var segCount: Int = 4

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
    }
    

    //MARK: - lazyload
    
    //tableView
    lazy var tableView: UITableView = {
        let tabView = UITableView.init(frame: CGRect.init(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - SoftHeight), style: .grouped)
        tabView.backgroundColor = UIColor.sf.hexColor(hex: "#F5F6F9")
        tabView.showsVerticalScrollIndicator = false
        tabView.delegate = self
        tabView.dataSource = self
        tabView.estimatedRowHeight = Const.closeCellHeight
        tabView.register(FoldExpandCell.self, forCellReuseIdentifier: String(describing: FoldExpandCell.self))
        return tabView
    }()

}

extension PYSearchExampleVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 6 : 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.section == 0 {
            cell.textLabel?.text = ["PYHotSearchStyleDefault", "PYHotSearchStyleColorfulTag", "PYHotSearchStyleBorderTag", "PYHotSearchStyleARCBorderTag", "PYHotSearchStyleRankTag", "PYHotSearchStyleRectangleTag"][indexPath.row]
        } else {
            cell.textLabel?.text = ["PYSearchHistoryStyleDefault", "PYSearchHistoryStyleNormalTag", "PYSearchHistoryStyleColorfulTag", "PYSearchHistoryStyleBorderTag", "PYSearchHistoryStyleARCBorderTag"][indexPath.row]
        }
        return cell
    }

    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hotSearches = ["Java", "Python", "Objective-C", "Swift", "C", "C++", "PHP", "C#", "Perl", "Go", "JavaScript", "R", "Ruby", "MATLAB"]
        let searchVC = PYSearchViewController(hotSearches: hotSearches, searchBarPlaceholder: "搜索编程语言") { searchViewController, searchBar, searchText in
            // FIXME: The `delegate` has a priority greater than the `block`, `block` is't effective when `searchViewController:didSearchWithSearchBar:searchText:` is implemented.
            searchViewController?.navigationController?.pushViewController(PYSearchResultVC(), animated: true)
        }
        
        let hotStyle:[PYHotSearchStyle] = [.default, .colorfulTag, .borderTag, .arcBorderTag, .rankTag, .rectangleTag]
        let historyStyle:[PYSearchHistoryStyle] = [.default, .normalTag, .colorfulTag, .borderTag, .arcBorderTag]
        if indexPath.section == 0 {
            searchVC?.hotSearchStyle = hotStyle[indexPath.row]
            searchVC?.searchHistoryStyle = .default
        } else {
            searchVC?.hotSearchStyle = .default
            searchVC?.searchHistoryStyle = historyStyle[indexPath.row]
        }
        
        searchVC?.removeSpaceOnSearchString = false
        
        // 搜索框样式
        if #available(iOS 13, *) {
            // placeholder
            let text = searchVC?.searchBar.searchTextField.placeholder ?? ""
            let attStr = NSMutableAttributedString(string: text, attributes: [.foregroundColor: UIColor.hex_003472, .font: UIFont.init(font: .optimaItalic, size: 13)!])
            searchVC?.searchBar.searchTextField.attributedPlaceholder = attStr
            // 字色
            searchVC?.searchBar.searchTextField.textColor = .hex_9b4400
            // 字号
            searchVC?.searchBar.searchTextField.font = UIFont.systemFont(ofSize: 13, weight: .medium)
            // 背景色
            searchVC?.searchBar.searchTextField.backgroundColor = .hex_edd1d8
            // 光标色
            searchVC?.searchBar.searchTextField.tintColor = .random
            // 圆角
            searchVC?.searchBar.layer.cornerRadius = 10
            searchVC?.searchBar.layer.masksToBounds = true
        }
        
        // FIXME: 热门搜索，可以改样式无法改内容，文字过长会变成...
        searchVC?.hotSearchHeader.text = "Popular Searches"
        searchVC?.hotSearchHeader.font = UIFont.init(font: .georgiaItalic, size: 13)
//        searchVC?.hotSearchTitle = "hot - 热门搜索热门搜索热门搜索"
        // FIXME: 历史搜索，无法改样式可以改内容，改样式不生效
        searchVC?.searchHistoryHeader.text = "History Searches - 搜索历史"
        searchVC?.searchHistoryHeader.font = UIFont.init(font: .georgiaItalic, size: 13)
//        searchVC?.searchHistoryTitle = "History Searches - 搜索历史搜索历史搜索历史"
        // 搜索历史个数
        searchVC?.searchHistoriesCount = 20
        // 是否展示搜索推荐
        searchVC?.searchSuggestionHidden = false
        
        // 其它属性见源码
//        ...
        
        searchVC?.delegate = self
        searchVC?.dataSource = self
        
        let nav = UINavigationController(rootViewController: searchVC!)
        // FIXME: 设置isTranslucent为false，否则tableview顶部会被遮挡
        nav.navigationBar.isTranslucent = false
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
        
        // FIXME: push方式不适合本项目
        // Set mode of show search view controller, default is `PYSearchViewControllerShowModeModal`
//        searchVC?.searchViewControllerShowMode = .modePush
//        self.navigationController?.pushViewController(searchVC!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "选择搜索历史风格（热门搜索为默认风格)" : "选择热门搜索风格（搜索历史为默认风格)"
    }
    
}

// MARK: - PYSearchViewControllerDelegate, 搜索事件相关
extension PYSearchExampleVC: PYSearchViewControllerDelegate {
    
    func searchViewController(_ searchViewController: PYSearchViewController!, searchTextDidChange searchBar: UISearchBar!, searchText: String!) {
        print("搜索内容发生改变: \(String(describing: searchText))")
        
        // 1.默认搜索推荐列表，刷新搜索推荐列表
        if searchText.count > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                var list:[String] = []
                for i in 0..<arc4random_uniform(5) + 10 {
                    let value = "Search suggestion \(i)"
                    list.append(value)
                }
                // FIXME: it is't effective when `searchSuggestionHidden` is NO or cell of suggestion view is custom.
                searchViewController.searchSuggestions = list
            }
        }
        
        // 2.自定义搜索推荐列表，搜索推荐列表随搜索内容的改变而变化
        self.segCount = searchText.count
        searchViewController.searchSuggestionView.reloadData()
    }
    
    func searchViewController(_ searchViewController: PYSearchViewController!, didSelectHotSearchAt index: Int, searchText: String!) {
        print("点击了热门搜索，次序: \(index)，内容: \(String(describing: searchText))")
        
        // 2.自定义搜索推荐列表，搜索推荐列表随搜索内容的改变而变化
        self.segCount = searchText.count
        searchViewController.searchSuggestionView.reloadData()
        
        searchViewController?.navigationController?.pushViewController(PYSearchResultVC(), animated: true)
    }
    
    func searchViewController(_ searchViewController: PYSearchViewController!, didSelectSearchHistoryAt index: Int, searchText: String!) {
        print("点击了搜索历史，次序: \(index)，内容: \(String(describing: searchText))")
        
        // 2.自定义搜索推荐列表，搜索推荐列表随搜索内容的改变而变化
        self.segCount = searchText.count
        searchViewController.searchSuggestionView.reloadData()
        
        searchViewController?.navigationController?.pushViewController(PYSearchResultVC(), animated: true)
    }
    
    func searchViewController(_ searchViewController: PYSearchViewController!, didSelectSearchSuggestionAt indexPath: IndexPath!, searchBar: UISearchBar!) {
        print("点击了搜索推荐，次序: \(String(describing: indexPath))，搜索栏: \(String(describing: searchBar))")
        
        searchViewController?.navigationController?.pushViewController(PYSearchResultVC(), animated: true)
    }
    
    func searchViewController(_ searchViewController: PYSearchViewController!, didSearchWith searchBar: UISearchBar!, searchText: String!) {
        print("搜索了内容: \(String(describing: searchText)), 搜索栏: \(String(describing: searchBar))")
    }
}

// MARK: - PYSearchViewControllerDataSource, 自定义搜索推荐列表
extension PYSearchExampleVC: PYSearchViewControllerDataSource {
    
    func numberOfSections(inSearchSuggestionView searchSuggestionView: UITableView!) -> Int {
        return 1
    }
    
    func searchSuggestionView(_ searchSuggestionView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.segCount
    }
    
    func searchSuggestionView(_ searchSuggestionView: UITableView!, cellForRowAt indexPath: IndexPath!) -> UITableViewCell! {
        let cell = UITableViewCell()
        
        cell.backgroundColor = .random
        cell.textLabel?.text = "搜索推荐 - \(indexPath.section) - \(indexPath.row)"
        
        return cell
    }
    
    func searchSuggestionView(_ searchSuggestionView: UITableView!, heightForRowAt indexPath: IndexPath!) -> CGFloat {
        return 44
    }
}
