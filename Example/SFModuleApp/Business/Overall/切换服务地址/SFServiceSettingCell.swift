//
//  SFServiceSettingCell.swift
//  SparkBase
//
//  Created by sfh on 2023/11/8.
//  Copyright © 2023 Spark. All rights reserved.
//

import UIKit

class SFServiceSettingCell: UITableViewCell {
    
    var chooseTapBlock:(()->())?
    var delTapBlock:(()->())?
    
    public func loadCell(model: SFServiceSettingModel, isChoose: Bool = false, isLast: Bool = false) {
        nameLabel.text = model.name
        nameLabel.textColor = isChoose ? .systemBlue : .label
        
        addressLabel.text = model.address
        addressLabel.textColor = isChoose ? .systemBlue : .label
        
        if model.address == HOST_URL_DEV || model.address == HOST_URL_TEST || model.address == HOST_URL_RELEASE || isChoose {
            delLabel.isHidden = true
        } else {
            delLabel.isHidden = false
        }
        
        lineView.isHidden = isLast
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .systemBackground
        
        self.loadViews()
        self.layoutViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    fileprivate func loadViews() {
        contentView.addSubview(backView)
        contentView.addSubview(lineView)
        backView.addSubview(nameLabel)
        backView.addSubview(addressLabel)
        backView.addSubview(delLabel)
        
        isSkeletonable = true
        backView.isSkeletonable = true
        lineView.isSkeletonable = true
        nameLabel.isSkeletonable = true
        addressLabel.isSkeletonable = true
        delLabel.isSkeletonable = true
    }
    
    fileprivate func layoutViews() {
        backView.snp.makeConstraints { make in
            make.left.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.equalTo(SCREENW - 20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(5)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.bottom.equalTo(-5)
        }
        
        delLabel.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 20))
        }
        
        lineView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    @objc fileprivate func backTap(_ sender: UITapGestureRecognizer) {
        if let call = chooseTapBlock {
            call()
        }
    }
    
    @objc fileprivate func delTap(_ sender: UITapGestureRecognizer) {
        if let call = delTapBlock {
            call()
        }
    }
    
    //MARK: - lazyload
    
    fileprivate lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backTap(_:))))
        return view
    }()
    
    fileprivate lazy var nameLabel: UILabel = {
        let label = UILabel(bgColor: .clear, textColor: .label, font: UIFont.systemFont(ofSize: 17, weight: .medium), aligment: .center)
        return label
    }()
    
    fileprivate lazy var addressLabel: UILabel = {
        let label = UILabel(bgColor: .clear, textColor: .label, font: UIFont.systemFont(ofSize: 14, weight: .medium), aligment: .center)
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate lazy var delLabel: UILabel = {
        let label = UILabel(bgColor: .systemPink, text: "删除", textColor: .white, font: UIFont.systemFont(ofSize: 12, weight: .medium), aligment: .center, radius: 5)
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(delTap(_:))))
        return label
    }()
    
    fileprivate lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .opaqueSeparator
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
