//
//  BaseNavigationController.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/16.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
//import Gagat
import FDFullscreenPopGesture

/// NavBarStyle
enum BaseNavBarStyle {
    /// 不透明纯色
    case pureStyle
    /// 透明
    case clearStyle
}

class BaseNavigationController: UINavigationController {
    
    fileprivate var useDarkMode = false {
        didSet {
            navigationBar.barStyle = useDarkMode ? .black : .default
        }
    }
    
    var popDelegate: UIGestureRecognizerDelegate?
    
    //防止某些情况下会push多次
    public var isPushing: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.fd_prefersNavigationBarHidden = true
        //从iOS13开始modalPresentationStyle默认为UIModalPresentationAutomatic
        if #available(iOS 13, *) {
            self.modalPresentationStyle = .fullScreen
        }
        
        //初始化导航栏为纯色不透明导航栏
        initNavBar(withStyle: .pureStyle)
        
        // 解决侧滑返回失效问题
        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.delegate = self
    }
    
    /// 初始化导航栏 -- 具体属性可根据需求修改
    func initNavBar(withStyle: BaseNavBarStyle) {
        // 设置导航条标题颜色，还可以设置其它文字属性，只需要在里面添加对应的属性
        let dic: [NSAttributedString.Key : Any]  = [.foregroundColor: UIColor.sf.random, .font: UIFont.systemFont(ofSize: 18, weight: .medium)]
        // 导航条背景色
        let navBgColor: UIColor = withStyle == .pureStyle ? .systemBackground : .clear
        //MARK: 导航条背景是否透明，如果设为false，子VC的初始位置会从导航栏底部开始进而影响布局，不管是纯色还是透明保持默认为true即可，不影响设置导航条的背景色
        let isTranslucent: Bool = withStyle == .pureStyle ? true : true
        //前景色，按钮颜色
        let tintColor: UIColor = .blue
        
        // 阴影
//        self.navigationBar.layer.shadowColor = UIColor.red.cgColor
//        self.navigationBar.layer.shadowRadius = 20
//        self.navigationBar.layer.shadowOpacity = 0.2
//        self.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.tintColor = tintColor
        self.navigationBar.isTranslucent = isTranslucent
        self.navigationBar.barTintColor = navBgColor
        
        let appearance = UINavigationBar.appearance()
        // 阴影
//        appearance.layer.shadowColor = UIColor.red.cgColor
//        appearance.layer.shadowRadius = 20
//        appearance.layer.shadowOpacity = 0.2
//        appearance.layer.shadowOffset = CGSize(width: 0, height: 5)
        appearance.shadowImage = UIImage()
        // iOS9版本需要设置背景图，否则无法隐藏黑线
        appearance.setBackgroundImage(UIImage(), for: .bottom, barMetrics: .default)
        appearance.tintColor = tintColor
        appearance.isTranslucent = isTranslucent
        appearance.barTintColor = navBgColor
        appearance.titleTextAttributes = dic
        
        // 解决iOS15 barTintColor设置无效的问题，参考https://developer.apple.com/forums/thread/682420
        if #available(iOS 15.0, *) {
            let newAppearance = UINavigationBarAppearance()
            newAppearance.configureWithOpaqueBackground()
            newAppearance.backgroundColor = navBgColor
            //阴影图片，template图像: [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
            newAppearance.shadowImage = UIImage()
            newAppearance.shadowColor = nil
            newAppearance.titleTextAttributes = dic
            appearance.standardAppearance = newAppearance
            appearance.scrollEdgeAppearance = newAppearance
        }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if isPushing {
            return
        } else {
            isPushing = true
            if self.viewControllers.count > 0 {
                //push后隐藏底部TabBar
                viewController.hidesBottomBarWhenPushed = true
                //让图片显示图片的原来样式,系统默认tabBarItem上的图片被选中时是蓝色
                let image = SFSymbol.symbol(name: "chevron.backward", pointSize: 25, tintColor: .label)?.withRenderingMode(.alwaysOriginal)
                //让所有push进来的控制器，它的导航栏左上角的内容都一样
                viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(navigationBackClick))
            }
            super.pushViewController(viewController, animated: animated)
        }
    }
    
    
    /// 返回按钮
    @objc func navigationBackClick() {
        if SVProgressHUD.isVisible() {
            SVProgressHUD.dismiss()
        }
//        if UIApplication.shared.isNetworkActivityIndicatorVisible {
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//        }
        popViewController(animated: true)
    }

}

//MARK: - UINavigationControllerDelegate
extension BaseNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        self.isPushing = false
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        //FIXME: CKWaveCollectionViewTransition过渡动画，适用于UICollectionViewController跳转UICollectionViewController
        if fromVC.isKind(of: UICollectionViewController.self) && toVC.isKind(of: UICollectionViewController.self) {
            let animator = CKWaveCollectionViewAnimator()
            animator.animationDuration = 0.5
            
            if operation != UINavigationController.Operation.push {
                animator.reversed = true
            }
            return animator
        }
        return nil
    }
}

//MARK: - UIGestureRecognizerDelegate
extension BaseNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.viewControllers.count <= 1 {
            return false
        }
        return true
    }
}

//MARK: - GagatStyleable
extension BaseNavigationController: GagatStyleable {

    func styleTransitionWillBegin() {
        // Do any work you might need to do before the transition snapshot is taken.
        if let styleableChildViewController = topViewController as? GagatStyleable {
            styleableChildViewController.styleTransitionWillBegin()
        }
    }

    func styleTransitionDidEnd() {
        // Do any work you might need to do once the transition has completed.
        if let styleableChildViewController = topViewController as? GagatStyleable {
            styleableChildViewController.styleTransitionDidEnd()
        }
    }

    func toggleActiveStyle() {
        useDarkMode = !useDarkMode

        // It's up to us to get any child view controllers to
        // toggle their active style. In this example application we've made
        // the child view controller also conform to `GagatStyleable`, but
        // this is not required by Gagat.
        if let styleableChildViewController = topViewController as? GagatStyleable {
            styleableChildViewController.toggleActiveStyle()
        }
    }
}
