//
//  MarqueeTableVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/25.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class MarqueeTableVC: UITableViewController {
    
    let strings = [
        "4月23日，恒大地产集团有限公司新增23条被执行人信息，执行标的合计2.74亿余元,涉及服务合同纠纷、保理合同纠纷等案件，",
        "部分案件被执行人还包括恒大地产集团济南置业有限公司、合肥恒瑞置业有限公司、林州市城投宝利金房地产开发有限公司等",
        "风险信息显示，恒大地产集团有限公司现存680余条被执行人信息，被执行总金额超526亿元。",
        "今年是《西部陆海新通道总体规划》实施的第5年。5年来，这条国际物流大通道加速延伸，跨越山海，联结世界，铺就崭新的发展通途。",
        "西部陆海新通道以重庆为运营中心，各西部省区市为关键节点，利用铁路、海运、公路等运输方式，向南经广西、云南等沿海沿边口岸通达世界各地。",
        "2017年9月，西部陆海新通道的前身——渝黔桂新“南向通道”班列从重庆团结村中心站驶出，标志着该班列实现常态化运输。此后，“第一个1万列”用时1461天，“第二个1万列”用时487天，“第三个1万列”用时402天……西部陆海新通道“万列”完成时间进程不断缩短。"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarInsets = UIEdgeInsets(top: TopHeight, left: 0.0, bottom: SoftHeight, right: 0.0)
        tableView.contentInset = tabBarInsets
        tableView.scrollIndicatorInsets = tabBarInsets
        tableView.separatorStyle = .singleLine
        
        tableView.register(MarqueeTableCell.self, forCellReuseIdentifier: "MarqueeTableCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarqueeTableCell", for: indexPath) as! MarqueeTableCell
        
        cell.label.text = strings[Int(arc4random_uniform(UInt32(strings.count)))]
        cell.label.type = .continuous
        cell.label.speed = .duration(15)
        cell.label.animationCurve = .easeInOut
        cell.label.fadeLength = 10.0
        cell.label.leadingBuffer = 14.0
        
        // Labelize normally, to improve scroll performance
        cell.label.labelize = true
        
        // Set background, to improve scroll performance
        cell.backgroundColor = UIColor.white
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! MarqueeTableCell
        
        // De-labelize on selection
        cell.label.labelize = false
    }
    
    /// Re-labelize all scrolling labels on tableview scroll
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        for cell in tableView.visibleCells as! [MarqueeTableCell] {
//            cell.label.labelize = true
//        }
    }


}
