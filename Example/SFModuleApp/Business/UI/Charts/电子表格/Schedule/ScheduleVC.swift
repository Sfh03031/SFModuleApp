//
//  ScheduleVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/26.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SpreadsheetView

class ScheduleVC: BaseViewController {

    var spreadsheetView = SpreadsheetView(frame: CGRect(x: 10, y: TopHeight, width: SCREENW - 20, height: SCREENH - TopHeight - SoftHeight))
    
    let dates = ["4/22/2024", "4/23/2024", "4/24/2024", "4/25/2024", "4/26/2024", "4/27/2024", "4/28/2024"]
    let days = ["MONDAY", "TUESDAY", "WEDNSDAY", "THURSDAY", "FRIDAY", "SATURDAY", "SUNDAY"]
    let dayColors = [UIColor(red: 0.918, green: 0.224, blue: 0.153, alpha: 1),
                     UIColor(red: 0.106, green: 0.541, blue: 0.827, alpha: 1),
                     UIColor(red: 0.200, green: 0.620, blue: 0.565, alpha: 1),
                     UIColor(red: 0.953, green: 0.498, blue: 0.098, alpha: 1),
                     UIColor(red: 0.400, green: 0.584, blue: 0.141, alpha: 1),
                     UIColor(red: 0.835, green: 0.655, blue: 0.051, alpha: 1),
                     UIColor(red: 0.153, green: 0.569, blue: 0.835, alpha: 1)]
    let hours = ["6:00 AM", "7:00 AM", "8:00 AM", "9:00 AM", "10:00 AM", "11:00 AM", "12:00 AM", "1:00 PM", "2:00 PM",
                 "3:00 PM", "4:00 PM", "5:00 PM", "6:00 PM", "7:00 PM", "8:00 PM", "9:00 PM", "10:00 PM", "11:00 PM"]
    let evenRowColor = UIColor(red: 0.914, green: 0.914, blue: 0.906, alpha: 1)
    let oddRowColor: UIColor = .white
    let data = [
        ["", "", "按时吃药", "", "", "", "", "", "", "", "", "", "", "看电影", "", "", "", "", "", ""],
        ["去杭州出差", "", "", "", "", "与老板吃饭", "", "", "", "", "", "", "", "", "", "", "", "", "", ""],
        ["", "", "", "", "钓鱼", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""],
        ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "看演唱会", "", "", ""],
        ["", "", "", "", "", "烧烤聚会", "", "", "", "", "", "", "", "", "", "", "", "", "", ""],
        ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""],
        ["", "", "", "", "", "", "", "", "", "", "", "", "", "回家", "", "", "", "", "", ""]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(spreadsheetView)
        
        spreadsheetView.dataSource = self
        spreadsheetView.delegate = self
        spreadsheetView.layer.borderWidth = 1
        spreadsheetView.layer.borderColor = UIColor.flatOrange.cgColor
        spreadsheetView.scrollView.isScrollEnabled = false
        spreadsheetView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)

        spreadsheetView.intercellSpacing = CGSize(width: 4, height: 1)
        spreadsheetView.gridStyle = .none

        spreadsheetView.register(DateCell.self, forCellWithReuseIdentifier: String(describing: DateCell.self))
        spreadsheetView.register(TimeTitleCell.self, forCellWithReuseIdentifier: String(describing: TimeTitleCell.self))
        spreadsheetView.register(TimeCell.self, forCellWithReuseIdentifier: String(describing: TimeCell.self))
        spreadsheetView.register(DayTitleCell.self, forCellWithReuseIdentifier: String(describing: DayTitleCell.self))
        spreadsheetView.register(ScheduleCell.self, forCellWithReuseIdentifier: String(describing: ScheduleCell.self))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        spreadsheetView.flashScrollIndicators()
        ScreenRotator.shared.isLockOrientationWhenDeviceOrientationDidChange = false
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        // 🌰🌰🌰：竖屏 --> 横屏
        
        // 当屏幕发生旋转时，系统会自动触发该函数，`size`为【旋转之后】的屏幕尺寸
        print("size \(size)") // --- (926.0, 428.0)
        // 或者通过`UIScreen`也能获取【旋转之后】的屏幕尺寸
        print("mainScreen \(UIScreen.main.bounds.size)") // --- (926.0, 428.0)

        // 📢 注意：如果想通过`self.xxx`去获取屏幕相关的信息（如`self.view.frame`），【此时】获取的尺寸还是【旋转之前】的尺寸
        print("----------- 屏幕即将旋转 -----------")
        print("view.size \(view.frame.size)") // - (428.0, 926.0)
        print("window.size \(view.window?.bounds.size ?? .zero)") // - (428.0, 926.0)
        print("window.safeAreaInsets \(view.window?.safeAreaInsets ?? .zero)") // - UIEdgeInsets(top: 47.0, left: 0.0, bottom: 34.0, right: 0.0)
        
        // 📢 想要获取【旋转之后】的屏幕信息，需要到`Runloop`的下一个循环才能获取
        DispatchQueue.main.async {
            print("----------- 屏幕已经旋转 -----------")
            print("view.size \(self.view.frame.size)") // - (926.0, 428.0)
            print("window.size \(self.view.window?.bounds.size ?? .zero)") // - (926.0, 428.0)
            print("window.safeAreaInsets \(self.view.window?.safeAreaInsets ?? .zero)") // - UIEdgeInsets(top: 0.0, left: 47.0, bottom: 21.0, right: 47.0)
            print("==================================")
            
            if ScreenRotator.shared.isPortrait {
                self.spreadsheetView.frame = CGRect(x: 10, y: TopHeight, width: SCREENW - 20, height: SCREENH - TopHeight - SoftHeight)
            } else {
                self.spreadsheetView.frame = CGRect(x: 40, y: TopHeight, width: SCREENW - 80, height: SCREENH - TopHeight - SoftHeight)
            }
        }
    }

}

