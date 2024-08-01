//
//  GagatCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/6/7.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class GagatCell: UITableViewCell {
    
    struct cellStyle {
        let backgroundColor: UIColor
        let titleTextColor: UIColor
        let descriptionTextColor: UIColor

        static let light = cellStyle (
            backgroundColor: .white,
            titleTextColor: .black,
            descriptionTextColor: UIColor(white: 0.4, alpha: 1.0)
        )

        static let dark = cellStyle (
            backgroundColor: UIColor(white: 0.2, alpha: 1.0),
            titleTextColor: .white,
            descriptionTextColor: UIColor(white: 0.6, alpha: 1.0)
        )
    }
    
    func cellApply(style: cellStyle) {
        backgroundColor = style.backgroundColor
        titleLabel.textColor = style.titleTextColor
        subLabel.textColor = style.descriptionTextColor
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
 
        loadViews()
        layoutViews()
    }
    
    func loadViews() {
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(subLabel)
    }
    
    func layoutViews() {
        imgView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.left.equalTo(20)
            make.centerY.equalTo(self.contentView.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(imgView.snp.right).offset(10)
            make.top.equalTo(10)
            make.right.equalTo(-20)
            make.height.equalTo(30)
        }
        
        subLabel.snp.makeConstraints { make in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.bottom.equalTo(-10)
        }
    }
    
    lazy var imgView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(bgColor: .clear, textColor: .black, font: UIFont.boldSystemFont(ofSize: 18), aligment: .left)
        
        return label
    }()
    
    lazy var subLabel: UILabel = {
        let label = UILabel(bgColor: .clear, textColor: .lightGray, font: UIFont.systemFont(ofSize: 14), aligment: .left, lines: 0)
        
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
