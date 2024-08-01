//
//  SLB_LearnDataVC.swift
//  SparkBase
//
//  Created by Apple on 2021/7/6.
//  Copyright © 2021 Spark. All rights reserved.
//

import UIKit
import SwiftyJSON

class SLB_LearnDataVC: LFBaseViewController {
    
    var key:String = ""
    var type : String = "1" // 1智能书模考 2简听力 3词汇星火式巧记速记

    lazy var tableView: UITableView = UITableView(frame: CGRect.zero, style: .plain)
    
    var learnDate: String = ""
    var learnDuration: String = ""
    var learnAccuracy: Int = 0
    
    var tcxAxisArr: [String] = [] //横坐标
    var tcyAxisArr: [Double] = [] //纵坐标
    var tcyValueArr: [Double] = [] //点
    
    var rcxAxisArr: [String] = [] //横坐标
    var rcyAxisArr: [Double] = [] //纵坐标
    var rcyValueArr: [Double] = [] //点
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "学习数据"
        self.view.backgroundColor = UIColor.sf.hexColor(hex: "#F5F5F9")
        
        tableView.frame = CGRect.init(x: 0, y: TopHeight, width: view.bounds.width, height: view.bounds.height-TopHeight)
        tableView.backgroundColor = UIColor.sf.hexColor(hex: "#F5F5F9")
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 60
        view.addSubview(tableView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.loadLearnData()
            self.loadTimeChartsData(type: "0", isUpdate: false)
            self.loadRateChartsData(type: "0", isUpdate: false)
            self.tableView.reloadData()
        }
        
    }
    
    //MARK: 学习情况
    func loadLearnData() {
        
        self.learnDate = "2024年·04月19日"
        self.learnDuration = "10小时45分钟"
        self.learnAccuracy = 85
        self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .fade)
        
