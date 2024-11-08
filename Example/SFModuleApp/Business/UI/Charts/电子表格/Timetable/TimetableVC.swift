//
//  TimetableVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/26.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SpreadsheetView
import ScreenRotator

class TimetableVC: BaseViewController {

    var spreadsheetView = SpreadsheetView(frame: CGRect(x: 10, y: TopHeight, width: SCREENW - 20, height: SCREENH - TopHeight - SoftHeight))
    
    let channels = [
        "ABC", "NNN", "BBC", "J-Sports", "OK News", "SSS", "Apple", "CUK", "KKR", "APAR",
        "SU", "CCC", "Game", "Anime", "Tokyo NX", "NYC", "SAN", "Drama", "Hobby", "Music"]

    let numberOfRows = 24 * 60 + 1
    var slotInfo = [IndexPath: (Int, Int)]()

    let hourFormatter = DateFormatter()
    let twelveHourFormatter = DateFormatter()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(spreadsheetView)
        
        spreadsheetView.dataSource = self
        spreadsheetView.delegate = self

        spreadsheetView.register(HourCell.self, forCellWithReuseIdentifier: String(describing: HourCell.self))
        spreadsheetView.register(ChannelCell.self, forCellWithReuseIdentifier: String(describing: ChannelCell.self))
        spreadsheetView.register(UINib(nibName: String(describing: SlotCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: SlotCell.self))
        spreadsheetView.register(BlankCell.self, forCellWithReuseIdentifier: String(describing: BlankCell.self))
        spreadsheetView.scrollView.isScrollEnabled = false
        spreadsheetView.backgroundColor = .systemTeal
        
        let hairline = 1 / UIScreen.main.scale
        spreadsheetView.intercellSpacing = CGSize(width: hairline, height: hairline)
        spreadsheetView.gridStyle = .solid(width: hairline, color: .lightGray)
        spreadsheetView.circularScrolling = CircularScrolling.Configuration.horizontally.rowHeaderStartsFirstColumn

        hourFormatter.calendar = Calendar(identifier: .gregorian)
        hourFormatter.locale = Locale(identifier: "en_US_POSIX")
        hourFormatter.dateFormat = "h\na"

        twelveHourFormatter.calendar = Calendar(identifier: .gregorian)
        twelveHourFormatter.locale = Locale(identifier: "en_US_POSIX")
        twelveHourFormatter.dateFormat = "H"
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

extension TimetableVC: SpreadsheetViewDataSource, SpreadsheetViewDelegate {
    // MARK: DataSource

    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return channels.count + 1
    }

    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return numberOfRows
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        if column == 0 {
            return 30
        }
        return 130
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        if row == 0 {
            return 44
        }
        return 2
    }
    
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }

    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }

    func mergedCells(in spreadsheetView: SpreadsheetView) -> [CellRange] {
        var mergedCells = [CellRange]()

        for row in 0..<24 {
            mergedCells.append(CellRange(from: (60 * row + 1, 0), to: (60 * (row + 1), 0)))
        }

        let seeds = [5, 10, 20, 20, 30, 30, 30, 30, 40, 40, 50, 50, 60, 60, 60, 60, 90, 90, 90, 90, 120, 120, 120]
        for (index, _) in channels.enumerated() {
            var minutes = 0
            while minutes < 24 * 60 {
                let duration = seeds[Int(arc4random_uniform(UInt32(seeds.count)))]
                guard minutes + duration + 1 < numberOfRows else {
                    mergedCells.append(CellRange(from: (minutes + 1, index + 1), to: (numberOfRows - 1, index + 1)))
                    break
                }
                let cellRange = CellRange(from: (minutes + 1, index + 1), to: (minutes + duration + 1, index + 1))
                mergedCells.append(cellRange)
                slotInfo[IndexPath(row: cellRange.from.row, column: cellRange.from.column)] = (minutes, duration)
                minutes += duration + 1
            }
        }
        return mergedCells
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        if indexPath.column == 0 && indexPath.row == 0 {
            return nil
        }

        if indexPath.column == 0 && indexPath.row > 0 {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HourCell.self), for: indexPath) as! HourCell
            cell.label.text = hourFormatter.string(from: twelveHourFormatter.date(from: "\((indexPath.row - 1) / 60 % 24)")!)
            cell.gridlines.top = .solid(width: 1, color: .white)
            cell.gridlines.bottom = .solid(width: 1, color: .white)
            return cell
        }
        if indexPath.column > 0 && indexPath.row == 0 {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: ChannelCell.self), for: indexPath) as! ChannelCell
            cell.label.text = channels[indexPath.column - 1]
            cell.gridlines.top = .solid(width: 1, color: .black)
            cell.gridlines.bottom = .solid(width: 1, color: .black)
            cell.gridlines.left = .solid(width: 1 / UIScreen.main.scale, color: UIColor(white: 0.3, alpha: 1))
            cell.gridlines.right = cell.gridlines.left
            return cell
        }

        if let (minutes, duration) = slotInfo[indexPath] {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: SlotCell.self), for: indexPath) as! SlotCell
            cell.minutes = minutes % 60
            cell.title = "Dummy Text"
            cell.tableHighlight = duration > 20 ? "Lorem ipsum dolor sit amet, consectetur adipiscing elit" : ""
            return cell
        }
        return spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: BlankCell.self), for: indexPath)
    }

    /// Delegate

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath) {
        print("Selected: (row: \(indexPath.row), column: \(indexPath.column))")
    }
}
