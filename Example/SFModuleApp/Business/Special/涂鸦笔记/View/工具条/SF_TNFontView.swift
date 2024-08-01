//
//  SF_TNFontView.swift
//  SparkBase
//
//  Created by sfh on 2023/7/31.
//  Copyright © 2023 Spark. All rights reserved.
//

import UIKit

class SF_TNFontView: UIView {
    
    var fontSize: CGFloat = 16 {
        didSet {
            fontBtn.setTitle("\(Int(fontSize))", for: .normal)
            fontBtn.isSelected = false
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        loadViews()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadViews() {
        self.addSubview(fontLabel)
        self.addSubview(fontBtn)
        
        fontBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 71, height: 25))
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(-15)
        }
        
        fontLabel.snp.makeConstraints { make in
            make.right.equalTo(fontBtn.snp.left).offset(-4)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(fontLabel)
        }
    }
    
    
    // MARK: - lazyload
    
    lazy var fontLabel: UILabel = {
        let label = UILabel(text: "字号", textColor: UIColor.sf.hexColor(hex: "#222222"), font: UIFont.systemFont(ofSize: 12, weight: .regular), aligment: .right)
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var fontBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "做笔记_选择字号_未选中"), for: .normal)
        btn.setImage(UIImage(named: "做笔记_选择字号_已选中"), for: .selected)
        btn.setTitle("16", for: .normal)
        btn.setTitleColor(UIColor.sf.hexColor(hex: "#222222"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        btn.layer.cornerRadius = 4
        btn.layer.masksToBounds = true
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        btn.sf.imageSpace(title: "16", space: 25, position: .right, isSureTitleCompress: true)
        return btn
    }()

}
