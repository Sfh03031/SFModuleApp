//
//  SFServiceSettingVC.swift
//  SparkBase
//
//  Created by sfh on 2023/11/8.
//  Copyright © 2023 Spark. All rights reserved.
//

import UIKit
import SwiftyJSON

struct SFServiceSettingModel {
    var name: String = ""
    var address: String = ""
    
    init(dataDic: [String: Any]) {
        if dataDic.isEmpty { return }
        
        if let value = dataDic["name"]    as? String { name    = value }
        if let value = dataDic["address"] as? String { address = value }
    }
}

class SFServiceSettingVC: BaseViewController {

    var dataList: [SFServiceSettingModel] = []
    var defIndex: Int = 0
    var isAdd: Bool = false
    var nameValue: String = "" //新增名称
    var addressValue: String = "" //新增链接地址
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "环境设置"
        self.view.backgroundColor = .systemBackground
        let img = SFSymbol.symbol(name: "plus.diamond.fill", pointSize: 30.0, weight: .regular, scale: .default, tintColor: .systemTeal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: img!, style: .plain, target: self, action: #selector(add(_:)))
        
        self.view.addSubview(tableView)
        self.view.addSubview(okBtn)
        
        loadData()
    }
    
    func loadData() {
        //获取根地址
        let host = HOST_URL
        //获取地址列表
        var list:[Any] = []
        if UserDefaults.standard.object(forKey: ServiceKey) != nil {
            list = UserDefaults.standard.object(forKey: ServiceKey) as! [Any]
        } else {
            list = [
                ["name": "正式环境", "address": HOST_URL_RELEASE],
                ["name": "开发环境", "address": HOST_URL_DEV],
                ["name": "测试环境", "address": HOST_URL_TEST]
            ]
            UserDefaults.standard.set(list, forKey: ServiceKey)
            UserDefaults.standard.synchronize()
        }
        self.dataList = []
        for i in 0..<list.count {
            if let dic = list[i] as? [String: Any] {
                let model = SFServiceSettingModel.init(dataDic: dic)
                self.dataList.append(model)
                if host == model.address {
                    self.defIndex = i
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
    ///删除某个地址
    func delService(address: String) {
        var list:[Any] = []
        if UserDefaults.standard.object(forKey: ServiceKey) != nil {
            list = UserDefaults.standard.object(forKey: ServiceKey) as! [Any]
        }
        var klist = list
        for i in 0..<list.count {
            if let dic = list[i] as? [String: Any], let value = dic["address"] as? String {
                if address == value {
                    klist.remove(at: i)
                    break
                }
            }
        }
        UserDefaults.standard.set(klist, forKey: ServiceKey)
        UserDefaults.standard.synchronize()
        
        self.loadData()
    }
    
    //MARK: - click event
    
    ///退出
    @objc func back(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    ///新增
    @objc func add(_ sender: UIBarButtonItem) {
        self.isAdd = !self.isAdd
        self.tableView.reloadData()
    }
    
    ///验证新链接是否能用
    @objc func checkTap(_ sender: UITapGestureRecognizer) {
        if self.nameValue == "" {
            SVProgressHUD.showInfo(withStatus: "请输入名称")
            return
        }
        if !self.addressValue.contains("http") && !self.addressValue.contains("https") {
            SVProgressHUD.showInfo(withStatus: "请输入正确的详细地址")
            return
        }
        
        var listData:[Any] = []
        if UserDefaults.standard.object(forKey: ServiceKey) != nil {
            listData = UserDefaults.standard.object(forKey: ServiceKey) as! [Any]
        }
        var isHad:Bool = false
        for i in 0..<listData.count {
            if let dic = listData[i] as? [String: Any], let address = dic["address"] as? String {
                if self.addressValue == address {
                    isHad = true
                }
            }
        }
        if isHad {
            SVProgressHUD.showInfo(withStatus: "该地址已存在")
            return
        } else {
//            SparkNetManager.request(target: MineAPIService.getLocationData(url: self.addressValue, parameters: [:])) { [weak self] msg, res, list in
//                guard let self = self else { return }
                let dic = ["name": self.nameValue, "address": self.addressValue]
                let model = SFServiceSettingModel(dataDic: dic)
                self.dataList.append(model)
                self.isAdd = false
                listData.append(dic)
                UserDefaults.standard.set(listData, forKey: ServiceKey)
                UserDefaults.standard.synchronize()
                self.loadData()
//            } failure: { error in
//                SparkHUD.showError(withStatus: error)
//            }
        }

    }
    
    ///点击确定
    @objc func okBtnClick(_ sender: UIButton) {
        let model: SFServiceSettingModel = self.dataList[self.defIndex]
        UserDefaults.standard.set(model.address, forKey: kUrlHostKey)
        UserDefaults.standard.synchronize()
        
        let delegate  = UIApplication.shared.delegate as! AppDelegate
        delegate.ConfigTabBarController()
    }

    //MARK: - lazyload
    
    //tableView
    lazy var tableView: UITableView = {
        let tabView = UITableView.init(frame: CGRect.init(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - SoftHeight - 50), style: .grouped)
        tabView.backgroundColor = .systemBackground
        tabView.separatorStyle = .none
        tabView.showsVerticalScrollIndicator = false
        tabView.delegate = self
        tabView.dataSource = self
        if #available(iOS 11.0, *) {
            tabView.contentInsetAdjustmentBehavior = .never
        }
        if #available(iOS 15.0, *) {
            tabView.sectionHeaderTopPadding = 0
        }
        return tabView
    }()
    
    lazy var okBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 100, y: SCREENH - SoftHeight - 40, width: SCREENW - 200.0, height: 40)
        btn.backgroundColor = .systemBrown
        btn.setTitle("确定", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(okBtnClick(_:)), for: .touchUpInside)
        return btn
    }()
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension SFServiceSettingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier:String = NSStringFromClass(SFServiceSettingCell.self)
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SFServiceSettingCell
        if cell == nil {
            cell = SFServiceSettingCell.init(style: .default, reuseIdentifier: identifier)
        }
        
        let model: SFServiceSettingModel = self.dataList[indexPath.row]

        cell?.loadCell(model: model, isChoose: self.defIndex == indexPath.row, isLast: indexPath.row == self.dataList.count - 1)
        cell?.chooseTapBlock = {[weak self] in
            guard let self = self else { return }
            self.defIndex = indexPath.row
            self.tableView.reloadData()
        }
        
        cell?.delTapBlock = {[weak self] in
            guard let self = self else { return }
            self.delService(address: model.address)
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return isAdd ? 150 : CGFLOAT_MIN
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        
        let value = "Notice:\n1、默认一直存在正式、开发和测试三个环境；\n2、右上角新增链接地址验证可用后才会加入列表；\n3、默认环境、当前环境和选中环境不可删除；\n4、自定义环境的M站和PDF下载链接与开发环境相同；\n5、点确定会刷新整个App并回到首页；\n6、Jenkins打包安装App后打开，如果设置过地址，当前环境可能与在Jenkins选择的不一致，若想环境一致就在安装前先删除旧版App。"
        
        let label = UILabel.init(bgColor: .clear, textColor: .label, font: UIFont.systemFont(ofSize: 14, weight: .regular), aligment: .left, lines: 0)
        header.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.bottom.equalToSuperview()
        }
        
        let attributes = GetLabelParagraphStyle(lineHeight: 22, lab: label)
        label.attributedText = NSMutableAttributedString.init(string: value, attributes: attributes)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if isAdd {
            let footer = UIView()
            
            let nameLabel = UILabel(bgColor: .clear, text: "名称:", textColor: .label, font: UIFont.systemFont(ofSize: 14, weight: .medium), aligment: .center)
            nameLabel.frame = CGRect(x: 0, y: 10, width: 50, height: 30)
            footer.addSubview(nameLabel)

            let nameView = FSTextView(frame: CGRect(x: 50, y: 10, width: SCREENW - 60, height: 30))
            nameView.placeholder = "限定10个字符，例：临时环境"
            nameView.maxLength = 10
            nameView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            nameView.isScrollEnabled = false
            nameView.borderColor = UIColor.sf.hexColor(hex: "#F5F5F9")
            nameView.borderWidth = 1
            nameView.layer.cornerRadius = 5
            nameView.layer.masksToBounds = true
            footer.addSubview(nameView)
            nameView.addTextDidChangeHandler {[weak self] (kview) in
                guard let self = self else { return }
                self.nameValue = kview?.text ?? ""
            }
            
            let addressLabel = UILabel(bgColor: .clear, text: "地址:", textColor: .label, font: UIFont.systemFont(ofSize: 14, weight: .medium), aligment: .center)
            addressLabel.frame = CGRect(x: 0, y: 50, width: 50, height: 30)
            footer.addSubview(addressLabel)
            
            let addressView = FSTextView(frame: CGRect(x: 50, y: 50, width: SCREENW - 60, height: 30))
            addressView.placeholder = "限定50个字符，例：https://www.baidu.com/"
            addressView.maxLength = 50
            addressView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            addressView.isScrollEnabled = false
            addressView.borderColor = UIColor.sf.hexColor(hex: "#F5F5F9")
            addressView.borderWidth = 1
            addressView.layer.cornerRadius = 5
            addressView.layer.masksToBounds = true
            footer.addSubview(addressView)
            addressView.addTextDidChangeHandler {[weak self] (kview) in
                guard let self = self else { return }
                self.addressValue = kview?.text ?? ""
            }
            
            let label = UILabel(bgColor:.systemTeal, text: "验证", textColor: .white, font: UIFont.systemFont(ofSize: 14, weight: .medium), aligment: .center, radius: 5)
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(checkTap(_:))))
            footer.addSubview(label)
            label.snp.makeConstraints { make in
                make.size.equalTo(CGSize(width: 60, height: 30))
                make.bottom.equalTo(-10)
                make.centerX.equalTo(footer.snp.centerX)
            }

            return footer
        } else {
            return UIView()
        }
    }
    
}
