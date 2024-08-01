//
//  MatchingColorsCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/19.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class MatchingColorsCell: BaseCollectionViewCell {
    
    var km: MatchingColorModel?
    
    override func loadViews() {
        self.contentView.addSubview(backView)
        backView.addSubview(colorView)
        backView.addSubview(infoLabel)
        colorView.addSubview(color1Label)
        colorView.addSubview(color2Label)
        colorView.addSubview(color3Label)
        colorView.addSubview(color4Label)
        
        color1Label.sf.addTapAction { view in
            self.color1Label.text = self.km?.color1
            self.color2Label.text = ""
            self.color3Label.text = ""
            self.color4Label.text = ""
            
            self.color1Label.snp.remakeConstraints { make in
                make.left.top.bottom.equalToSuperview()
                make.width.equalTo(self.colorView.snp.width).multipliedBy(0.4)
            }
            
            self.color2Label.snp.remakeConstraints { make in
                make.left.equalTo(self.color1Label.snp.right)
                make.top.bottom.equalToSuperview()
                make.width.equalTo(self.colorView.snp.width).multipliedBy(0.2)
            }
            
            self.color3Label.snp.remakeConstraints { make in
                make.left.equalTo(self.color2Label.snp.right)
                make.top.bottom.equalToSuperview()
                make.width.equalTo(self.colorView.snp.width).multipliedBy(0.2)
            }
            
            self.color4Label.snp.remakeConstraints { make in
                make.left.equalTo(self.color3Label.snp.right)
                make.top.bottom.equalToSuperview()
                make.width.equalTo(self.colorView.snp.width).multipliedBy(0.2)
            }
        }
        
        color2Label.sf.addTapAction { view in
            self.color1Label.text = ""
            self.color2Label.text = self.km?.color2
            self.color3Label.text = ""
            self.color4Label.text = ""
            
            self.color1Label.snp.remakeConstraints { make in
                make.left.top.bottom.equalToSuperview()
                make.width.equalTo(self.colorView.snp.width).multipliedBy(0.2)
            }
            
            self.color2Label.snp.remakeConstraints { make in
                make.left.equalTo(self.color1Label.snp.right)
                make.top.bottom.equalToSuperview()
                make.width.equalTo(self.colorView.snp.width).multipliedBy(0.4)
            }
            
            self.color3Label.snp.remakeConstraints { make in
                make.left.equalTo(self.color2Label.snp.right)
                make.top.bottom.equalToSuperview()
                make.width.equalTo(self.colorView.snp.width).multipliedBy(0.2)
            }
            
            self.color4Label.snp.remakeConstraints { make in
                make.left.equalTo(self.color3Label.snp.right)
                make.top.bottom.equalToSuperview()
                make.width.equalTo(self.colorView.snp.width).multipliedBy(0.2)
            }
        }
        
        color3Label.sf.addTapAction { view in
            self.color1Label.text = ""
            self.color2Label.text = ""
            self.color3Label.text = self.km?.color3
            self.color4Label.text = ""
            
            self.color1Label.snp.remakeConstraints { make in
                make.left.top.bottom.equalToSuperview()
                make.width.equalTo(self.colorView.snp.width).multipliedBy(0.2)
            }
            
            self.color2Label.snp.remakeConstraints { make in
                make.left.equalTo(self.color1Label.snp.right)
                make.top.bottom.equalToSuperview()
                make.width.equalTo(self.colorView.snp.width).multipliedBy(0.2)
            }
            
            self.color3Label.snp.remakeConstraints { make in
                make.left.equalTo(self.color2Label.snp.right)
                make.top.bottom.equalToSuperview()
                make.width.equalTo(self.colorView.snp.width).multipliedBy(0.4)
            }
            
            self.color4Label.snp.remakeConstraints { make in
                make.left.equalTo(self.color3Label.snp.right)
                make.top.bottom.equalToSuperview()
                make.width.equalTo(self.colorView.snp.width).multipliedBy(0.2)
            }
        }
        
        color4Label.sf.addTapAction { view in
            self.color1Label.text = ""
            self.color2Label.text = ""
            self.color3Label.text = ""
            self.color4Label.text = self.km?.color4
            
            self.color1Label.snp.remakeConstraints { make in
                make.left.top.bottom.equalToSuperview()
                make.width.equalTo(self.colorView.snp.width).multipliedBy(0.2)
            }
            
            self.color2Label.snp.remakeConstraints { make in
                make.left.equalTo(self.color1Label.snp.right)
                make.top.bottom.equalToSuperview()
                make.width.equalTo(self.colorView.snp.width).multipliedBy(0.2)
            }
            
            self.color3Label.snp.remakeConstraints { make in
                make.left.equalTo(self.color2Label.snp.right)
                make.top.bottom.equalToSuperview()
                make.width.equalTo(self.colorView.snp.width).multipliedBy(0.2)
            }
            
            self.color4Label.snp.remakeConstraints { make in
                make.left.equalTo(self.color3Label.snp.right)
                make.top.bottom.equalToSuperview()
                make.width.equalTo(self.colorView.snp.width).multipliedBy(0.4)
            }
        }
    }
    
    override func layoutViews() {
        
        backView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        colorView.snp.makeConstraints { make in
            make.left.top.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(-40)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.left.right.equalTo(colorView)
            make.top.equalTo(colorView.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        color1Label.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(colorView.snp.width).multipliedBy(0.25)
        }
        
        color2Label.snp.makeConstraints { make in
            make.left.equalTo(color1Label.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(colorView.snp.width).multipliedBy(0.25)
        }
        
        color3Label.snp.makeConstraints { make in
            make.left.equalTo(color2Label.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(colorView.snp.width).multipliedBy(0.25)
        }
        
        color4Label.snp.makeConstraints { make in
            make.left.equalTo(color3Label.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(colorView.snp.width).multipliedBy(0.25)
        }
    }
    
    override func loadData(_ model: BaseModel, indexPath: IndexPath) {
        if let m = model as? MatchingColorModel {
            self.km = m
            color1Label.backgroundColor = UIColor.sf.hexColor(hex: m.color1!)
            color2Label.backgroundColor = UIColor.sf.hexColor(hex: m.color2!)
            color3Label.backgroundColor = UIColor.sf.hexColor(hex: m.color3!)
            color4Label.backgroundColor = UIColor.sf.hexColor(hex: m.color4!)
            infoLabel.text = m.color1! + " -> " + m.color2! + " -> " + m.color3! + " -> " + m.color4!
        }
    }
    
    lazy var backView: UIView = {
        let view = UIView()
        view.sf.backgroundColor(.white).makeRadius(15)
        return view
    }()
    
    lazy var colorView: UIView = {
        let view = UIView()
        view.sf.makeRadius(10)
        return view
    }()
    
    lazy var color1Label: UILabel = {
        let label = UILabel(bgColor: .clear, textColor: .white, font: UIFont.systemFont(ofSize: 14, weight: .medium), aligment: .center)
        return label
    }()
    
    lazy var color2Label: UILabel = {
        let label = UILabel(bgColor: .clear, textColor: .white, font: UIFont.systemFont(ofSize: 14, weight: .medium), aligment: .center)
        return label
    }()
    
    lazy var color3Label: UILabel = {
        let label = UILabel(bgColor: .clear, textColor: .white, font: UIFont.systemFont(ofSize: 14, weight: .medium), aligment: .center)
        return label
    }()
    
    lazy var color4Label: UILabel = {
        let label = UILabel(bgColor: .clear, textColor: .white, font: UIFont.systemFont(ofSize: 14, weight: .medium), aligment: .center)
        return label
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel(bgColor: .clear, textColor: .label, font: UIFont.systemFont(ofSize: 13, weight: .regular), aligment: .center)
        return label
    }()
}
