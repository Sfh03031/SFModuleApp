//
//  PhotoImageCancelItemView.swift
//  HXPhotoPicker
//
//  Created by Silence on 2023/10/22.
//  Copyright © 2023 Silence. All rights reserved.
//

import UIKit

public class PhotoImageCancelItemView: UIView, PhotoNavigationItem {
    public weak var itemDelegate: PhotoNavigationItemDelegate?
    public var itemType: PhotoNavigationItemType { .cancel }
    
    let config: PickerConfiguration
    public required init(config: PickerConfiguration) {
        self.config = config
        super.init(frame: .zero)
        initView()
    }
    
    var button: UIButton!
    func initView() {
        button = UIButton(type: .custom)
        let imageName = PhotoManager.isDark ? config.photoList.cancelDarkImageName : config.photoList.cancelImageName
        button.setImage(imageName.image, for: .normal)
        button.addTarget(self, action: #selector(didCancelClick), for: .touchUpInside)
        addSubview(button)
        if let btnSize = button.currentImage?.size {
            button.size = btnSize
            size = button.size
        }
        setColor()
    }
    
    func setColor() {
        let imageName = PhotoManager.isDark ? config.photoList.cancelDarkImageName : config.photoList.cancelImageName
        button.setImage(imageName.image, for: .normal)
        guard let color = PhotoManager.isDark ? config.navigationDarkTintColor : config.navigationTintColor else {
            return
        }
        button.setTitleColor(color, for: .normal)
    }
    
    @objc
    func didCancelClick() {
        itemDelegate?.photoControllerDidCancel()
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                setColor()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
