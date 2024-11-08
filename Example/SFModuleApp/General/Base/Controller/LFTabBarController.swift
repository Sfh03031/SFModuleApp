//
//  LFTabBarController.swift
//  SparkBase
//
//  Created by 李凌飞 on 2018/3/12.
//  Copyright © 2018年 李凌飞. All rights reserved.
//

import UIKit
import LottieService

//extension UITabBar {
//    //让图片和文字在iOS11下仍然保持上下排列
//    override open var traitCollection: UITraitCollection {
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            return UITraitCollection(horizontalSizeClass: .compact)
//        }
//        return super.traitCollection
//    }
//}

class LFTabBarController: UITabBarController {
    
    var animationView:LOTAnimationView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        if #available(iOS 13.0, *) {
            let line: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 1))
            line.backgroundColor = UIColor.sf.hexColor(hex: "#F5F6F9")
            self.tabBar.addSubview(line)
            self.tabBar.shadowImage = UIImage()
            self.tabBar.backgroundImage =  UIImage()
        } else {
            let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: 1))
            view.backgroundColor = UIColor.sf.hexColor(hex: "#F5F6F9")
            self.tabBar.shadowImage = view.sf.screenShot()
        }

        tabBar.unselectedItemTintColor = UIColor.sf.hexColor(hex: "#222222")
        tabBar.backgroundColor = UIColor.white
        tabBar.tintColor = UIColor.sf.hexColor(hex: "#008AFF")
        tabBar.isTranslucent = false
        
        
        addChildViewControllers()
        // Do any additional setup after loading the view.
    }
    //MARK: 文字上调 1，仅用于手机，pad不变
    func appearance() -> Void {
        if #available(iOS 13.0, *) {
            // appearance 导致tabbar的unselectedItemTintColor不生效，所以通过富文本实现
            let appearance = UITabBarAppearance.init()
            appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0,vertical: -1)
            appearance.stackedLayoutAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0,vertical: -1)
            let tabFont =  UIFont.systemFont(ofSize: 10, weight: .medium)
                    
                    let selectedAttributes: [NSAttributedString.Key: Any]
                    = [NSAttributedString.Key.font: tabFont, NSAttributedString.Key.foregroundColor: UIColor.sf.hexColor(hex: "#008AFF")]
                    let normalAttributes: [NSAttributedString.Key: Any]
                    = [NSAttributedString.Key.font: tabFont, NSAttributedString.Key.foregroundColor: UIColor.sf.hexColor(hex: "#222222")]
                    
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
                    
                    //New
            appearance.inlineLayoutAppearance.normal.titleTextAttributes = normalAttributes
            appearance.inlineLayoutAppearance.selected.titleTextAttributes = selectedAttributes

            appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = normalAttributes
            appearance.compactInlineLayoutAppearance.selected.titleTextAttributes = selectedAttributes
            self.tabBar.standardAppearance = appearance
            
        } else {
            UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -1)
        }
    }
    /**
     NewHomeViewController
     * 添加子控制器
     */
    private func addChildViewControllers() {

        let HomePageV = AlphaMainVC(collectionViewLayout: FlowLayoutManager.shared.makeFlowLayout())
        addChildViewController(childController: HomePageV, title: "首页", imageName: "home_normal", selectedImage:"home_selected")
        
        let StudyV = BroveMainVC(collectionViewLayout: FlowLayoutManager.shared.makeFlowLayout())
        addChildViewController(childController:StudyV, title: "学习", imageName: "study_normal",selectedImage:"study_selected")
        
        let bookVc = DeltaMainVC(collectionViewLayout: FlowLayoutManager.shared.makeFlowLayout())
        addChildViewController(childController: bookVc, title: "书城", imageName: "book_normal", selectedImage: "book_selected")
        
        let MyView = EpsilonMainVC(collectionViewLayout: FlowLayoutManager.shared.makeFlowLayout())
        addChildViewController(childController:MyView, title: "我的", imageName: "mine_normal",selectedImage:"mine_selected")
    }
    /**
     # 初始化子控制器
     
     - parameter childControllerName: 需要初始化的控制器
     - parameter title:               标题
     - parameter imageName:           图片名称
     */
    private func addChildViewController(childController: UIViewController, title: String, imageName: String, selectedImage: String) {
        childController.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        childController.title = title
        let navC = LFNavigationController(rootViewController: childController)
        addChild(navC)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        if item.title == "我的" {//只要点击了“我的”，图标就切换为右上角不带优惠券提示的
//            item.image = UIImage.init(named: "eq我的")?.withRenderingMode(.alwaysOriginal)
//        }
    }
    
    override var shouldAutorotate: Bool{
        return self.selectedViewController!.shouldAutorotate
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
            return self.selectedViewController?.supportedInterfaceOrientations ?? UIInterfaceOrientationMask.portrait
    }
 
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return self.selectedViewController!.preferredInterfaceOrientationForPresentation
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LFTabBarController: UITabBarControllerDelegate{
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        setupAnimation(tabBarController, viewController)
    }
    
    private func getAnimationViewAtTabBarIndex(_ index: Int, _ frame: CGRect)-> LOTAnimationView{
            
        // tabbar1 。。。 tabbar3
        //lottie动画数组
        let urls:[String] = ["https://ksimg.sparke.cn/images/smartBook/english/2023/7/1852226731376233856.zip","https://ksimg.sparke.cn/images/smartBook/english/2023/7/1852227787938188672.zip","https://ksimg.sparke.cn/images/smartBook/english/2023/7/1852228870268027456.zip","https://ksimg.sparke.cn/images/smartBook/english/2023/7/1852229119376130624.zip"]
        
        let lotView:LOTAnimationView = LOTAnimationView.init(frame:CGRect.zero)
        lotView.frame = frame
        lotView.contentMode = .scaleToFill
        lotView.animationSpeed = 1
        lotView.isUserInteractionEnabled = true
        view.addSubview(lotView);
        lotView.loopAnimation = false
        //动画开始
//        lotView.play()
        LottieService.requestLottieModel(with:NSURL(string: urls[index] )! as URL) { sceneModel, error in
            lotView.sceneModel = sceneModel                        }
        return lotView
    }

    private func setupAnimation(_ tabBarVC: UITabBarController, _ viewController: UIViewController){
        
        if animationView != nil {
            animationView!.stop()
        }
        
    //        1. 获取当前点击的是第几个
        let index = tabBarVC.viewControllers?.firstIndex(of: viewController)
        var tabBarSwappableImageViews = [UIImageView]()
        
    //        2.遍历取出所有的 tabBarButton
        for tempView in tabBarVC.tabBar.subviews {
            if tempView.isKind(of: NSClassFromString("UITabBarButton") ?? UIWindow.self) {
                //2.1 继续遍历tabBarButton 找到 UITabBarSwappableImageView 并保存
    //                print("tempView : \(tempView.subviews)" )
                    //从subviews中查找
                    for tempImgV in tempView.subviews {
                        //第一种层级关系 UITabBarButton --> UITabBarSwappableImageView
                        if tempImgV.isKind(of: NSClassFromString("UITabBarSwappableImageView") ?? UIWindow.self) {
                            tabBarSwappableImageViews.append(tempImgV as! UIImageView)
                        }
                    }
 
            }
        }
        
        guard tabBarSwappableImageViews.count > 0 else {
            return
        }
    //        3. 找到当前的UITabBarButton
        let currentTabBarSwappableImageView = tabBarSwappableImageViews[index!]
        
    //        4. 获取UITabBarButton中的 UITabBarSwappableImageView 并隐藏
        var frame = currentTabBarSwappableImageView.frame
        frame.origin.x = 0
        frame.origin.y = 0
        if frame.size.width > 23{
            frame.size.width = 23
            frame.size.height = 23
        }
        var animation: LOTAnimationView? = getAnimationViewAtTabBarIndex(index!, frame)
        self.animationView = animation
        self.animationView?.center = currentTabBarSwappableImageView.center
    //        5. 创建动画 view 加载到 当前的 UITabBarButton 并隐藏 UITabBarSwappableImageView
        currentTabBarSwappableImageView.superview?.addSubview( animation!)
        currentTabBarSwappableImageView.isHidden = true
        
    //        6. 执行动画，动画结束后 显示 UITabBarSwappableImageView 移除 动画 view 并置空
        guard animation != nil else {
            return
        }
        animation!.play(fromProgress: 0, toProgress: 1) { (finished) in
            currentTabBarSwappableImageView.isHidden = false
            if animation != nil{
                animation!.removeFromSuperview()
                animation = nil
            }
        }
    }
}
