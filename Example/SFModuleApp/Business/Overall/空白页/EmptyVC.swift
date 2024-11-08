//
//  EmptyVC.swift
//  SFModuleApp_Example
//
//  Created by 望舒 on 2024/4/20.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import LYEmptyView

class EmptyVC: BaseViewController {
    
    var dataList:[String] = ["为众人抱薪者，不可使其冻毙于风雪", "为自由开路者，不可使其困顿于荆棘", "为生民立命者，不可使其殒殁于无声"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "空白页"
        self.view.backgroundColor = .white
        
        self.view.addSubview(tableView)
        self.view.addSubview(btn1)
        self.view.addSubview(btn2)
        
        self.tableView.frame = CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - SoftHeight - 50)
        self.btn1.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.bottom.equalTo(-SoftHeight)
            make.width.equalTo(SCREENW/2 - 20)
            make.height.equalTo(44)
        }
        
        self.btn2.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.bottom.equalTo(-SoftHeight)
            make.width.equalTo(SCREENW/2 - 20)
            make.height.equalTo(44)
        }
    }
    
    @objc func btn1Click(_ sender: UIButton) {
        if self.dataList.count > 0 {
            self.dataList.removeLast()
        }
        tableView.reloadData()
    }
    
    @objc func btn2Click(_ sender: UIButton) {
        dataList = ["为众人抱薪者，不可使其冻毙于风雪", "为自由开路者，不可使其困顿于荆棘", "为生民立命者，不可使其殒殁于无声"]
        tableView.reloadData()
    }

    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRectZero, style: .plain)
        view.backgroundColor = UIColor.sf.random
        view.delegate = self
        view.dataSource = self
        view.ly_emptyView = LYEmptyView.emptyActionView(with: SFSymbol.symbol(name: "figure.badminton", pointSize: 200, tintColor: UIColor.sf.random), titleStr: "哎呀，没有数据了", detailStr: "点击下面的按钮，5秒后将自动还原数据", btnTitleStr: "开始倒计时", btnClick: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.dataList = ["为众人抱薪者，不可使其冻毙于风雪", "为自由开路者，不可使其困顿于荆棘", "为生民立命者，不可使其殒殁于无声"]
                self.tableView.reloadData()
            }
        })
//        view.ly_emptyView = SparkViewsService.getEmptyView()
        return view
    }()
    
    lazy var btn1: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .systemTeal
        btn.setTitle("删除一条数据", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(btn1Click(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var btn2: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .systemTeal
        btn.setTitle("还原", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(btn2Click(_:)), for: .touchUpInside)
        return btn
    }()

}

extension EmptyVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier:String = NSStringFromClass(UITableViewCell.self)
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: identifier)
        }
        
        cell?.textLabel?.text = dataList[indexPath.row]
        
        return cell!
    }
}
