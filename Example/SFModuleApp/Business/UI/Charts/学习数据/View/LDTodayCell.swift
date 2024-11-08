//
//  LDTodayCell.swift
//  SparkBase
//
//  Created by Apple on 2021/7/13.
//  Copyright © 2021 Spark. All rights reserved.
//

import UIKit

class LDTodayCell: UITableViewCell {
    
    var alphaLabel: UILabel!
    var dateLabel: UILabel!
    
    var leftView: UIView!
    var leftLabel: UILabel!
    var leftSubLabel: UILabel!
    
    var rightView: UIView!
    var rightLabel: UILabel!
    var rightSubLabel: UILabel!
    
    var dateStr: String = "" {
        didSet {
            if dateStr.count > 0 {
//                let year:String = dateStr.components(separatedBy: "年")[0]
//                let temp:String = dateStr.components(separatedBy: "年")[1]
//                dateLabel.text = "\(year)年·\(temp)"
                dateLabel.text = dateStr
            }
        }
    }
    
    var type: String = "1" {// 1智能书模考 2简听力 3词汇星火式巧记速记
        didSet {
            if type == "1" {
                rightSubLabel.text = "模考正确率"
            } else if type == "2" {
                rightSubLabel.text = "进阶特训正确率"
            } else if type == "3"{
                rightSubLabel.text = "章节测试正确率"
            }
        }
    }
    
    
    
    var timeStr: String = "" {
        didSet {
            if timeStr.count > 0 {
                let hour:String = timeStr.components(separatedBy: "小时")[0]
                let minStr:String = timeStr.components(separatedBy: "小时")[1]
                let minute:String = minStr.components(separatedBy: "分钟")[0]
                
                let hourAttStr: NSMutableAttributedString = NSMutableAttributedString.init(string: hour)
                let hourAtt: [NSAttributedString.Key: Any] = [.font:UIFont.systemFont(ofSize: 18, weight: .semibold)]
                hourAttStr.addAttributes(hourAtt, range: NSRange.init(location: 0, length: hourAttStr.length))
                
                let alphaAttStr: NSMutableAttributedString = NSMutableAttributedString.init(string: " 小时 ")
                let alphaAtt: [NSAttributedString.Key: Any] = [.font:UIFont.systemFont(ofSize: 11, weight: .medium)]
                alphaAttStr.addAttributes(alphaAtt, range: NSRange.init(location: 0, length: alphaAttStr.length))
                
                let minuAttStr: NSMutableAttributedString = NSMutableAttributedString.init(string: minute)
                let minuAtt: [NSAttributedString.Key: Any] = [.font:UIFont.systemFont(ofSize: 18, weight: .medium)]
                minuAttStr.addAttributes(minuAtt, range: NSRange.init(location: 0, length: minuAttStr.length))
                
                let broveAttStr: NSMutableAttributedString = NSMutableAttributedString.init(string: " 分钟")
                let broveAtt: [NSAttributedString.Key: Any] = [.font:UIFont.systemFont(ofSize: 11, weight: .medium)]
                broveAttStr.addAttributes(broveAtt, range: NSRange.init(location: 0, length: broveAttStr.length))
                
                hourAttStr.append(alphaAttStr)
                hourAttStr.append(minuAttStr)
                hourAttStr.append(broveAttStr)
                leftLabel.attributedText = hourAttStr
            }
        }
    }
    
    var rateStr:String = ""{
        didSet {
            let rateAttStr: NSMutableAttributedString = NSMutableAttributedString.init(string: rateStr)
            let rateAtt: [NSAttributedString.Key: Any] = [.font:UIFont.systemFont(ofSize: 18, weight: .semibold)]
            rateAttStr.addAttributes(rateAtt, range: NSRange.init(location: 0, length: rateAttStr.length))
            
            let alphaAttStr: NSMutableAttributedString = NSMutableAttributedString.init(string: " %")
            let alphaAtt: [NSAttributedString.Key: Any] = [.font:UIFont.systemFont(ofSize: 11, weight: .semibold)]
            alphaAttStr.addAttributes(alphaAtt, range: NSRange.init(location: 0, length: alphaAttStr.length))
            
            rateAttStr.append(alphaAttStr)
            rightLabel.attributedText = rateAttStr
        }
    }
    
    
    
    init(style:UITableViewCell.CellStyle, reuseIdentifier:String?,cellType:Int = 1) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.sf.hexColor(hex: "#F5F6F9")
        self.loadViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadViews() {
        alphaLabel = UILabel.init()
        alphaLabel.text = "今日学习情况"
        alphaLabel.textColor = UIColor.sf.hexColor(hex: "#222222")
        alphaLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        contentView.addSubview(alphaLabel)
        alphaLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(0)
            make.height.equalTo(50)
            make.width.equalTo(alphaLabel)
        }
        
        dateLabel = UILabel.init()
        dateLabel.text = "XXXX年·XX月XX日"
        dateLabel.textColor = UIColor.sf.hexColor(hex: "#AFB3BF")
        dateLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(0)
            make.height.equalTo(50)
            make.width.equalTo(dateLabel)
        }
        
        let viewH: CGFloat = (SCREENW - 50)/2
        
        leftView = UIView.init()
        leftView.backgroundColor = UIColor.white
        leftView.layer.cornerRadius = 15
        leftView.clipsToBounds = true
        contentView.addSubview(leftView)
        leftView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: viewH, height: 70))
            make.left.equalTo(20)
            make.top.equalTo(50)
        }
        
        leftLabel = UILabel.init()
        leftLabel.textColor = UIColor.sf.hexColor(hex: "#008AFF")
        leftLabel.textAlignment = .center
        leftView.addSubview(leftLabel)
        leftLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(14)
            make.height.equalTo(25)
            make.width.equalTo(leftLabel)
        }
        
        leftSubLabel = UILabel.init()
        leftSubLabel.text = "学习时长"
        leftSubLabel.textColor = UIColor.sf.hexColor(hex: "#222222")
        leftSubLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        leftView.addSubview(leftSubLabel)
        leftSubLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(leftLabel.snp.bottom).offset(0)
            make.height.equalTo(17)
            make.width.equalTo(leftSubLabel)
        }
        
        rightView = UIView.init()
        rightView.backgroundColor = UIColor.white
        rightView.layer.cornerRadius = 15
        rightView.clipsToBounds = true
        contentView.addSubview(rightView)
        rightView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: viewH, height: 70))
            make.right.equalTo(-20)
            make.top.equalTo(50)
        }
        
        rightLabel = UILabel.init()
        rightLabel.textColor = UIColor.sf.hexColor(hex: "#008AFF")
        rightLabel.textAlignment = .center
        rightView.addSubview(rightLabel)
        rightLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(14)
            make.height.equalTo(25)
            make.width.equalTo(rightLabel)
        }
        
        rightSubLabel = UILabel.init()
        rightSubLabel.textColor = UIColor.sf.hexColor(hex: "#222222")
        rightSubLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        rightView.addSubview(rightSubLabel)
        rightSubLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(rightLabel.snp.bottom).offset(0)
            make.height.equalTo(17)
            make.width.equalTo(rightSubLabel)
        }
       
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
