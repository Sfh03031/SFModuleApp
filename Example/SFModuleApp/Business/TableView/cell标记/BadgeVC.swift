//
//  BadgeVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/22.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import TDBadgedCell

class BadgeVC: BaseViewController {

    var dataList: [BadgeModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
        
        let list = [
            ["name": "标题一", "sub": "plus or minus the number of rows moved into or out of that section", "badge": "1"],
            ["name": "标题二", "sub": "Assertion failure in -[UITableView _Bug_Detected_In_Client_Of_UITableView_Invalid_Number_Of_Rows_In_Section:], UITableView.m:2620", "badge": "123"],
            ["name": "标题三", "sub": "invalid number of rows in section 0. The number of rows contained in an existing section after the update (20) must be equal to the number of rows contained in that section before the update (20), plus or minus the number of rows inserted or deleted from that section (0 inserted, 1 deleted) and plus or minus the number of rows moved into or out of that section (0 moved in, 0 moved out).", "badge": "Warning!"],
            ["name": "标题四", "sub": "plus or minus the number of rows moved into or out of that section", "badge": "Danger!"],
            ["name": "标题五", "sub": "plus or minus the number of rows moved into or out of that section plus or minus the number of rows moved into or out of that section", "badge": "1!"],
            ["name": "标题六", "sub": "plus or minus the number of rows moved into or out of that section plus or minus the number of rows moved into or out of that section plus or minus the number of rows moved into or out of that section plus or minus the number of rows moved into or out of that section", "badge": "※"],
            ["name": "标题七", "sub": "invalid number of rows in section 0. The number of rows contained in an existing section after the update (20) must be equal to the number of rows contained in that section before the update (20), plus or minus the number of rows inserted or deleted from that section (0 inserted, 1 deleted) and plus or minus the number of rows moved into or out of that section (0 moved in, 0 moved out).", "badge": "XXX"],
            ["name": "标题八", "sub": "plus or minus the number of rows moved into or out of that section", "badge": "badge"],
            ["name": "标题九", "sub": "plus or minus the number of rows moved into or out of that section plus or minus the number of rows moved into or out of that section", "badge": "22"],
            ["name": "标题十", "sub": "invalid number of rows in section 0. The number of rows contained in an existing section after the update (20) must be equal to the number of rows contained in that section before the update (20), plus or minus the number of rows inserted or deleted from that section (0 inserted, 1 deleted) and plus or minus the number of rows moved into or out of that section (0 moved in, 0 moved out).", "badge": "666"],
        ]
        
        for (index, item) in list.enumerated() {
            let model = BadgeModel.deserialize(from: item)
            dataList.append(model!)
        }
        
        tableView.reloadData()
    }
    

    //MARK: - lazyload
    
    //tableView
    lazy var tableView: UITableView = {
        let tabView = UITableView.init(frame: CGRect.init(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - SoftHeight), style: .grouped)
        tabView.backgroundColor = .clear
        tabView.separatorStyle = .singleLine
        tabView.showsVerticalScrollIndicator = false
        tabView.delegate = self
        tabView.dataSource = self
        tabView.allowsSelection = true
        tabView.allowsMultipleSelectionDuringEditing = true
        tabView.register(BadgeCell.self, forCellReuseIdentifier: "BadgeCell")
        return tabView
    }()

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension BadgeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BadgeCell", for: indexPath) as! BadgeCell
        
        cell.textLabel?.text = dataList[indexPath.row].name
        cell.detailTextLabel?.text = dataList[indexPath.row].sub
        cell.badgeString = dataList[indexPath.row].badge ?? ""
        
        switch indexPath.row {
        case 0:
            cell.accessoryType = .disclosureIndicator
        case 1:
            cell.badgeColor = .lightGray
            cell.badgeTextColor = .black
            cell.accessoryType = .checkmark
        case 2:
            cell.badgeColor = .orange
        case 3:
            cell.badgeColor = .red
        case 4:
            cell.badgeTextOffset = 5.0
        default:
            cell.badgeColor = .random
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFLOAT_MIN
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFLOAT_MIN
    }
    
}