//        SVProgressHUD.show()
//        XHNetWorking.share().getRequestWithURL("smartBook/learnStatistics", parameters: ["key":self.key], successBlock: { (response, task) in
//            SVProgressHUD.dismiss()
//            let dict = JSON(response as Any)
//            if dict["code"].intValue == RETURN_OK {
//                let results = dict["results"]
//                if results["ret"].intValue == RET_OK {
//                    let res = results["body"].dictionaryObject!
//                    self.learnDate = res["curDate"] as! String
//                    self.learnDuration = res["curDuration"] as! String
//                    self.learnAccuracy = res["curAccuracy"] as! Int
//                    self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .fade)
//                }
//            }
//        }, faildBlock: { (error, task) in
//            SVProgressHUD.dismiss()
//        })
    }
    //MARK: 时长
    func loadTimeChartsData(type: String, isUpdate: Bool) {
        
        let cell:LDTimeChartsCell = self.tableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! LDTimeChartsCell
        self.tcxAxisArr = []
        self.tcyAxisArr = []
        self.tcyValueArr = []
        if type == "0" {// 按天
            let res = [
                ["name": "04.13", "value": "100"],
                ["name": "04.14", "value": "585"],
                ["name": "04.15", "value": "990"],
                ["name": "04.16", "value": "1280"],
                ["name": "04.17", "value": "1800"],
                ["name": "04.18", "value": "2855"],
                ["name": "04.19", "value": "3400"],
            ]
            
            for i in 0..<res.count {
                if let model = ChartModel.deserialize(from: res[i] as [String: Any]) {
                    self.tcxAxisArr.append(model.name ?? "")
                    let value = ((model.value ?? "") as NSString).doubleValue
                    let hour = String.init(format: "%.2f", value/3600)
                    self.tcyValueArr.append((hour as NSString).doubleValue)
                }
            }
            
            let ll = self.tcyValueArr.max()
            if ll == 0.0 {
                self.tcyAxisArr = [0, 0.2, 0.4, 0.6, 0.8, 1.0]
            } else {
                let marg = ceil(ll!)/5
                for i in 0..<6 {
                    let sum = marg * Double(i)
                    let yval = String.init(format: "%.1f", sum)
                    self.tcyAxisArr.append((yval as NSString).doubleValue)
                }
            }
            if isUpdate {
                cell.updateChart(xAxisArr: self.tcxAxisArr, yAxisArr: self.tcyAxisArr, yValues: self.tcyValueArr, type: .bySenveDays)
            } else {
                cell.initChart(xAxisArr: self.tcxAxisArr,  yAxisArr: self.tcyAxisArr, yValues: self.tcyValueArr, type: .bySenveDays)
            }
        } else {// 按月
            
            let res = [
                ["name": "03.21", "value": "200"],
                ["name": "03.22", "value": "400"],
                ["name": "03.23", "value": "600"],
                ["name": "03.24", "value": "800"],
                ["name": "03.25", "value": "1000"],
                ["name": "03.26", "value": "1200"],
                ["name": "03.27", "value": "1400"],
                ["name": "03.28", "value": "1600"],
                ["name": "03.29", "value": "1800"],
                ["name": "03.23", "value": "2000"],
                ["name": "03.24", "value": "2200"],
                ["name": "03.25", "value": "2400"],
                ["name": "03.26", "value": "2600"],
                ["name": "03.27", "value": "2800"],
                ["name": "03.28", "value": "3000"],
                ["name": "03.29", "value": "3200"],
                ["name": "03.30", "value": "3400"],
                ["name": "03.31", "value": "3600"],
                ["name": "04.01", "value": "3800"],
                ["name": "04.02", "value": "4000"],
                ["name": "04.03", "value": "4200"],
                ["name": "04.04", "value": "4800"],
                ["name": "04.05", "value": "5200"],
                ["name": "04.06", "value": "5600"],
                ["name": "04.07", "value": "6000"],
                ["name": "04.08", "value": "6400"],
                ["name": "04.09", "value": "6800"],
                ["name": "04.10", "value": "7300"],
                ["name": "04.11", "value": "7800"],
                ["name": "04.12", "value": "8500"],
                ["name": "04.13", "value": "9000"],
                ["name": "04.14", "value": "10000"],
                ["name": "04.15", "value": "11000"],
                ["name": "04.16", "value": "12000"],
                ["name": "04.17", "value": "14000"],
                ["name": "04.18", "value": "16000"],
                ["name": "04.19", "value": "18000"],
            ]
            
            for i in 0..<res.count {
                if let model = ChartModel.deserialize(from: res[i] as [String: Any]) {
                    if i==res.count-26 || i==res.count-21 || i==res.count-16 || i==res.count-11 || i==res.count-6 || i==res.count-1 {
                        self.tcxAxisArr.append(model.name ?? "")
                    } else {
                        self.tcxAxisArr.append("")
                    }
                    let value = ((model.value ?? "") as NSString).doubleValue
                    let hour: String = String.init(format: "%.2f", value/3600)
                    self.tcyValueArr.append((hour as NSString).doubleValue)
                }
                
            }
            
            let ll = self.tcyValueArr.max()
            if ll == 0.0 {
                self.tcyAxisArr = [0, 0.2, 0.4, 0.6, 0.8, 1.0]
            } else {
                let marg = ceil(ll!)/5
                for i in 0..<6 {
                    let sum = marg * Double(i)
                    let yval = String.init(format: "%.1f", sum)
                    self.tcyAxisArr.append((yval as NSString).doubleValue)
                }
            }
            
            if isUpdate {
                cell.updateChart(xAxisArr: self.tcxAxisArr, yAxisArr: self.tcyAxisArr, yValues: self.tcyValueArr, type: .byMonth)
            } else {
                cell.initChart(xAxisArr: self.tcxAxisArr, yAxisArr: self.tcyAxisArr, yValues: self.tcyValueArr, type: .byMonth)
            }
            
        }
        
//        SVProgressHUD.show()
//        XHNetWorking.share().getRequestWithURL("smartBook/learnDurationDetail", parameters: ["key":self.key, "type": type], successBlock: { (response, task) in
//            SVProgressHUD.dismiss()
//            let dict = JSON(response as Any)
//            if dict["code"].intValue == RETURN_OK {
//                let results = dict["results"]
//                if results["ret"].intValue == RET_OK {
//                    let res = results["list"].arrayObject!
//                    let cell:LDTimeChartsCell = self.tableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! LDTimeChartsCell
//                    self.tcxAxisArr = []
//                    self.tcyAxisArr = []
//                    self.tcyValueArr = []
//                    if type == "0" {// 按天
//                        for i in 0..<res.count {
//                            let model:chartModel = chartModel.init(dataDict: res[i] as! [String: Any])
//                            self.tcxAxisArr.append(model.name)
//                            let value = (model.value as NSString).doubleValue
//                            let hour = String.init(format: "%.2f", value/3600)
//                            self.tcyValueArr.append((hour as NSString).doubleValue)
//                        }
//                        
//                        let ll = self.tcyValueArr.max()
//                        if ll == 0.0 {
//                            self.tcyAxisArr = [0, 0.2, 0.4, 0.6, 0.8, 1.0]
//                        } else {
//                            let marg = ceil(ll!)/5
//                            for i in 0..<6 {
//                                let sum = marg * Double(i)
//                                let yval = String.init(format: "%.1f", sum)
//                                self.tcyAxisArr.append((yval as NSString).doubleValue)
//                            }
//                        }
//                        if isUpdate {
//                            cell.updateChart(xAxisArr: self.tcxAxisArr, yAxisArr: self.tcyAxisArr, yValues: self.tcyValueArr, type: .bySenveDays)
//                        } else {
//                            cell.initChart(xAxisArr: self.tcxAxisArr,  yAxisArr: self.tcyAxisArr, yValues: self.tcyValueArr, type: .bySenveDays)
//                        }
//                    } else {// 按月
//                        for i in 0..<res.count {
//                            let model:chartModel = chartModel.init(dataDict: res[i] as! [String: Any])
//                            if i==res.count-26 || i==res.count-21 || i==res.count-16 || i==res.count-11 || i==res.count-6 || i==res.count-1 {
//                                self.tcxAxisArr.append(model.name)
//                            } else {
//                                self.tcxAxisArr.append("")
//                            }
//                            let value = (model.value as NSString).doubleValue
//                            let hour: String = String.init(format: "%.2f", value/3600)
//                            self.tcyValueArr.append((hour as NSString).doubleValue)
//                        }
//                        
//                        let ll = self.tcyValueArr.max()
//                        if ll == 0.0 {
//                            self.tcyAxisArr = [0, 0.2, 0.4, 0.6, 0.8, 1.0]
//                        } else {
//                            let marg = ceil(ll!)/5
//                            for i in 0..<6 {
//                                let sum = marg * Double(i)
//                                let yval = String.init(format: "%.1f", sum)
//                                self.tcyAxisArr.append((yval as NSString).doubleValue)
//                            }
//                        }
//                        
//                        if isUpdate {
//                            cell.updateChart(xAxisArr: self.tcxAxisArr, yAxisArr: self.tcyAxisArr, yValues: self.tcyValueArr, type: .byMonth)
//                        } else {
//                            cell.initChart(xAxisArr: self.tcxAxisArr, yAxisArr: self.tcyAxisArr, yValues: self.tcyValueArr, type: .byMonth)
//                        }
//                        
//                    }
//                }
//            }
//        }, faildBlock: { (error, task) in
//            SVProgressHUD.dismiss()
//        })
    }
    //MARK: 正确率
    func loadRateChartsData(type: String, isUpdate: Bool) {//0:按天，1：按月
        
        let cell:LDRateChartsCell = self.tableView.cellForRow(at: IndexPath.init(row: 2, section: 0)) as! LDRateChartsCell
        if type == "0" {
            let res = [
                ["name": "04.13", "value": "1"],
                ["name": "04.14", "value": "10"],
                ["name": "04.15", "value": "35"],
                ["name": "04.16", "value": "50"],
                ["name": "04.17", "value": "67"],
                ["name": "04.18", "value": "78"],
                ["name": "04.19", "value": "99"],
            ]
            
            for i in 0..<res.count {
                if let model = ChartModel.deserialize(from: res[i] as [String: Any]) {
                    self.rcxAxisArr.append(model.name ?? "")
                    self.rcyValueArr.append(((model.value ?? "") as NSString).doubleValue)
                }
            }
            if isUpdate {
                cell.updateChart(xAxisArr: self.rcxAxisArr, yValues: self.rcyValueArr, type: .bySenveDays)
            } else {
                cell.initChart(xAxisArr: self.rcxAxisArr, yValues: self.rcyValueArr, type: .bySenveDays)
            }
            
        } else {
            let res = [
                ["name": "03.21", "value": "1"],
                ["name": "03.22", "value": "2"],
                ["name": "03.23", "value": "4"],
                ["name": "03.24", "value": "8"],
                ["name": "03.25", "value": "16"],
                ["name": "03.26", "value": "32"],
                ["name": "03.27", "value": "64"],
                ["name": "03.28", "value": "100"],
                ["name": "03.29", "value": "64"],
                ["name": "03.23", "value": "32"],
                ["name": "03.24", "value": "16"],
                ["name": "03.25", "value": "8"],
                ["name": "03.26", "value": "4"],
                ["name": "03.27", "value": "2"],
                ["name": "03.28", "value": "1"],
                ["name": "03.29", "value": "10"],
                ["name": "03.30", "value": "15"],
                ["name": "03.31", "value": "20"],
                ["name": "04.01", "value": "30"],
                ["name": "04.02", "value": "40"],
                ["name": "04.03", "value": "50"],
                ["name": "04.04", "value": "60"],
                ["name": "04.05", "value": "70"],
                ["name": "04.06", "value": "74"],
                ["name": "04.07", "value": "78"],
                ["name": "04.08", "value": "80"],
                ["name": "04.09", "value": "85"],
                ["name": "04.10", "value": "90"],
                ["name": "04.11", "value": "90"],
                ["name": "04.12", "value": "90"],
                ["name": "04.13", "value": "90"],
                ["name": "04.14", "value": "100"],
                ["name": "04.15", "value": "85"],
                ["name": "04.16", "value": "84"],
                ["name": "04.17", "value": "83"],
                ["name": "04.18", "value": "82"],
                ["name": "04.19", "value": "81"],
            ]
            for i in 0..<res.count {
                if let model = ChartModel.deserialize(from: res[i] as [String: Any]) {
                    if i==res.count-26 || i==res.count-21 || i==res.count-16 || i==res.count-11 || i==res.count-6 || i==res.count-1 {
                        self.rcxAxisArr.append(model.name ?? "")
                    } else {
                        self.rcxAxisArr.append("")
                    }
                    self.rcyValueArr.append(((model.value ?? "") as NSString).doubleValue)
                }
            }
            if isUpdate {
                cell.updateChart(xAxisArr: self.rcxAxisArr, yValues: self.rcyValueArr, type: .byMonth)
            } else {
                cell.initChart(xAxisArr: self.rcxAxisArr, yValues: self.rcyValueArr, type: .byMonth)
            }
            
        }
        
//        SVProgressHUD.show()
//        XHNetWorking.share().getRequestWithURL("smartBook/learnAccuracyDetail", parameters: ["key":self.key, "type": type], successBlock: { (response, task) in
//            SVProgressHUD.dismiss()
//            let dict = JSON(response as Any)
//            if dict["code"].intValue == RETURN_OK {
//                let results = dict["results"]
//                if results["ret"].intValue == RET_OK {
//                    let res = results["list"].arrayObject!
//                    let cell:LDRateChartsCell = self.tableView.cellForRow(at: IndexPath.init(row: 2, section: 0)) as! LDRateChartsCell
//                    if type == "0" {
//                        for i in 0..<res.count {
//                            let model:chartModel = chartModel.init(dataDict: res[i] as! [String: Any])
//                            self.rcxAxisArr.append(model.name)
//                            self.rcyValueArr.append((model.value as NSString).doubleValue)
//                        }
//                        if isUpdate {
//                            cell.updateChart(xAxisArr: self.rcxAxisArr, yValues: self.rcyValueArr, type: .bySenveDays)
//                        } else {
//                            cell.initChart(xAxisArr: self.rcxAxisArr, yValues: self.rcyValueArr, type: .bySenveDays)
//                        }
//                        
//                    } else {
//                        for i in 0..<res.count {
//                            let model:chartModel = chartModel.init(dataDict: res[i] as! [String: Any])
//                            if i==res.count-26 || i==res.count-21 || i==res.count-16 || i==res.count-11 || i==res.count-6 || i==res.count-1 {
//                                self.rcxAxisArr.append(model.name)
//                            } else {
//                                self.rcxAxisArr.append("")
//                            }
//                            self.rcyValueArr.append((model.value as NSString).doubleValue)
//                        }
//                        if isUpdate {
//                            cell.updateChart(xAxisArr: self.rcxAxisArr, yValues: self.rcyValueArr, type: .byMonth)
//                        } else {
//                            cell.initChart(xAxisArr: self.rcxAxisArr, yValues: self.rcyValueArr, type: .byMonth)
//                        }
//                        
//                    }
//                }
//            }
//        }, faildBlock: { (error, task) in
//            SVProgressHUD.dismiss()
//        })
    }
}

