//
//  HCSStarRatingVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/22.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class HCSStarRatingVC: BaseViewController {
    
    var heads:[String] = [
        "Default",
        "Half-star rating",
        "Custom Images",
        "No half-star images? No problem!",
        "Also renders template images!",
        "Accurate Half-star rating"
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        
        
    }
    
    //MARK: - lazyload
    
    //tableView
    lazy var tableView: UITableView = {
        let tabView = UITableView.init(frame: CGRect.init(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - SoftHeight), style: .grouped)
        tabView.backgroundColor = UIColor.sf.hexColor(hex: "#F5F6F9")
        tabView.separatorStyle = .singleLine
        tabView.showsVerticalScrollIndicator = false
        tabView.delegate = self
        tabView.dataSource = self
        return tabView
    }()
    
    

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension HCSStarRatingVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return heads.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 5 ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier:String = NSStringFromClass(StarRatingCell.self)
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? StarRatingCell
        if cell == nil {
            cell = StarRatingCell.init(style: .default, reuseIdentifier: identifier)
        }
        
        switch indexPath.section {
        case 0:
            cell?.rateView.value = 1
        case 1:
            cell?.rateView.value = 1.5
            cell?.rateView.allowsHalfStars = true
        case 2:
            cell?.rateView.value = 1.5
            cell?.rateView.tintColor = .systemRed
            cell?.rateView.allowsHalfStars = true
            cell?.rateView.emptyStarImage = UIImage(named: "heart-empty")?.withRenderingMode(.alwaysTemplate)
            cell?.rateView.halfStarImage = UIImage(named: "heart-half")?.withRenderingMode(.alwaysTemplate)
            cell?.rateView.filledStarImage = UIImage(named: "heart-full")?.withRenderingMode(.alwaysTemplate)
        case 3:
            cell?.rateView.value = 1.5
            cell?.rateView.tintColor = .systemRed
            cell?.rateView.allowsHalfStars = true
            cell?.rateView.emptyStarImage = UIImage(named: "heart-empty")?.withRenderingMode(.alwaysTemplate)
            cell?.rateView.filledStarImage = UIImage(named: "heart-full")?.withRenderingMode(.alwaysTemplate)
        case 4:
            cell?.rateView.maximumValue = 8
            cell?.rateView.value = 4
            cell?.rateView.tintColor = UIColor.sf.random
        case 5:
            cell?.rateView.value = 1.33333
            cell?.rateView.accurateHalfStars = true
            cell?.rateView.allowsHalfStars = true
            if indexPath.row == 1 {
                cell?.rateView.tintColor = .systemRed
                cell?.rateView.emptyStarImage = UIImage(named: "heart-empty")?.withRenderingMode(.alwaysTemplate)
                cell?.rateView.filledStarImage = UIImage(named: "heart-full")?.withRenderingMode(.alwaysTemplate)
            }
        default:
            break
        }
        
        cell?.resLabel.text = "\(cell!.rateView.value)"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return heads[section]
    }
    
}
