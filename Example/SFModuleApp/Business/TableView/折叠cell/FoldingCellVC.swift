//
//  FoldingCellVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/29.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import FoldingCell

enum Const {
    static let closeCellHeight: CGFloat = 120
    static let openCellHeight: CGFloat = 420
    static let rowsCount = 10
}



class FoldingCellVC: BaseViewController {
    
    var cellHeights: [CGFloat] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellHeights = Array(repeating: Const.closeCellHeight, count: Const.rowsCount)
        
        self.view.addSubview(tableView)
    }
    
    @objc func refreshHandler() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
            self?.tableView.refreshControl?.endRefreshing()
            self?.tableView.reloadData()
        })
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
        tabView.refreshControl = UIRefreshControl()
        tabView.refreshControl?.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
        return tabView
    }()

}

extension FoldingCellVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 10
    }

    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as FoldExpandCell = cell else {
            return
        }

        cell.backgroundColor = .clear

        if cellHeights[indexPath.row] == Const.closeCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FoldExpandCell.self), for: indexPath) as! FoldExpandCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        return cell
    }

    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell

        if cell.isAnimating() {
            return
        }

        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == Const.closeCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = Const.openCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = Const.closeCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }

        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            
            // fix https://github.com/Ramotion/folding-cell/issues/169
            if cell.frame.maxY > tableView.frame.maxY {
                tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            }
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFLOAT_MIN
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFLOAT_MIN
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}
