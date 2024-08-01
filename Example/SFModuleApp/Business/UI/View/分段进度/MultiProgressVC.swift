//
//  MultiProgressVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/6/4.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class MultiProgressVC: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)
    }
    
    // MARK: - lazyload
    
    // tableView
    lazy var tableView: UITableView = {
        let tabView = UITableView(frame: CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - BottomHeight), style: .grouped)
        tabView.backgroundColor = .clear
        tabView.separatorStyle = .none
        tabView.showsVerticalScrollIndicator = false
        tabView.delegate = self
        tabView.dataSource = self
        return tabView
    }()
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MultiProgressVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)

        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Single Progress View (Programmatic)"
        case 1:
            cell.textLabel?.text = "Multiple Progress Views (Storyboard)"
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(StorageExampleViewController(), animated: true)
        case 1:
            let storyboard = UIStoryboard(name: "LanguageExample", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "LanguageExampleViewController")
            self.navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
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
