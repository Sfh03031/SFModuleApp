//
//  ServiceSettingVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/10/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import HandyJSON
import SFStyleKit
import SFServiceKit
import SVProgressHUD
import UIFontComplete
import FSTextView

class ServiceSettingVC: BaseCollectionViewController {
    
    var dataList: [ServiceSettingModel] = []
    var defIndex: Int = 0
    var isAdd: Bool = false
    var nameValue: String = "" //新增名称
    var addressValue: String = "" //新增链接地址

    override func viewDidLoad() {
        super.viewDidLoad()

        let rightImg = SFSymbolManager.shared.symbol(systemName: "plus", withConfiguration: nil, withTintColor: .systemTeal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImg!, style: .plain, target: self, action: #selector(rightTap(_:)))

        self.collectionView?.register(ServiceSettingCell.self, forCellWithReuseIdentifier: String(describing: ServiceSettingCell.self))
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: UICollectionReusableView.self))
        
        self.view.addSubview(okBtn)
        
        loadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.collectionView.frame = CGRect(x: 0, y: TopHeight, width: SCREENW, height: SCREENH - TopHeight - SoftHeight - 40)
        self.okBtn.frame = CGRect(x: 100, y: SCREENH - SoftHeight - 40, width: SCREENW - 200, height: 40)
    }
    
    @objc func rightTap(_ sender: UIBarButtonItem) {
        self.isAdd = !self.isAdd
        self.collectionView.reloadData()
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
                ["name": "开发环境1", "address": HOST_URL_DEV1],
                ["name": "开发环境2", "address": HOST_URL_DEV2],
                ["name": "测试环境", "address": HOST_URL_TEST]
            ]
            UserDefaults.standard.set(list, forKey: ServiceKey)
            UserDefaults.standard.synchronize()
        }
        self.dataList = []
        for (index, item) in list.enumerated() {
            if let dic = item as? [String: Any] {
                let model = JSONDeserializer<ServiceSettingModel>.deserializeFrom(dict: dic)
                self.dataList.append(model!)
                if host == model?.address {
                    self.defIndex = index
                }
            }
        }
        
        self.collectionView.reloadData()
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
                let model = ServiceSettingModel.deserialize(from: dic)
                self.dataList.append(model!)
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
    
    /// 刷新整个App
    func refreshApp() {
        let model: ServiceSettingModel = self.dataList[self.defIndex]
        UserDefaults.standard.set(model.address, forKey: kUrlHostKey)
        UserDefaults.standard.synchronize()
        
        let delegate  = UIApplication.shared.delegate as! AppDelegate
        delegate.ConfigTabBarController()
    }
    
    // MARK: lazyload
    
    lazy var okBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.sf.backgroundColor(.hex_a78e44).title("确定").titleColor(.white).titleFont(UIFont.systemFont(ofSize: 16, weight: .medium)).makeRadius(5.0).addTapAction { view in
            self.refreshApp()
        }
        return btn
    }()
}

// MARK: UICollectionViewDataSource，UICollectionViewDelegate，UICollectionViewDelegateFlowLayout
extension ServiceSettingVC: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ServiceSettingCell.self), for: indexPath) as? ServiceSettingCell
    
        let model: ServiceSettingModel = self.dataList[indexPath.item]

        cell?.loadCell(model: model, isChoosed: self.defIndex == indexPath.row)
        cell?.chooseTapBlock = {[weak self] in
            guard let self = self else { return }
            self.defIndex = indexPath.row
            self.collectionView.reloadData()
        }
        
        cell?.delTapBlock = {[weak self] in
            guard let self = self else { return }
            self.delService(address: model.address)
        }
    
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
       
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: UICollectionReusableView.self), for: indexPath)
            
            let value = "Notice:\n1、默认一直存在正式、开发和测试三个环境；\n2、右上角新增链接地址验证可用后才会加入列表；\n3、默认环境、当前环境和选中环境不可删除；\n4、自定义环境的M站和PDF下载链接与开发环境相同；\n5、点确定会刷新整个App并回到首页；\n6、Jenkins打包安装App后打开，如果设置过地址，当前环境可能与在Jenkins选择的不一致，若想环境一致就在安装前先删除旧版App。"
            
            let label = UILabel(frame: CGRect(x: 10, y: 0, width: SCREENW - 20, height: 200) , bgColor: .clear, textColor: .label, font: UIFont.systemFont(ofSize: 14.0), aligment: .left, lines: 0)
            header.addSubview(label)
            
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = 22
            style.minimumLineHeight = 22
            let attStr = NSMutableAttributedString(string: value, attributes: [
                .paragraphStyle: style,
                .baselineOffset: (22.0 - label.font.lineHeight) / 4
            ])
            label.attributedText = attStr
            
            return header
        } else {
            if self.isAdd {
                let footer: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
                footer.backgroundColor = .clear
                
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
                
                let label = UILabel(frame: CGRect(x: (SCREENW - 100) / 2, y: 120, width: 100, height: 30) ,bgColor:.systemTeal, text: "验证", textColor: .white, font: UIFont.systemFont(ofSize: 14, weight: .medium), aligment: .center, radius: 5)
                label.isUserInteractionEnabled = true
                label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(checkTap(_:))))
                footer.addSubview(label)
                
                return footer
            } else {
                let footer: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: UICollectionReusableView.self), for: indexPath)
                footer.backgroundColor = .clear
                
                return footer
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: SCREENW, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: SCREENW, height: isAdd ? 200 : CGFLOAT_MIN)
    }
}
