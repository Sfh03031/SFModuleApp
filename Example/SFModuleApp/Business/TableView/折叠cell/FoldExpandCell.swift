//
//  FoldExpandCell.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/29.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import EasyPeasy

class FoldExpandCell: FoldingCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        
        containerView = self.createContainerView()
        foregroundView = self.createForegroundView()
        
        itemCount = 4
        
        commonInit()
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .red
//        view.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(view)
//        view.snp.makeConstraints { make in
//            make.left.equalTo(8)
//            make.right.equalTo(-8)
//            make.height.equalTo(400)
//            make.top.equalTo(10)
//        }
        
        view.easy.layout (
            Height(400),
            Left(8),
            Right(8)
        )
        
        let top = view.easy.layout(Top(10)).first
        top?.identifier = "ContainerViewTop"
        self.containerViewTop = top
        
        
        view.layoutIfNeeded()
        
        return view
    }
    
    func createForegroundView() -> RotatedView {
        let view = RotatedView()
        view.backgroundColor = .orange
//        view.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(view)
//        view.snp.makeConstraints { make in
//            
//            make.left.equalTo(8)
//            make.right.equalTo(-8)
//            make.height.equalTo(100)
//            make.top.equalTo(10).labeled("ForegroundViewTop")
//        }
        
        view.easy.layout (
            Height(100),
            Left(8),
            Right(8)
        )
        
        let top = view.easy.layout(Top(10)).first
        top?.identifier = "foregroundViewTop"
        self.foregroundViewTop = top
        
        view.layoutIfNeeded()
        
        return view
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
