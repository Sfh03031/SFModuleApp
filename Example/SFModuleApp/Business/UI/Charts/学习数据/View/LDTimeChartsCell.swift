//
//  LDTimeChartsCell.swift
//  SparkBase
//
//  Created by Apple on 2021/7/13.
//  Copyright © 2021 Spark. All rights reserved.
//

import UIKit
import AAInfographics

enum TimeChartByType: String {
    case bySenveDays
    case byMonth
}

typealias LDTimeChartsCellBlock = ()->Void

class LDTimeChartsCell: UITableViewCell {

    var dayblock: LDTimeChartsCellBlock!
    var monthblock: LDTimeChartsCellBlock!
    
    var alphaLabel: UILabel!
    
    var dayView: UIView!
    var dayLabel: UILabel!
    var dayImgView: UIImageView!
    
    var monthView: UIView!
    var monthLabel: UILabel!
    var monthImgView: UIImageView!
    
    var chartView: AAChartView!

    init(style:UITableViewCell.CellStyle, reuseIdentifier:String?,cellType:Int = 1) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.sf.hexColor(hex: "#F5F6F9", alpha: 1)
        self.loadViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadViews() {
        alphaLabel = UILabel.init()
        alphaLabel.text = "学习时长"
        alphaLabel.textColor = UIColor.sf.hexColor(hex: "#222222", alpha: 1)
        alphaLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        contentView.addSubview(alphaLabel)
        alphaLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(0)
            make.height.equalTo(50)
            make.width.equalTo(alphaLabel)
        }
        
