//
//  FluidSliderVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/29.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class FluidSliderVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(alphaLabel)
        self.view.addSubview(slider1)
        self.view.addSubview(slider2)
        
        alphaLabel.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        
        slider1.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(alphaLabel.snp.bottom).offset(100)
            make.height.equalTo(30)
        }
        
        slider2.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(slider1.snp.bottom).offset(100)
            make.height.equalTo(30)
        }
        
        slider1.didBeginTracking = { [weak self] _ in
            self?.setLabelHidden(true, animated: true)
        }
        slider1.didEndTracking = { [weak self] _ in
            self?.setLabelHidden(false, animated: true)
        }
    }
    
    private func setLabelHidden(_ hidden: Bool, animated: Bool) {
        let animations = {
            self.alphaLabel.alpha = hidden ? 0 : 1
        }
        if animated {
            UIView.animate(withDuration: 0.11, animations: animations)
        } else {
            animations()
        }
    }
    
    lazy var alphaLabel: UILabel = {
        let label = UILabel()
        label.sf.text("回到家啥几点回家撒活动就撒合计等哈手机啊扩大").textColor(.label).alignment(.center).lines(0)
        return label
    }()
    
    lazy var slider1: Slider = {
        let labelTextAttributes: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.white]
        
        let slider = Slider()
        slider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 500) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.black])
        }
        slider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelTextAttributes))
        slider.setMaximumLabelAttributedText(NSAttributedString(string: "500", attributes: labelTextAttributes))
        slider.fraction = 0.5
        slider.shadowOffset = CGSize(width: 0, height: 10)
        slider.shadowBlur = 5
        slider.shadowColor = UIColor(white: 0, alpha: 0.1)
        slider.contentViewColor = UIColor(red: 78/255.0, green: 77/255.0, blue: 224/255.0, alpha: 1)
        slider.valueViewColor = .white
        
        return slider
    }()
    
    lazy var slider2: Slider = {
        let labelTextAttributes: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.white]
        
        let sliderWithImages = Slider()
        sliderWithImages.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 800 + 100) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.black])
        }
        sliderWithImages.setMinimumImage(UIImage(named: "banana"))
        sliderWithImages.setMaximumImage(UIImage(named: "cake"))
        sliderWithImages.imagesColor = UIColor.white.withAlphaComponent(0.8)
        sliderWithImages.setMinimumLabelAttributedText(NSAttributedString(string: "", attributes: labelTextAttributes))
        sliderWithImages.setMaximumLabelAttributedText(NSAttributedString(string: "", attributes: labelTextAttributes))
        sliderWithImages.fraction = 0.5
        sliderWithImages.shadowOffset = CGSize(width: 0, height: 10)
        sliderWithImages.shadowBlur = 5
        sliderWithImages.shadowColor = UIColor(white: 0, alpha: 0.1)
        sliderWithImages.contentViewColor = UIColor.purple
        sliderWithImages.valueViewColor = .white
        return sliderWithImages
    }()

}
