//
//  LiquidFloatingVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
//import LiquidFloatingActionButton

class LiquidFloatingVC: BaseViewController {
    
    var lfList1 = ["command", "light.max", "sun.max", "signature"]
    var lfList2 = ["paragraphsign", "figure.walk.motion"]
    var lfList3 = ["sunset", "crop.rotate"]
    var lfList4 = ["figure.american.football", "figure.archery", "figure.badminton", "figure.basketball"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(lfbtn1)
//        self.view.addSubview(lfbtn2)
//        self.view.addSubview(lfbtn3)
//        self.view.addSubview(lfbtn4)
        self.view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerY.equalTo(self.view.snp.centerY)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(100)
        }
    }
    
    lazy var label: UILabel = {
        let view = UILabel(bgColor: .clear, textColor: .systemTeal, font: UIFont.systemFont(ofSize: 16, weight: .medium), aligment: .center, lines: 0)
        return view
    }()
    

    lazy var lfbtn1: LiquidFloatingActionButton = {
        let view = LiquidFloatingActionButton(frame: CGRect(x: 20, y: TopHeight + 20, width: 60, height: 60))
        view.animateStyle = .down
        view.color = .random
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    lazy var lfbtn2: LiquidFloatingActionButton = {
        let view = LiquidFloatingActionButton(frame: CGRect(x: SCREENW - 80, y: TopHeight + 20, width: 60, height: 60))
        view.animateStyle = .left
        view.color = .random
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    lazy var lfbtn3: LiquidFloatingActionButton = {
        let view = LiquidFloatingActionButton(frame: CGRect(x: 20, y: SCREENH - SoftHeight - 80, width: 60, height: 60))
        view.animateStyle = .right
        view.color = .random
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    lazy var lfbtn4: LiquidFloatingActionButton = {
        let view = LiquidFloatingActionButton(frame: CGRect(x: SCREENW - 80, y: SCREENH - SoftHeight - 80, width: 60, height: 60))
        view.animateStyle = .up
        view.color = .random
        view.delegate = self
        view.dataSource = self
        return view
    }()

}

extension LiquidFloatingVC: LiquidFloatingActionButtonDataSource {
//    func cellForIndex(_ index: Int) -> LiquidFloatingCell {
//        let value = lfList1[index]
//        return LiquidFloatingCell.init(icon: SFSymbol.symbol(name: value)!)
//    }
    
    
    func cellForIndex(_ index: Int) -> LiquidFloatingCell {
        let value = lfList1[index]
        return LiquidFloatingCell.init(icon: SFSymbol.symbol(name: value)!)
    }
    
//    func cellForIndex(_ index: Int, LFAButton: LiquidFloatingActionButton) -> LiquidFloatingCell {
//        if LFAButton == lfbtn1 {
//            let value = lfList1[index]
//            return LiquidFloatingCell.init(icon: SFSymbol.symbol(name: value)!)
//        } else if LFAButton == lfbtn2 {
//            let value = lfList2[index]
//            return LiquidFloatingCell.init(icon: SFSymbol.symbol(name: value)!)
//        } else if LFAButton == lfbtn3 {
//            let value = lfList3[index]
//            return LiquidFloatingCell.init(icon: SFSymbol.symbol(name: value)!)
//        } else {
//            let value = lfList4[index]
//            return LiquidFloatingCell.init(icon: SFSymbol.symbol(name: value)!)
//        }
//    }
    
    
//    func numberOfCells(_ LFAButton: LiquidFloatingActionButton) -> Int {
//        if LFAButton == lfbtn1 {
//            return lfList1.count
//        } else if LFAButton == lfbtn2 {
//            return lfList2.count
//        } else if LFAButton == lfbtn3 {
//            return lfList3.count
//        } else {
//            return lfList4.count
//        }
//    }
    
    func numberOfCells(_ LFAButton: LiquidFloatingActionButton) -> Int {
        return lfList1.count
    }
 
}

extension LiquidFloatingVC: LiquidFloatingActionButtonDelegate {
    
//    func liquidFloatingActionButtonWillOpenDrawer(_ LFAButton: LiquidFloatingActionButton) {
//        if LFAButton == lfbtn1 {
//            print("左上角打开")
//        } else if LFAButton == lfbtn2 {
//            print("右上角打开")
//        } else if LFAButton == lfbtn3 {
//            print("左下角打开")
//        } else {
//            print("右下角打开")
//        }
//    }
    
    func liquidFloatingActionButtonWillOpenDrawer(_ LFAButton: LiquidFloatingActionButton) {
        print("左上角打开")
    }
    
//    func liquidFloatingActionButtonWillCloseDrawer(_ LFAButton: LiquidFloatingActionButton) {
//        if LFAButton == lfbtn1 {
//            print("左上角关闭")
//        } else if LFAButton == lfbtn2 {
//            print("右上角关闭")
//        } else if LFAButton == lfbtn3 {
//            print("左下角关闭")
//        } else {
//            print("右下角关闭")
//        }
//    }
    
    func liquidFloatingActionButtonWillCloseDrawer(_ LFAButton: LiquidFloatingActionButton) {
        print("左上角关闭")
    }
    
//    func liquidFloatingActionButton(_ LFAButton: LiquidFloatingActionButton, didSelectItemAtIndex index: Int) {
//        print("\(index)")
//        LFAButton.close()
//        if LFAButton == lfbtn1 {
//            self.label.text = "点击左上角按钮: \(index)"
//        } else if LFAButton == lfbtn2 {
//            self.label.text = "点击右上角按钮: \(index)"
//        } else if LFAButton == lfbtn3 {
//            self.label.text = "点击左下角按钮: \(index)"
//        } else {
//            self.label.text = "点击右下角按钮: \(index)"
//        }
//    }
    
    func liquidFloatingActionButton(_ LFAButton: LiquidFloatingActionButton, didSelectItemAtIndex index: Int) {
        self.label.text = "点击左上角按钮: \(index)"
    }
    
}
