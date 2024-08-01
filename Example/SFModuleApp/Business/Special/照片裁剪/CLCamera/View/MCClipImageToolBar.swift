//
//  MCClipImageToolBar.swift
//  MCAPI
//
//  Created by MC on 2018/9/27.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

public class MCClipImageToolBar: UIView {
    /// 是否显示重设选择尺寸按钮
    public var isShowResetScaleButton: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(rotatingButton)
        addSubview(rotatingLabel)
        addSubview(cancelButton)
        addSubview(sureButton)
        addSubview(cancelLabel)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        let selfWidth = frame.size.width

        let iconWH: CGFloat = 28

        let leftMargin: CGFloat = 65

        let sureButton_X = selfWidth / 2 - 30
        let cancelButton_X = selfWidth - leftMargin - iconWH

        rotatingButton.frame = CGRect(x: leftMargin, y: 46, width: iconWH, height: iconWH)
        rotatingLabel.frame = CGRect(x: 0, y: 0, width: 25, height: 16.5)
        rotatingLabel.center = CGPoint(x: rotatingButton.center.x, y: rotatingButton.center.y + 24)

        sureButton.frame = CGRect(x: sureButton_X, y: 30, width: 60, height: 60)

        cancelButton.frame = CGRect(x: cancelButton_X, y: 46, width: iconWH, height: iconWH)
        cancelLabel.frame = CGRect(x: 0, y: 0, width: 25, height: 16.5)
        cancelLabel.center = CGPoint(x: cancelButton.center.x, y: cancelButton.center.y + 24)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = image("ClipImage_cancel")
        button.setImage(image, for: .normal)
        return button
    }()

    lazy var rotatingButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = image("ClipImage_rotating")
        button.setImage(image, for: .normal)
        return button
    }()

    lazy var sureButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = image("ClipImage_sure")
        button.setImage(image, for: .normal)
        return button
    }()

    lazy var rotatingLabel: UILabel = {
        let label = UILabel()
        label.text = "翻转"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()

    lazy var cancelLabel: UILabel = {
        let label = UILabel()
        label.text = "重拍"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()

    func image(_ name: String) -> UIImage? {
        let filePath = Bundle(for: CLCameraControlView.classForCoder()).resourcePath! + "/CLCamera.bundle"
        let bundle = Bundle(path: filePath)
        let scale = max(min(Int(UIScreen.main.scale), 2), 3)
        return .init(named: "\(name)@\(scale)x", in: bundle, compatibleWith: nil)
    }
}
