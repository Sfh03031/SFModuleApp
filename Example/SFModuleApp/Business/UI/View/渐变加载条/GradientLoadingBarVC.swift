//
//  GradientLoadingBarVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/31.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import GradientLoadingBar

class GradientLoadingBarVC: BaseViewController {
    
    /// 忽略安全区
    private let gradientLoadingBar = GradientLoadingBar(isRelativeToSafeArea: false)
    private let notchGradientLoadingBar = NotchGradientLoadingBar(isRelativeToSafeArea: false)
    
    /// 导航条
    private enum Config {
        /// The programatically applied height of the `GradientActivityIndicatorView`.
        static let height: CGFloat = 3
        /// The programatically applied height of the `gradientLoadingBar1`.
        static let gradientColors = [
            #colorLiteral(red: 0.9490196078, green: 0.3215686275, blue: 0.431372549, alpha: 1), #colorLiteral(red: 0.9450980392, green: 0.4784313725, blue: 0.5921568627, alpha: 1), #colorLiteral(red: 0.9529411765, green: 0.737254902, blue: 0.7843137255, alpha: 1), #colorLiteral(red: 0.4274509804, green: 0.8666666667, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.9411764706, blue: 0.9568627451, alpha: 1),
        ]
    }
    private let gradientProgressIndicatorView = GradientActivityIndicatorView()
    
    /// 自定义渐变色
    private let gradientLoadingBar1 = GradientLoadingBar()
    
    /// 作为子视图
    private let gradientActivityIndicatorView = GradientActivityIndicatorView()

    @IBOutlet weak var toggleButton: UIButton!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Reset any possible visible loading bar.
        // 基础用法
        GradientLoadingBar.shared.fadeOut()
        
        // 忽略安全区
        gradientLoadingBar.fadeOut()
        notchGradientLoadingBar.fadeOut()
        
        // 导航条
        gradientProgressIndicatorView.fadeOut()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientLoadingBar1.gradientColors = Config.gradientColors

        setupGradientProgressIndicatorView()
        setupGradientActivityIndicatorView()
    }
    
    // MARK: - Private methods
    
    /// 加在导航条上
    private func setupGradientProgressIndicatorView() {
        guard let navigationBar = navigationController?.navigationBar else { return }

        gradientProgressIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.addSubview(gradientProgressIndicatorView)
        gradientProgressIndicatorView.fadeOut()

        NSLayoutConstraint.activate([
            gradientProgressIndicatorView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
            gradientProgressIndicatorView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),

            gradientProgressIndicatorView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            gradientProgressIndicatorView.heightAnchor.constraint(equalToConstant: Config.height),
        ])
    }
    
    /// 加在自定义视图上
    private func setupGradientActivityIndicatorView() {
        gradientActivityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        toggleButton.addSubview(gradientActivityIndicatorView)
        gradientActivityIndicatorView.fadeOut()

        NSLayoutConstraint.activate([
            gradientActivityIndicatorView.leadingAnchor.constraint(equalTo: toggleButton.leadingAnchor),
            gradientActivityIndicatorView.trailingAnchor.constraint(equalTo: toggleButton.trailingAnchor),

            gradientActivityIndicatorView.bottomAnchor.constraint(equalTo: toggleButton.bottomAnchor),
            gradientActivityIndicatorView.heightAnchor.constraint(equalToConstant: Config.height),
        ])
    }

    //MARK: - 基础用法
    
    @IBAction func basicShow(_ sender: UIButton) {
        GradientLoadingBar.shared.fadeIn()
    }
    
    @IBAction func basicHide(_ sender: UIButton) {
        GradientLoadingBar.shared.fadeOut()
    }
    
    //MARK: - 忽略安全区
    
    @IBAction func showBasicBar(_ sender: UIButton) {
        gradientLoadingBar.fadeIn()
    }
    
    @IBAction func hideBasicBar(_ sender: UIButton) {
        gradientLoadingBar.fadeOut()
    }
    
    
    @IBAction func showNotchBar(_ sender: UIButton) {
        notchGradientLoadingBar.fadeIn()
    }
    
    @IBAction func hideNotchBar(_ sender: UIButton) {
        notchGradientLoadingBar.fadeOut()
    }
    
    //MARK: - 导航条
    
    @IBAction func navShow(_ sender: UIButton) {
        gradientProgressIndicatorView.fadeIn()
    }
    
    @IBAction func navHide(_ sender: UIButton) {
        gradientProgressIndicatorView.fadeOut()
    }
    
    //MARK: - 自定义渐变色
    
    @IBAction func gradientShow(_ sender: UIButton) {
        gradientLoadingBar1.fadeIn()
    }
    
    @IBAction func gradientHide(_ sender: UIButton) {
        gradientLoadingBar1.fadeOut()
    }
    
    
    //MARK: - 作为子视图
    
    @IBAction func toggle(_ sender: UIButton) {
        if gradientActivityIndicatorView.isHidden {
            gradientActivityIndicatorView.fadeIn()
        } else {
            gradientActivityIndicatorView.fadeOut()
        }
    }
    
    
    
}
