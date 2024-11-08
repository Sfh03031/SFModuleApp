//
//  TranstionButtonSecondVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/28.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import TransitionButton

class TranstionButtonSecondVC: CustomTransitionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .random
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
