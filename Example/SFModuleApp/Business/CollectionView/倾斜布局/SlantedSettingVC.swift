//
//  SlantedSettingVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/17.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
//import CollectionViewSlantedLayout

class SlantedSettingVC: BaseViewController {
    var slantDirectionBlock:((SlantingDirection)->())?
    var scrollDirectionBlock:((UICollectionView.ScrollDirection)->())?
    var zIndexOrderBlock:((ZIndexOrder)->())?
    var excludeFirstBlock:((Bool)->())?
    var excludeLastBlock:((Bool)->())?
    var slantingSizeBlock:((UInt)->())?
    var lineSpacingBlock:((CGFloat)->())?
    
    weak var collectionViewLayout: CollectionViewSlantedLayout!
    
    @IBOutlet weak var slantingDirectionSegment: UISegmentedControl!
    @IBOutlet weak var scrollDirectionSegment: UISegmentedControl!
    @IBOutlet weak var zIndexOrderSegment: UISegmentedControl!
    @IBOutlet weak var firstCellSlantingSwitch: UISwitch!
    @IBOutlet weak var lastCellSlantingSwitch: UISwitch!
    @IBOutlet weak var slantingSizeSlider: UISlider!
    @IBOutlet weak var lineSpacingSlider: UISlider!
    
    var slantingDirection: SlantingDirection = .downward
    var scrollDirection: UICollectionView.ScrollDirection = .vertical
    var zIndexOrder: ZIndexOrder = .descending
    var isFirstCellExcluded: Bool = false
    var isLastCellExcluded: Bool = false
    var slantingSize: UInt = 75
    var lineSpacing: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        slantingDirectionSegment.selectedSegmentIndex = slantingDirection == .downward ? 0 : 1
        scrollDirectionSegment.selectedSegmentIndex = scrollDirection == .horizontal ? 0 : 1
        zIndexOrderSegment.selectedSegmentIndex = zIndexOrder == .descending ? 0 : 1
        firstCellSlantingSwitch.isOn = isFirstCellExcluded
        lastCellSlantingSwitch.isOn = isLastCellExcluded
        slantingSizeSlider.value = Float(slantingSize)
        lineSpacingSlider.value = Float(lineSpacing)
    }

    @IBAction func slantingDirectionChanged(_ sender: UISegmentedControl) {
        self.slantDirectionBlock?(sender.selectedSegmentIndex == 0 ? .downward : .upward)
    }
    
    @IBAction func scrollDirectionChanged(_ sender: UISegmentedControl) {
        self.scrollDirectionBlock?(sender.selectedSegmentIndex == 0 ? .horizontal : .vertical)
    }
    
    @IBAction func zIndexOrderChanged(_ sender: UISegmentedControl) {
        self.zIndexOrderBlock?(sender.selectedSegmentIndex == 0 ? .descending : .ascending)
    }
    
    @IBAction func firstCellSlantingSwitchChanged(_ sender: UISwitch) {
        self.excludeFirstBlock?(sender.isOn)
    }
    
    @IBAction func lastCellSlantingSwitchChanged(_ sender: UISwitch) {
        self.excludeLastBlock?(sender.isOn)
    }
    
    @IBAction func slantingSizeChanged(_ sender: UISlider) {
        self.slantingSizeBlock?(UInt(sender.value))
    }
    
    @IBAction func lineSpacingChanged(_ sender: UISlider) {
        self.lineSpacingBlock?(CGFloat(sender.value))
    }
    
    @IBAction func Done(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: { [weak self] () -> Void in
            let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
            self?.collectionViewLayout.collectionView?.scrollRectToVisible(rect, animated: true)
        })
    }

}
