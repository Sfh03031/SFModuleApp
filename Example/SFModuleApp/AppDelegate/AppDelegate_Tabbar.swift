//
//  AppDelegate_Tabbar.swift
//  SparkBase
//
//  Created by sfh on 2023/12/22.
//  Copyright © 2023 Spark. All rights reserved.
//

import Foundation
import SFNetworkManager
import LottieService
import CYLTabBarController

struct tabInfoModel: HandyJSON {
    var list: [tabItemModel]?
    
    struct tabItemModel: HandyJSON {
        /// 详情跳转id
        var id: String?
        /// 广告图片url
        var img: String?
        /// 预留字段1
        var img_normal: String?
        /// 预留字段2
        var img_press: String?
        /// 主标题
        var name: String?
        /// 副标题
        var url: String?
        /// 预留字段3
        var enable: Bool?
        var isShow: Bool?
    }
}

extension AppDelegate {
    /// 动态化tabbar
    @objc func ConfigTabBarController() {
        /// 模拟网络请求获取到数据
//        SparkNetManager.request(target: BasicAPIService.tabbarInfo) { msg, model in
//            print("获取到model")
//            self.tabModel = model
//            self.initRootTabBarVC()
//        } failure: { error in
//            print(error as Any)
//            self.window?.rootViewController = LFTabBarController()
//        }
        
        let dic: [String: Any] = [
            "list": [
                ["id": "",
                 "img": "https://ksimg.sparke.cn/images/smartBook/english/2023/7/1852226731376233856.zip",
                 "img_normal": "home_normal",
                 "img_press": "home_selected",
                 "name": "overall",
                 "url": "spark://com.spark.SparkOnline.hs.act.AlphaVC?key=111",
                 "enable": "",
                 "isShow": ""],
                ["id": "", 
                 "img": "https://ksimg.sparke.cn/images/smartBook/english/2023/7/1852227787938188672.zip",
                 "img_normal": "study_normal",
                 "img_press": "study_selected",
                 "name": "table",
                 "url": "spark://com.spark.SparkOnline.hs.act.BroveVC?key=222",
                 "enable": "",
                 "isShow": ""],
                ["id": "", 
                 "img": "https://ksimg.sparke.cn/images/smartBook/english/2023/7/1852228870268027456.zip",
                 "img_normal": "book_normal",
                 "img_press": "book_selected",
                 "name": "collection",
                 "url": "spark://com.spark.SparkOnline.hs.act.DeltaVC?key=333",
                 "enable": "",
                 "isShow": ""],
                ["id": "", 
                 "img": "https://ksimg.sparke.cn/images/smartBook/english/2023/7/1852229119376130624.zip",
                 "img_normal": "mine_normal",
                 "img_press": "mine_selected",
                 "name": "ui",
                 "url": "spark://com.spark.SparkOnline.hs.act.EpsilonVC?key=444",
                 "enable": "",
                 "isShow": ""],
            ],
        ]
        
        self.tabModel = tabInfoModel.deserialize(from: dic)!
        initRootTabBarVC()
    }
    
    /// 通过字符串获取控制器类型
    /// - Parameters:
    ///   - vcName: 控制器字符串
    /// - Returns: 控制器类型
    func getVCClassFromString(vcName: String) -> UIViewController.Type? {
        let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
        if let ctrlClass = NSClassFromString((bundleName ?? "") + "." + vcName) as? UIViewController.Type {
            return ctrlClass
        } else {
            return nil
        }
    }
    
    /// 解析数据，初始化根控制器
    func initRootTabBarVC() {
        var vcArr: [UIViewController] = []
        var itemArr: [[String: Any]] = []
        for i in 0 ..< (self.tabModel?.list!.count)! {
            let m = self.tabModel?.list?[i]

            var dic: [String: Any] = [:]
            dic.updateValue(m?.name ?? "", forKey: CYLTabBarItemTitle)
            dic.updateValue(m?.img_normal ?? "", forKey: CYLTabBarItemImage) //  本地图片传名字，网络图片传UIImage对象
            dic.updateValue(m?.img_press ?? "", forKey: CYLTabBarItemSelectedImage)
//            dic.updateValue(URL(string: m?.img ?? "")!, forKey: CYLTabBarLottieURL)
//            dic.updateValue(NSValue(cgSize: CGSizeMake(33, 33)), forKey: CYLTabBarLottieSize)
            itemArr.append(dic)
            
            let url = URL(string: m?.url ?? "")
            let host = url?.host ?? ""
            if host.components(separatedBy: ".").last != nil {
                let vcStr = host.components(separatedBy: ".").last!
                if let vcCls = getVCClassFromString(vcName: vcStr) {
                    let vc = vcCls.init()
                    vc.navigationItem.title = m?.name ?? ""
                    let nv = BaseNavigationController(rootViewController: vc)
                    vcArr.append(nv)
                } else {
                    print("字符串转类型失败")
                }
            } else {
                print("协议格式不正确")
            }
        }
    
        // 不相等说明出错了，展示默认
        if vcArr.count == itemArr.count {
            // 注册不规则按钮
            SparkPlusButtonSubclass.register()
            let vc = SparkTabBarController(viewControllers: vcArr, tabBarItemsAttributes: itemArr)
            vc.delegate = self
            window?.rootViewController = vc
        } else {
            window?.rootViewController = LFTabBarController()
        }
    }
    
}

extension AppDelegate: CYLTabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // 确保 PlusButton 的选中状态
        self.cyl_tabBarController.updateSelectionStatusIfNeeded(for: tabBarController, shouldSelect: viewController)
        
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect control: UIControl) {
        var animationView: UIView
        
        if control.cyl_isPlusButton() {
            let btn = CYLExternPlusButton
            animationView = btn.imageView!
//            addScale(animationView: animationView, repeatCount: 1)
            addRotate(animationView: animationView)
        } else if control.isKind(of: NSClassFromString("UITabBarButton")!) {
            for view in control.subviews {
                if view.isKind(of: NSClassFromString("UITabBarSwappableImageView")!) {
                    animationView = view
                    view.isHidden = true
                    let lotView: LOTAnimationView = .init(frame: animationView.frame)
                    lotView.contentMode = .scaleToFill
                    lotView.animationSpeed = 1
                    lotView.isUserInteractionEnabled = true
                    lotView.loopAnimation = false
                    view.superview!.addSubview(lotView)

                    let index = tabBarController.selectedIndex > 2 ? tabBarController.selectedIndex - 1 : tabBarController.selectedIndex
                    if let img = self.tabModel?.list![index].img {
                        LottieService.requestLottieModel(with: URL(string: img)!) { sceneModel, _ in
                            lotView.sceneModel = sceneModel
                        }
                    }
                    // 动画开始
                    lotView.play(fromProgress: 0, toProgress: 1) { _ in
                        view.isHidden = false
                        lotView.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    /// 缩放动画
    func addScale(animationView: UIView, repeatCount: Float) {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "transform.scale"
        animation.values = [1.0, 1.3, 0.9, 1.15, 0.95, 1.5, 1]
        animation.duration = 0.5
        animation.repeatCount = repeatCount
        animation.calculationMode = kCAAnimationCubic
        animationView.layer.add(animation, forKey: nil)
    }
    
    /// 旋转动画
    func addRotate(animationView: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            animationView.layer.transform = CATransform3DMakeRotation(Double.pi, 0, 0, 1)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: DispatchWorkItem(block: {
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.2) {
                animationView.layer.transform = CATransform3DMakeRotation(2 * Double.pi, 0, 0, 1)
            } 
        }))
    }
}