        dayView = UIView.init()
        dayView.isUserInteractionEnabled = true
        dayView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dayTap(_:))))
        contentView.addSubview(dayView)
        dayView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 50, height: 50))
            make.top.equalTo(0)
            make.right.equalTo(-70)
        }
        
        dayLabel = UILabel.init()
        dayLabel.text = "7日"
        dayLabel.textColor = UIColor.sf.hexColor(hex: "#008AFF", alpha: 1)
        dayLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        dayView.addSubview(dayLabel)
        dayLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(15)
            make.width.equalTo(dayLabel)
        }
        
        dayImgView = UIImageView.init()
        dayImgView.image = UIImage.init(named: "indicator1")
        dayView.addSubview(dayImgView)
        dayImgView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 17, height: 4))
            make.bottom.equalTo(-8)
            make.centerX.equalToSuperview()
        }
        
        monthView = UIView.init()
        monthView.isUserInteractionEnabled = true
        monthView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(monthTap(_:))))
        contentView.addSubview(monthView)
        monthView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 50, height: 50))
            make.top.equalTo(0)
            make.right.equalTo(-20)
        }
        
        monthLabel = UILabel.init()
        monthLabel.text = "按月"
        monthLabel.textColor = UIColor.sf.hexColor(hex: "#AFB3BF", alpha: 1)
        monthLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        monthView.addSubview(monthLabel)
        monthLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(15)
            make.width.equalTo(monthLabel)
        }
        
        monthImgView = UIImageView.init()
        monthImgView.image = UIImage.init(named: "indicator1")
        monthImgView.isHidden = true
        monthView.addSubview(monthImgView)
        monthImgView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 17, height: 4))
            make.bottom.equalTo(-8)
            make.centerX.equalToSuperview()
        }
        
        chartView = AAChartView()
        chartView.frame = CGRect.init(x: 20, y: 50, width: SCREENW - 40, height: 225)
        chartView.layer.cornerRadius = 15
        chartView.clipsToBounds = true
        contentView.addSubview(chartView)
        
    }
    
    private func getChartOptions(xAxisArr: [String], yAxisArr: [Double], yValues: [Any], type: TimeChartByType) -> AAOptions{
        let chart = AAChart.init().type(.areaspline).backgroundColor(AAColor.white).spacing(top: 25, right: 15, bottom: -20, left: 8)
        
        let title = AATitle.init().text("")
        
        let xAxis = AAXAxis.init()
            .categories(xAxisArr)
            .tickWidth(0)//X轴刻度线宽度
            .lineWidth(0)//X轴轴线宽度
            .lineColor(AAColor.clear)//X轴轴线颜色
            .gridLineWidth(0.5)//X轴网格线宽度
            .gridLineColor(AAColor.clear)//X轴网格线颜色
            .gridLineDashStyle(AAChartLineDashStyleType.dash)//X轴网格线风格
            .labels(AALabels.init()
                        .step(1)
                        .style(AAStyle.init()
                                .color("#AFB3BF")
                                .fontSize(12)
                                .fontWeight(.regular)))//X轴labels
        
        let yAxis = AAYAxis.init()
            .title(AATitle.init().text(""))
            .tickPositions(yAxisArr)
            .tickWidth(0)//Y轴刻度线宽度
            .lineWidth(2)//Y轴轴线宽度
            .lineColor(AAColor.clear)//Y轴轴线颜色
            .gridLineWidth(0.5)//Y轴网格线宽度
            .gridLineColor(AARgba(249, 250, 252, 1))
            .gridLineDashStyle(.none)//Y轴网格线风格
            .labels(AALabels.init()
                        .format("{value} h")//给y轴添加单位
                        .style(AAStyle.init()
                                .color("#AFB3BF")
                                .fontSize(12)
                                .fontWeight(.regular)))//Y轴labels
        
        let spline = AASeriesElement.init()
            .name("正确率")
            .color(AARgba(0, 138, 255))//曲线线色
            .fillColor(AAGradientColor.linearGradient(
                        direction: .toBottom,
                        startColor: "rgba(0, 138, 255, 0.15)",
                        endColor: "rgba(255, 255, 255, 0.15)"))//填充色
            .lineWidth(2.0)//曲线线宽
            .marker(AAMarker.init()
                        .radius(type == TimeChartByType.bySenveDays ? 3.5 : 0)
                        .fillColor("#008AFF")
                        .lineWidth(3)
                        .lineColor("#FFFFFF")
                        .symbol("Circle")
            )//曲线上的点
            .enableMouseTracking(false)
            .data(yValues)
        
        
        let options = AAOptions.init().chart(chart).title(title).xAxis(xAxis).yAxis(yAxis).series([spline])
        
        return options
        
    }
    
    func initChart(xAxisArr: [String], yAxisArr: [Double], yValues: [Any], type: TimeChartByType) {
        let options:AAOptions = self.getChartOptions(xAxisArr: xAxisArr, yAxisArr: yAxisArr, yValues: yValues, type: type)
        
        chartView.aa_drawChartWithChartOptions(options)
    }
    
    func updateChart(xAxisArr: [String], yAxisArr: [Double], yValues: [Any], type: TimeChartByType) {
        let options:AAOptions = self.getChartOptions(xAxisArr: xAxisArr, yAxisArr: yAxisArr, yValues: yValues, type: type)
        
        chartView.aa_updateChart(options: options, redraw: true)
    }
    
    @objc func dayTap(_ sender: UITapGestureRecognizer) {
        self.dayLabel.textColor = UIColor.sf.hexColor(hex: "#008AFF", alpha: 1)
        self.dayImgView.isHidden = false
        
        self.monthLabel.textColor = UIColor.sf.hexColor(hex: "#AFB3BF", alpha: 1)
        self.monthImgView.isHidden = true
        
        weak var weakSelf = self
        if weakSelf?.dayblock != nil {
            weakSelf?.dayblock()
        }
    }
    
    @objc func monthTap(_ sender: UITapGestureRecognizer) {
        self.dayLabel.textColor = UIColor.sf.hexColor(hex: "#AFB3BF", alpha: 1)
        self.dayImgView.isHidden = true
        
        self.monthLabel.textColor = UIColor.sf.hexColor(hex: "#008AFF", alpha: 1)
        self.monthImgView.isHidden = false
        
        weak var weakSelf = self
        if weakSelf?.monthblock != nil {
            weakSelf?.monthblock()
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
