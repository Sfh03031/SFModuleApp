//
//  SparkEmptyView.swift
//  SparkBase
//
//  Created by sfh on 2024/1/24.
//  Copyright © 2024 Spark. All rights reserved.
//

#if canImport(SnapKit)

import UIKit

#if canImport(LottieService)
import LottieService
#endif

class SparkEmptyView: UIView {
    
    var imgPath: String = "txy_空状态" {
        didSet {
            updateEmptyValues(imgPath: imgPath)
        }
    }
    
    var noticeStr: String = "这里什么都没有哦~"{
        didSet {
            updateEmptyValues(noticeStr: noticeStr)
        }
    }
    
    /// 初始化
    /// - Parameters:
    ///   - frame: CGRect
    ///   - imgPath: 提示图片，可以是图片名字、远程图片、本地json、远程不带图片json、远程json压缩包, 默认是本地图片: "txy_空状态"
    ///   - noticeStr: 提示文字， 默认是："这里什么都没有哦~"
    ///
    init(frame: CGRect, imgPath: String = "", noticeStr: String = "") {
        super.init(frame: frame)
        self.backgroundColor = .clear
        let img = imgPath == "" ? "txy_空状态" : imgPath
        let info = noticeStr == "" ? "这里什么都没有哦~" : noticeStr
        loadViews(imgPath: img, noticeStr: info)
        layoutViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        loadViews(imgPath: self.imgPath, noticeStr: self.noticeStr)
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 修改图片或文本
    public func updateEmptyValues(imgPath: String = "", noticeStr: String = "") {
        self.loadViews(imgPath: imgPath, noticeStr: noticeStr)
    }
    
    /// 初始化
    private func loadViews(imgPath: String, noticeStr: String) {
        imgView.isHidden = true
        aniView.isHidden = true
        if imgPath.hasPrefix("http") || imgPath.hasPrefix("https") {
            if imgPath.hasSuffix(".png") || imgPath.hasSuffix(".jpg") || imgPath.hasSuffix(".jpeg") {//远程图片
                imgView.isHidden = false
                imgView.kf.setImage(with: URL.init(string: imgPath))
            } else if imgPath.hasSuffix(".json") {//远程json
#if canImport(Lottie)
                let aniView = LOTAnimationView.init(contentsOf: URL.init(string: imgPath)!)
                aniView.backgroundColor = .clear
                aniView.contentMode = .scaleAspectFit
                aniView.animationSpeed = 1
                aniView.loopAnimation = true
                aniView.play()
                self.aniView = aniView
                self.aniView.isHidden = false
                layoutViews()
#endif
            } else if imgPath.hasSuffix(".zip") {//远程json压缩包
#if canImport(LottieService)
                aniView.isHidden = false
                LottieService.requestLottieModel(with: URL(string: imgPath)!) { [weak self] sceneModel, _ in
                    self?.aniView.sceneModel = sceneModel
                    self?.aniView.play()
                }
#else
                imgView.isHidden = false
                imgView.image = UIImage(named: imgPath)
#endif
            }
        } else if imgPath.hasSuffix(".json") {// 本地json
#if canImport(Lottie)
            aniView.isHidden = false
            aniView.setAnimation(named: imgPath)
            aniView.play()
#endif
        } else {//本地图片
            imgView.isHidden = false
            imgView.image = UIImage(named: imgPath)
        }
        
        infoLabel.text = noticeStr == "" ? "这里什么都没有哦~" : noticeStr
    }
    
    /// 布局
    private func layoutViews() {
        self.addSubview(imgView)
        self.addSubview(aniView)
        self.addSubview(infoLabel)
        
        imgView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.centerY.equalTo(self.snp.centerY).offset(-80)
            make.centerX.equalTo(self.snp.centerX).offset(0)
        }
        
        aniView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.centerY.equalTo(self.snp.centerY).offset(-100)
            make.centerX.equalTo(self.snp.centerX).offset(0)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.centerY.equalTo(self.snp.centerY).offset(-10)
        }
    }
    
    // MARK: - lazyload
    
    /// 图片
    private lazy var imgView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "txy_空状态")
        view.isHidden = false
        return view
    }()
    
#if canImport(Lottie)
    /// 动效
    private lazy var aniView: LOTAnimationView = {
        let view = LOTAnimationView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.animationSpeed = 1
        view.loopAnimation = true
        view.isHidden = true
        return view
    }()
#endif
    
    /// 提示文字
    public lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "这里什么都没有哦~"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
}

#endif
