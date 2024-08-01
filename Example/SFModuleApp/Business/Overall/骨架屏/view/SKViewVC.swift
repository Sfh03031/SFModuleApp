//
//  SKViewVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SkeletonView

class SKViewVC: BaseViewController {
    
    var value = "4月22日至23日，习近平总书记在重庆市考察调研。他先后来到重庆国际物流枢纽园区、九龙坡区谢家湾街道民主村社区、重庆市数字化城市运行和治理中心，了解当地加快建设西部陆海新通道、实施城市更新和保障改善民生、提高城市治理现代化水平等情况。"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = SFSymbol.symbol(name: "pencil.slash", pointSize: 25.0, weight: .regular, scale: .default, tintColor: .systemTeal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: img!, style: .plain, target: self, action: #selector(add(_:)))
        
        self.view.isSkeletonable = true
        iconView.isSkeletonable = true
        nameLabel.isSkeletonable = true
        nameLabel1.isSkeletonable = true
        nameLabel2.isSkeletonable = true
        nameLabel3.isSkeletonable = true
        nameLabel4.isSkeletonable = true
        
        layoutViews()
        
        doSkeletion()
    }
    
    @objc func add(_ sender: UIBarButtonItem) {
        doSkeletion()
    }
    
    func doSkeletion() {
        if self.view.sk.isSkeletonActive {
            self.view.hideSkeleton()
        } else {
            self.view.showGradientSkeleton(usingGradient: .init(baseColor: .orange, secondaryColor: .yellow), transition: .crossDissolve(0.25))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.view.hideSkeleton()
            }
        }
    }
    
    func layoutViews() {
        self.view.addSubview(iconView)
        self.view.addSubview(nameLabel)
        self.view.addSubview(nameLabel1)
        self.view.addSubview(nameLabel2)
        self.view.addSubview(nameLabel3)
        self.view.addSubview(nameLabel4)
        
        iconView.snp.makeConstraints { make in
            make.size.equalTo(CGSizeMake(100, 100))
            make.top.equalTo(TopHeight + 20)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        
        nameLabel1.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.right.equalTo(-100)
        }
        
        nameLabel2.snp.makeConstraints { make in
            make.top.equalTo(nameLabel1.snp.bottom).offset(10)
            make.left.equalTo(100)
            make.right.equalTo(-10)
        }
        
        nameLabel3.snp.makeConstraints { make in
            make.top.equalTo(nameLabel2.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.right.equalTo(-100)
        }
        
        nameLabel4.snp.makeConstraints { make in
            make.top.equalTo(nameLabel3.snp.bottom).offset(10)
            make.left.equalTo(100)
            make.right.equalTo(-10)
        }    }
    
    lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.image = UIImage(named: "DanielWu.jpg")
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 50
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(text: value, textColor: .systemRed, font: UIFont.systemFont(ofSize: 14), aligment: .center, lines: 0)
        return label
    }()
    
    lazy var nameLabel1: UILabel = {
        let label = UILabel(text: value, textColor: .systemRed, font: UIFont.systemFont(ofSize: 14), aligment: .center, lines: 0)
        return label
    }()
    
    lazy var nameLabel2: UILabel = {
        let label = UILabel(text: value, textColor: .systemRed, font: UIFont.systemFont(ofSize: 14), aligment: .center, lines: 0)
        return label
    }()
    
    lazy var nameLabel3: UILabel = {
        let label = UILabel(text: value, textColor: .systemRed, font: UIFont.systemFont(ofSize: 14), aligment: .center, lines: 0)
        return label
    }()
    
    lazy var nameLabel4: UILabel = {
        let label = UILabel(text: value, textColor: .systemRed, font: UIFont.systemFont(ofSize: 14), aligment: .center, lines: 0)
        return label
    }()

}
