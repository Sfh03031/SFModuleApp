//
//  SparkNoNetworkView.swift
//  SparkBase
//
//  Created by sfh on 2024/1/25.
//  Copyright © 2024 Spark. All rights reserved.
//

#if canImport(SnapKit)

import UIKit

class SparkNoNetworkView: UIView {

    /// 重新加载的回调
    var reloadEvent:(()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        loadViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadViews() {
        self.addSubview(imgView)
        self.addSubview(infoLabel)
        self.addSubview(setBtn)
        self.addSubview(reloadBtn)
    }
    
    func layoutViews() {
        imgView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.centerY.equalTo(self.snp.centerY).offset(-140)
            make.centerX.equalTo(self.snp.centerX).offset(0)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.top.equalTo(imgView.snp.bottom).offset(20)
        }
        
        setBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 40))
            make.top.equalTo(infoLabel.snp.bottom).offset(30)
            make.left.equalTo((self.bounds.width - 100*2 - 20)/2)
        }
        
        reloadBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 40))
            make.top.equalTo(infoLabel.snp.bottom).offset(30)
            make.right.equalTo(-(self.bounds.width - 100*2 - 20)/2)
        }
    }
    
    @objc func setBtnClick(_ sender: UIButton) {
        if let url = URL(string: "App-Prefs:root") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc func reloadBtnClick(_ sender: UIButton) {
        reloadEvent?()
    }
    
    // MARK: - lazyload
    
    /// 图片
    private lazy var imgView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "暂无网络.png")
        view.isHidden = false
        return view
    }()
    
    /// 提示文字
    public lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = noNetworkNotice
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var setBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor(red: 233/255, green: 75/255, blue: 80/255, alpha: 1)
        btn.setTitle("前往设置", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(setBtnClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var reloadBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor(red: 233/255, green: 75/255, blue: 80/255, alpha: 1)
        btn.setTitle("重新加载", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(reloadBtnClick(_:)), for: .touchUpInside)
        return btn
    }()

}

#endif
