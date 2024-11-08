//
//  SF_TNTextItemView.swift
//  SparkBase
//
//  Created by sfh on 2023/8/2.
//  Copyright © 2023 Spark. All rights reserved.
//

import UIKit

typealias SF_TNTextItemViewBlock = () -> Void

class SF_TNTextItemView: UIView {
    
    var delBlock: SF_TNTextItemViewBlock!
    
    var isShowDel: Bool = false {
        didSet {
            if isShowDel {
                delBtn.isHidden = false
                textView.isEditable = false
                textView.backgroundColor = UIColor.black.withAlphaComponent(0.05)
                textView.layer.borderWidth = 0.5
                textView.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
            } else {
                delBtn.isHidden = true
                textView.isEditable = true
                textView.backgroundColor = .clear
                textView.layer.borderWidth = 0
                textView.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(textViewPan(_:))))
        
        loadViews()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadViews() {
        self.addSubview(textView)
        self.addSubview(delBtn)
        
        textView.frame = CGRect(x: 0, y: 12, width: self.bounds.width - 12, height: self.bounds.height - 12)
        textView.contentSize = CGSize(width: textView.bounds.width, height: textView.bounds.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        delBtn.frame = CGRect(x: self.bounds.width - 20, y: 0, width: 20, height: 20)
    }
    
    ///拖动手势
    @objc func textViewPan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            break
        case .changed:
            let translation = sender.translation(in: self.superview)
            self.center = CGPointMake(self.center.x + translation.x, self.center.y + translation.y)
            sender.setTranslation(CGPointZero, in: self.superview)
            break
        case .ended:
            
            break
        case .cancelled:
            break
        case .failed:
            break
        default:
            break
        }
    }
    
    ///删除某条标注
    @objc func delBtnClick(_ sender: UIButton) {
        if self.delBlock != nil {
            self.delBlock()
        }
    }
    
    // MARK: - lazyload
    
    lazy var textView: FSTextView = {
        let view = FSTextView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        view.isScrollEnabled = false
//        view.shouldIgnoreScrollingAdjustment = true
        view.textContainerInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        view.textContainer.lineFragmentPadding = 0
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.isUserInteractionEnabled = true
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
