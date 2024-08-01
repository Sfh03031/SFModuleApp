//
//  PulsatorVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/6/3.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import Pulsator

let kMaxRadius: CGFloat = 200
let kMaxDuration: TimeInterval = 10

class PulsatorVC: BaseViewController {
    
    @IBOutlet weak var sourceView: UIImageView!
    @IBOutlet weak var countSlider: UISlider!
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var rSlider: UISlider!
    @IBOutlet weak var gSlider: UISlider!
    @IBOutlet weak var bSlider: UISlider!
    @IBOutlet weak var aSlider: UISlider!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var radiusLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var rLabel: UILabel!
    @IBOutlet weak var gLabel: UILabel!
    @IBOutlet weak var bLabel: UILabel!
    @IBOutlet weak var aLabel: UILabel!
    
    let pulsator = Pulsator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sourceView.layer.superlayer?.insertSublayer(pulsator, below: sourceView.layer)
        setupInitialValues()
        pulsator.start()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layer.layoutIfNeeded()
        pulsator.position = sourceView.layer.position
    }
    
    private func setupInitialValues() {
        countSlider.value = 5
        countChanged(nil)
        
        radiusSlider.value = 0.7
        radiusChanged(nil)
        
        durationSlider.value = 0.5
        durationChanged(nil)
        
        rSlider.value = 0
        gSlider.value = 0.455
        bSlider.value = 0.756
        aSlider.value = 1
        colorChanged(nil)
    }

    @IBAction func countChanged(_ sender: UISlider?) {
        pulsator.numPulse = Int(countSlider.value)
        countLabel.text = "\(pulsator.numPulse)"
    }
    
    @IBAction func radiusChanged(_ sender: UISlider?) {
        pulsator.radius = CGFloat(radiusSlider.value) * kMaxRadius
        radiusLabel.text = String(format: "%.0f", pulsator.radius)
    }
    
    @IBAction func durationChanged(_ sender: UISlider?) {
        pulsator.animationDuration = Double(durationSlider.value) * kMaxDuration
        durationLabel.text = String(format: "%.1f", pulsator.animationDuration)
    }
    
    @IBAction func colorChanged(_ sender: UISlider?) {
        pulsator.backgroundColor = UIColor(
            red: CGFloat(rSlider.value),
            green: CGFloat(gSlider.value),
            blue: CGFloat(bSlider.value),
            alpha: CGFloat(aSlider.value)).cgColor
        rLabel.text = String(format: "%.2f", rSlider.value)
        gLabel.text = String(format: "%.2f", gSlider.value)
        bLabel.text = String(format: "%.2f", bSlider.value)
        aLabel.text = String(format: "%.2f", aSlider.value)
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        if sender.isOn {
            pulsator.start()
        }
        else {
            pulsator.stop()
        }
    }
    
    
    
    
}
