//
//  ClassDataVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/26.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SpreadsheetView
import ScreenRotator

class ClassDataVC: BaseViewController {
    
    var spreadsheetView = SpreadsheetView(frame: CGRect(x: 10, y: TopHeight, width: SCREENW - 20, height: SCREENH - TopHeight - SoftHeight))
    var header = [String]()
    var data = [[String]]()

    enum Sorting {
        case ascending
        case descending

        var symbol: String {
            switch self {
            case .ascending:
                return "\u{25B2}"
            case .descending:
                return "\u{25BC}"
            }
        }
    }
    var sortedColumn = (column: 0, sorting: Sorting.ascending)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(spreadsheetView)
        
        spreadsheetView.dataSource = self
        spreadsheetView.delegate = self

        spreadsheetView.register(HeaderCell.self, forCellWithReuseIdentifier: String(describing: HeaderCell.self))
        spreadsheetView.register(TextCell2.self, forCellWithReuseIdentifier: String(describing: TextCell2.self))
        spreadsheetView.scrollView.isScrollEnabled = false
        
        let data = try! String(contentsOf: Bundle.main.url(forResource: "data", withExtension: "tsv")!, encoding: .utf8)
            .components(separatedBy: "\r\n")
            .map { $0.components(separatedBy: "\t") }
        header = data[0]
        self.data = Array(data.dropFirst())
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

extension ClassDataVC: SpreadsheetViewDataSource, SpreadsheetViewDelegate {
    // MARK: DataSource

    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return header.count
    }

    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1 + data.count
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return 140
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        if case 0 = row {
            return 60
        } else {
            return 44
        }
    }
    
    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        if case 0 = indexPath.row {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
            cell.label.text = header[indexPath.column]

            if case indexPath.column = sortedColumn.column {
                cell.sortArrow.text = sortedColumn.sorting.symbol
            } else {
                cell.sortArrow.text = ""
            }
            cell.setNeedsLayout()
            
            return cell
        } else {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: TextCell2.self), for: indexPath) as! TextCell2
            cell.label.text = data[indexPath.row - 1][indexPath.column]
            return cell
        }
    }
    
    /// Delegate

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath) {
        if case 0 = indexPath.row {
            if sortedColumn.column == indexPath.column {
                sortedColumn.sorting = sortedColumn.sorting == .ascending ? .descending : .ascending
            } else {
                sortedColumn = (indexPath.column, .ascending)
            }
            data.sort {
                let ascending = $0[sortedColumn.column] < $1[sortedColumn.column]
                return sortedColumn.sorting == .ascending ? ascending : !ascending
            }
            spreadsheetView.reloadData()
        }
    }
}

