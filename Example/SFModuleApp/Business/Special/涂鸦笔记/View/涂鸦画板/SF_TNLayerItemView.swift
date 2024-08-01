//
//  SF_TNLayerItemView.swift
//  SparkBase
//
//  Created by sfh on 2023/8/1.
//  Copyright © 2023 Spark. All rights reserved.
//

import UIKit

typealias SF_TNLayerItemViewBlock = () -> Void

class SF_TNLayerItemView: UIView {
    
    var delBlock: SF_TNLayerItemViewBlock!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        
        loadViews()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadViews() {
        self.addSubview(layerView)
        self.addSubview(delBtn)
        
        layerView.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.top.equalTo(12)
            make.right.equalTo(-12)
        }
        layerView.layoutIfNeeded()
        layerView.sf.makeCustomizeBorder(color: .black, rectSide: .all, isDash: true)
        
        delBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.top.right.equalToSuperview()
        }
    }
    
    ///删除某条标注
    @objc func delBtnClick(_ sender: UIButton) {
        if self.delBlock != nil {
            self.delBlock()
        }
    }
    
    // MARK: - lazyload
    
    lazy var layerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        return view
    }()
    
    lazy var delBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "画板_删除笔记"), for: .normal)
        btn.setImage(UIImage(named: "画板_删除笔记"), for: .highlighted)
        btn.addTarget(self, action: #selector(delBtnClick(_:)), for: .touchUpInside)
        return btn
    }()

}
