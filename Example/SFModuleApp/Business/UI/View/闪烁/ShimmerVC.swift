//
//  ShimmerVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/28.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import Shimmer

class ShimmerVC: BaseViewController {
    
    var panStartValue: CGFloat = 0.0
    var panVertical: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground

        self.view.addSubview(noticeLabel)
        self.view.addSubview(imgView)
        self.view.addSubview(valueLabel)
        self.view.addSubview(shimmeringView)
        shimmeringView.contentView = logoLabel
        
        noticeLabel.snp.makeConstraints { make in
            make.top.equalTo(TopHeight)
            make.left.right.equalToSuperview()
        }
        
        imgView.snp.makeConstraints { make in
            make.top.equalTo(noticeLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-SoftHeight)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(imgView)
        }
        
        shimmeringView.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(imgView)
            make.height.equalTo(100)
        }
        
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped(_:))))
        self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panned(_:))))
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        self.shimmeringView.isShimmering = !self.shimmeringView.isShimmering
    }
    
    @objc func panned(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        let velocity = sender.velocity(in: self.view)
        
        if sender.state == .began {
            panVertical = fabsf(Float(velocity.y)) > fabsf(Float(velocity.x))
            if panVertical {
                panStartValue = shimmeringView.shimmeringSpeed
            } else {
                panStartValue = shimmeringView.shimmeringOpacity
            }
            animateValueLabelVisible(true)
        } else if sender.state == .changed {
            let directional = panVertical ? translation.y : translation.x
            let possible = panVertical ? self.view.bounds.height : self.view.bounds.width
            let progress = directional / possible
            
            if panVertical {
                shimmeringView.shimmeringSpeed = CGFloat(fmax(0.0, fminf(1000.0, Float(panStartValue + progress * 200.0))))
                valueLabel.text = String(format: "闪烁速率\n%.1f", shimmeringView.shimmeringSpeed)
            } else {
                shimmeringView.shimmeringOpacity = CGFloat(fmax(0.0, fminf(1.0, Float(panStartValue + progress * 0.5))))
                valueLabel.text = String(format: "闪烁文字透明度\n%.2f", shimmeringView.shimmeringOpacity)
            }
        } else if sender.state == .cancelled || sender.state == .ended {
            animateValueLabelVisible(false)
        }
    }
    
    func animateValueLabelVisible(_ visible: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .beginFromCurrentState) {
            self.valueLabel.alpha = visible ? 1.0 : 0.0
        }
    }
    
    lazy var noticeLabel: UILabel = {
        let label = UILabel()
        label.sf.text("点击开启/禁用闪烁效果\n横向滑动改变文字透明度\n竖向滑动改变闪烁速率").textColor(.label).font(UIFont.systemFont(ofSize: 15)).alignment(.center).lines(0)
        return label
    }()
    
    lazy var imgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "DanielWu.jpg")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.sf.textColor(.white).font(UIFont.systemFont(ofSize: 32)).alignment(.center).lines(0).alpha(0).backgroundColor(.clear)
        return label
    }()
    
    lazy var shimmeringView: FBShimmeringView = {
        let view = FBShimmeringView()
        view.isShimmering = true
        view.shimmeringBeginFadeDuration = 0.3
        view.shimmeringOpacity = 0.3
        return view
    }()
    
    lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.sf.text("唐僧洗头爱飘柔").textColor(.white).font(UIFont.systemFont(ofSize: 50)).alignment(.center).lines(0).backgroundColor(.clear)
        return label
    }()

}
