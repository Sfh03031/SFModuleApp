//
//  GagatExampleVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/6/7.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class GagatExampleVC: BaseViewController, UIGestureRecognizerDelegate {
    
    struct Style {
        let backgroundColor: UIColor
        let separatorColor: UIColor?
        let cellStyle: GagatCell.cellStyle

        static let dark = Style(
            backgroundColor: UIColor(white: 0.15, alpha: 1.0),
            separatorColor: UIColor(white: 0.35, alpha: 1.0),
            cellStyle: .dark
        )

        static let light = Style(
            backgroundColor: .white,
            separatorColor: UIColor(white: 0.81, alpha: 1.0),
            cellStyle: .light
        )
    }
    
    private var currentStyle: Style {
        return useDarkMode ? .dark : .light
    }

    fileprivate var useDarkMode = false {
        didSet { apply(currentStyle) }
    }

    var dataList:[Any] = [
        ["image": "LPD", "title": "高考语文", "subTitle": "随着互联网的普及、人工智能的应用，越来越多的问题能很快得到答案。那么，我们的问题是否会越来越少？以上材料引发了你怎样的联想和思考？请写一篇文章。要求：选准角度，确定立意，明确文体，自拟标题；不要套作，不得抄袭；不得泄露个人信息；不少于800字。"],
        ["image": "Pikachu", "title": "高考数学", "subTitle": "这是一篇材料作文，此题设计体现了对教考衔接的出题意方向，对标统编版语文教材必修下册四单元的“信息时代的语文生活”。材料提供了三个主要的讨论点：信息时代与海量信息、大数据推送与娱乐至死、人工智能与人类创造力。这些讨论点都涉及到当前社会的热点问题，并鼓励考生针对这些问题表达自己的观点。要求考生根据材料内容，结合自己的理解和分析，进行论述和展开。"],
        ["image": "Swift", "title": "高考英语", "subTitle": "本题材料描述了信息时代和人工智能背景下，人们面临的种种挑战和困惑。材料分为三部分：首先提到了信息时代的海量信息对人们的影响，包括信息的真实性和辨别难度；其次，提到了大数据推送带来的“娱乐至死”现象，警示人们过度沉迷于娱乐内容而忽视精神成长；最后，讨论了人工智能的发展对人们创造力和情感的影响，提醒人们要珍惜自己的独特性和创造力。"],
        ["image": "Miku", "title": "高考生物", "subTitle": "信息时代与海量信息：这是材料中的第一个核心话题。信息时代带来了信息爆炸，人们面临着信息过载的问题。同时，信息的真实性难以保证，人们需要具备辨别信息真伪的能力。"],
        ["image": "Jobs", "title": "高考化学", "subTitle": "大数据推送与娱乐至死：这是材料中的第二个核心话题。大数据推送精准地满足了人们的娱乐需求，但也可能导致人们过度沉迷于娱乐内容，忽视了对精神成长的追求。"],
        ["image": "Beethoven", "title": "高考地理", "subTitle": "人工智能与人类创造力：这是材料中的第三个核心话题。人工智能的发展在带来便利的同时，也引发了人们对自身创造力和情感被取代的担忧。如何平衡人工智能与人类创造力的关系，是一个值得探讨的问题。"],
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
        
        apply(currentStyle)
    }
    
    private func apply(_ style: Style) {
        tableView.backgroundColor = style.backgroundColor
        tableView.separatorColor = style.separatorColor
        apply(style.cellStyle, toCells: tableView.visibleCells)
    }

    private func apply(_ cellStyle: GagatCell.cellStyle, toCells cells: [UITableViewCell]) {
        for cell in cells {
            guard let archiveCell = cell as? GagatCell else {
                continue
            }

            archiveCell.cellApply(style: cellStyle)
        }
    }
    

    //MARK: - lazyload
    
    //tableView
    lazy var tableView: UITableView = {
        let tabView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENW, height: SCREENH), style: .grouped)
        tabView.backgroundColor = .clear
        tabView.separatorStyle = .none
        tabView.showsVerticalScrollIndicator = false
        tabView.delegate = self
        tabView.dataSource = self
        tabView.register(GagatCell.self, forCellReuseIdentifier: "GagatCell")
        return tabView
    }()

}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension GagatExampleVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let archiveCell = cell as? GagatCell else {
            return
        }

        archiveCell.cellApply(style: currentStyle.cellStyle)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dic = self.dataList[indexPath.row] as? [String: Any] ?? [:]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GagatCell", for: indexPath) as! GagatCell
        cell.imgView.image = UIImage(named: dic["image"] as? String ?? "")
        cell.titleLabel.text = dic["title"] as? String ?? ""
        cell.subLabel.text = dic["subTitle"] as? String ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return TopHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return SoftHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

extension GagatExampleVC: GagatStyleable {

    func toggleActiveStyle() {
        useDarkMode = !useDarkMode
    }

}
