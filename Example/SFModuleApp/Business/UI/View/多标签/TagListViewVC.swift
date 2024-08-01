//
//  TagListViewVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/28.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SFStyleKit
//import TagListView

class TagListViewVC: BaseViewController {
    
    var tapIndex: Int = -1
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tagListView)
        tagListView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(TopHeight + 10)
            make.right.equalTo(-15)
            make.bottom.equalTo(-SoftHeight)
        }
        
        tagListView.addTags(["alpha", "brove", "gamma", "delta", "epsilon","打卡", "可自定义tag", "可插入tag", "可删除tag", "可同时插入多个tag", "可同时删除多个tag"])
    }
    

    lazy var tagListView: TagListView = {
        let view = TagListView(frame: CGRectMake(15, 54, SCREENW - 30, 0))
        view.tagBackgroundColor = .orange
        view.tagSelectedBackgroundColor = .hex_008AFF
        view.textColor = .red
        view.selectedTextColor = .white
        view.textFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.tagCornerRadius = 2
        view.alignment = .left
        view.paddingX = 8
        view.paddingY = 6
        view.marginX = 6
        view.marginY = 10
        view.delegate = self
        return view
    }()

}

extension TagListViewVC: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("点击了标签")
        for (index, view) in tagListView.tagViews.enumerated() {
            if view == tagView {
                print("点击了: \(index)  \(title)")
                view.tagBackgroundColor = .hex_008AFF
                view.textColor = .white
                self.tapIndex = index
            }
        }
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        
    }
}
