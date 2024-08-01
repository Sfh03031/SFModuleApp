//
//  ExpandLabelVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/6.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class ExpandLabelVC: BaseViewController {
    
    let numberOfCells : NSInteger = 12
    var states : Array<Bool>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        states = [Bool](repeating: true, count: numberOfCells)

        self.view.addSubview(tableView)
        
        //
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    //MARK: - lazyload
    
    //tableView
    lazy var tableView: UITableView = {
        let tabView = UITableView.init(frame: CGRect.init(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - SoftHeight), style: .grouped)
        tabView.backgroundColor = UIColor.sf.hexColor(hex: "#F5F6F9")
        tabView.showsVerticalScrollIndicator = false
        tabView.delegate = self
        tabView.dataSource = self
        tabView.estimatedRowHeight = 44
        tabView.separatorStyle = .singleLine
        tabView.register(ExpandableCell.self, forCellReuseIdentifier: String(describing: ExpandableCell.self))
        return tabView
    }()

}

extension ExpandLabelVC {
    
    func preparedSources() -> [(text: String, textReplacementType: ExpandableLabel.TextReplacementType, numberOfLines: Int, textAlignment: NSTextAlignment)] {
        return [(loremIpsumText(), .word, 3, .left),
                (textWithNewLinesInCollapsedLine(), .word, 2, .center),
                (textWithLongWordInCollapsedLine(), .character, 1, .right),
                (textWithVeryLongWords(), .character, 1, .left),
                (loremIpsumText(), .word, 4, .center),
                (loremIpsumText(), .character, 3, .right),
                (loremIpsumText(), .word, 2, .left),
                (loremIpsumText(), .character, 5, .center),
                (loremIpsumText(), .word, 3, .right),
                (loremIpsumText(), .character, 1, .left),
                (textWithShortWordsPerLine(), .character, 3, .center),
                (textEmojis(), .character, 3, .left)]
    }
    
    
    func loremIpsumText() -> String {
        return "On third line our text need be collapsed because we have ordinary text, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
    }
    
    func textWithNewLinesInCollapsedLine() -> String {
        return "When u had new line specialChars \n More not appeared eirmod\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n tempor invidunt ut\n\n\n\n labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
    }
    
    func textWithLongWordInCollapsedLine() -> String {
        return "When u had long word which not entered in one line More not appeared FooBaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaR tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
    }
    
    func textWithVeryLongWords() -> String {
        return "FooBaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaR FooBaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaR FooBaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaR FooBaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaR Will show first line and will increase touch area for more voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
    }
    
    func textWithShortWordsPerLine() -> String {
        return "A\nB\nC\nD\nE\nF\nG\nH\nI\nJ\nK\nL\nM\nN"
    }
    
    func textEmojis() -> String {
        return "😂😄😃😊😍😗😜😅😓☺️😶🤦😒😁😟😵🙁🤔🤓☹️🙄😑😫😱🙂😧🤵😶👥👩‍❤️‍👩💖👨‍❤️‍💋‍👨💏👩‍👩‍👦‍👦👦👀👨‍👩‍👧‍👦👩‍❤️‍👩🗨🕴👩‍❤️‍💋‍👩👧☹️😠😤😆💚🙄🤒💋😿👄"
    }
}

extension ExpandLabelVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return states.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSource = preparedSources()[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ExpandableCell.self), for: indexPath) as! ExpandableCell
        cell.expandLabel.delegate = self
        
        // 可以设置收起的对齐方式，但收起事件的响应位置只在初始左对齐的位置
//        cell.expandLabel.setLessLinkWith(lessLink: "Close", attributes: [.foregroundColor:UIColor.red], position: currentSource.textAlignment)
        
        cell.layoutIfNeeded()
        
        cell.expandLabel.shouldCollapse = true
        cell.expandLabel.textReplacementType = currentSource.textReplacementType
        cell.expandLabel.numberOfLines = currentSource.numberOfLines
        cell.expandLabel.collapsed = states[indexPath.row]
        cell.expandLabel.text = currentSource.text
        
        return cell
    }

    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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

extension ExpandLabelVC: ExpandableLabelDelegate {
    
    func willExpandLabel(_ label: ExpandableLabel) {
        tableView.beginUpdates()
    }
    
    func didExpandLabel(_ label: ExpandableLabel) {
        let point = label.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) as IndexPath? {
            states[indexPath.row] = false
            DispatchQueue.main.async { [weak self] in
                self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
        tableView.endUpdates()
    }
    
    func willCollapseLabel(_ label: ExpandableLabel) {
        tableView.beginUpdates()
    }
    
    func didCollapseLabel(_ label: ExpandableLabel) {
        let point = label.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) as IndexPath? {
            states[indexPath.row] = true
            DispatchQueue.main.async { [weak self] in
                self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
        tableView.endUpdates()
    }
}

extension String {
    
    func specialPriceAttributedStringWith(_ color: UIColor) -> NSMutableAttributedString {
        let attributes = [NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int),
                          .foregroundColor: color, .font: fontForPrice()]
        return NSMutableAttributedString(attributedString: NSAttributedString(string: self, attributes: attributes))
    }
    
    func priceAttributedStringWith(_ color: UIColor) -> NSAttributedString {
        let attributes = [NSAttributedString.Key.foregroundColor: color, .font: fontForPrice()]
        
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    func priceAttributedString(_ color: UIColor) -> NSAttributedString {
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    fileprivate func fontForPrice() -> UIFont {
        return UIFont(name: "Helvetica-Neue", size: 13) ?? UIFont()
    }
}
