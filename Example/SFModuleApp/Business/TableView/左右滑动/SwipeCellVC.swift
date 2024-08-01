//
//  SwipeCellVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/22.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import HandyJSON
import SwipeCellKit

class SwipeCellVC: BaseViewController {
    
    var dataList: [SwipeModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
        
        let list = [
            ["name": "标题一", "sub": "plus or minus the number of rows moved into or out of that section"],
            ["name": "标题二", "sub": "Assertion failure in -[UITableView _Bug_Detected_In_Client_Of_UITableView_Invalid_Number_Of_Rows_In_Section:], UITableView.m:2620"],
            ["name": "标题三", "sub": "invalid number of rows in section 0. The number of rows contained in an existing section after the update (20) must be equal to the number of rows contained in that section before the update (20), plus or minus the number of rows inserted or deleted from that section (0 inserted, 1 deleted) and plus or minus the number of rows moved into or out of that section (0 moved in, 0 moved out)."],
            ["name": "标题四", "sub": "plus or minus the number of rows moved into or out of that section"],
            ["name": "标题五", "sub": "plus or minus the number of rows moved into or out of that section plus or minus the number of rows moved into or out of that section"],
            ["name": "标题六", "sub": "plus or minus the number of rows moved into or out of that section plus or minus the number of rows moved into or out of that section plus or minus the number of rows moved into or out of that section plus or minus the number of rows moved into or out of that section"],
            ["name": "标题七", "sub": "invalid number of rows in section 0. The number of rows contained in an existing section after the update (20) must be equal to the number of rows contained in that section before the update (20), plus or minus the number of rows inserted or deleted from that section (0 inserted, 1 deleted) and plus or minus the number of rows moved into or out of that section (0 moved in, 0 moved out)."],
            ["name": "标题八", "sub": "plus or minus the number of rows moved into or out of that section"],
            ["name": "标题九", "sub": "plus or minus the number of rows moved into or out of that section plus or minus the number of rows moved into or out of that section"],
            ["name": "标题十", "sub": "invalid number of rows in section 0. The number of rows contained in an existing section after the update (20) must be equal to the number of rows contained in that section before the update (20), plus or minus the number of rows inserted or deleted from that section (0 inserted, 1 deleted) and plus or minus the number of rows moved into or out of that section (0 moved in, 0 moved out)."],
        ]
        
        for (index, item) in list.enumerated() {
            let model = SwipeModel.deserialize(from: item)
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
        tabView.register(SwipeCell.self, forCellReuseIdentifier: "SwipeCell")
        return tabView
    }()

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SwipeCellVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwipeCell", for: indexPath) as! SwipeCell
        
        cell.nameLabel.text = dataList[indexPath.row].name
        cell.subLabel.text = dataList[indexPath.row].sub
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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

extension SwipeCellVC: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        //FIXME: 第一个SwipeAction回调里调用fulfill方法
        if orientation == .left {
            let read = SwipeAction(style: .default, title: "Read") { action, indexPath in
                print("Read")
                action.fulfill(with: .reset)
            }
            read.image = SFSymbol.symbol(name: "hand.raised.fingers.spread", tintColor: .random)
            read.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            read.hidesWhenSelected = true
            
            let set = SwipeAction(style: .default, title: "Lock") { action, indexPath in
                print("Lock")
//                action.fulfill(with: .reset)
            }
            set.image = SFSymbol.symbol(name: "lock.shield", tintColor: .random)
            set.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            set.hidesWhenSelected = true
            
            return [read, set]
        } else {
            let flag = SwipeAction(style: .default, title: "Flag") { action, indexPath in
                print("Flag111")
                self.dataList.remove(at: indexPath.row)
                action.fulfill(with: .delete)
            }
            flag.image = SFSymbol.symbol(name: "flag.checkered", tintColor: .random)
            flag.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            flag.hidesWhenSelected = true
            
            let delete = SwipeAction(style: .default, title: "Delete") { action, indexPath in
                print("Delete111")
            }
            delete.image = SFSymbol.symbol(name: "minus.diamond", tintColor: .random)
            delete.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            delete.hidesWhenSelected = true
            
            let more = SwipeAction(style: .destructive, title: "More") { action, indexPath in
                print("More111")
            }
            more.image = SFSymbol.symbol(name: "ellipsis.curlybraces", tintColor: .random)
            more.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
            more.hidesWhenSelected = true
            
            return [flag, delete, more]
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle =  indexPath.row == 0 ? .destructive : (indexPath.row == 1 ? .destructiveAfterFill : (indexPath.row == 2 ? .fill : (indexPath.row == 3 ? .selection : .destructive(automaticallyDelete: true))))
        options.transitionStyle = indexPath.row == 0 ? .border : (indexPath.row == 1 ? .drag : .reveal)
        options.backgroundColor = orientation == .left ? #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1) : #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        options.buttonSpacing = 4
        return options
    }
    
    
}