extension ScheduleVC: SpreadsheetViewDelegate, SpreadsheetViewDataSource {
    // MARK: DataSource

    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1 + days.count
    }

    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1 + 1 + hours.count
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        if case 0 = column {
            return 70
        } else {
            return 120
        }
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        if case 0 = row {
            return 24
        } else if case 1 = row {
            return 32
        } else {
            return 40
        }
    }

    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }

    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 2
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        if case (1...(dates.count + 1), 0) = (indexPath.column, indexPath.row) {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: DateCell.self), for: indexPath) as! DateCell
            cell.label.text = dates[indexPath.column - 1]
            return cell
        } else if case (1...(days.count + 1), 1) = (indexPath.column, indexPath.row) {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: DayTitleCell.self), for: indexPath) as! DayTitleCell
            cell.label.text = days[indexPath.column - 1]
            cell.label.textColor = dayColors[indexPath.column - 1]
            return cell
        } else if case (0, 1) = (indexPath.column, indexPath.row) {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: TimeTitleCell.self), for: indexPath) as! TimeTitleCell
            cell.label.text = "TIME"
            return cell
        } else if case (0, 2...(hours.count + 2)) = (indexPath.column, indexPath.row) {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: TimeCell.self), for: indexPath) as! TimeCell
            cell.label.text = hours[indexPath.row - 2]
            cell.backgroundColor = indexPath.row % 2 == 0 ? evenRowColor : oddRowColor
            return cell
        } else if case (1...(days.count + 1), 2...(hours.count + 2)) = (indexPath.column, indexPath.row) {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: ScheduleCell.self), for: indexPath) as! ScheduleCell
            let text = data[indexPath.column - 1][indexPath.row - 2]
            if !text.isEmpty {
                cell.label.text = text
                let color = dayColors[indexPath.column - 1]
                cell.label.textColor = color
                cell.color = color.withAlphaComponent(0.2)
                cell.borders.top = .solid(width: 2, color: color)
                cell.borders.bottom = .solid(width: 2, color: color)
            } else {
                cell.label.text = nil
                cell.color = indexPath.row % 2 == 0 ? evenRowColor : oddRowColor
                cell.borders.top = .none
                cell.borders.bottom = .none
            }
            return cell
        }
        return nil
    }

    /// Delegate

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath) {
        print("Selected: (row: \(indexPath.row), column: \(indexPath.column))")
    }
}