extension SLB_LearnDataVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 140
        } else if indexPath.row == 1 {
            return 295
        } else {
            return 335
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {//今日学习情况
            let identifier:String = "LDTodayCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LDTodayCell
            if cell == nil {
                cell = LDTodayCell.init(style: .default, reuseIdentifier: identifier)
            }
            
            cell?.dateStr = self.learnDate
            cell?.timeStr = self.learnDuration
            cell?.rateStr = String(self.learnAccuracy)
            cell?.type = self.type
            
            return cell!
        } else if indexPath.row == 1 {//学习时长
            let identifier:String = "LDTimeChartsCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LDTimeChartsCell
            if cell == nil {
                cell = LDTimeChartsCell.init(style: .default, reuseIdentifier: identifier)
            }
            cell?.initChart(xAxisArr: tcxAxisArr, yAxisArr: tcyAxisArr, yValues: tcyValueArr, type: .bySenveDays)
            
            weak var weakSelf = self
            cell?.dayblock = {
                weakSelf?.tcxAxisArr.removeAll()
                weakSelf?.tcyValueArr.removeAll()
                weakSelf?.loadTimeChartsData(type: "0", isUpdate: true)
            }
            
            cell?.monthblock = {
                weakSelf?.tcxAxisArr.removeAll()
                weakSelf?.tcyValueArr.removeAll()
                weakSelf?.loadTimeChartsData(type: "1", isUpdate: true)
            }
            
            return cell!
        } else {//模考正确率
            let identifier:String = "LDRateChartsCell"

            var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LDRateChartsCell
            if cell == nil {
                cell = LDRateChartsCell.init(style: .default, reuseIdentifier: identifier)
            }
            
            cell?.type = self.type
            cell?.initChart(xAxisArr: rcxAxisArr, yValues: rcyValueArr, type: .bySenveDays)
            
            weak var weakSelf = self
            cell?.dayblock = {
                weakSelf?.rcxAxisArr.removeAll()
                weakSelf?.rcyValueArr.removeAll()
                weakSelf?.loadRateChartsData(type: "0", isUpdate: true)
            }
            
            cell?.monthblock = {
                weakSelf?.rcxAxisArr.removeAll()
                weakSelf?.rcyValueArr.removeAll()
                weakSelf?.loadRateChartsData(type: "1", isUpdate: true)
            }
            
            return cell!
        }
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
