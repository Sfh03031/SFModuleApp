//
//  AppDelegate_Ads.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/15.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

#if canImport(BeiZiSDK)
import BeiZiSDK

/// 从BeiZiSDK申请的AppID
/// 生产-21874 测试-20159
let ads_AppKey: String = ""

/// 在平台申请的广告位ID,
/// 生产-106498 测试-103222
let ads_AdvKey: String = ""

extension AppDelegate {
    
    /// 初始化 beizi sdk
    func config_beizi() {
        BeiZiSDKManager.configure(withApplicationID: ads_AppKey)
    }
    
    @objc func setup_splash() {
        self.splash = BeiZiSplash.init(spaceID: ads_AdvKey, spaceParam: "", lifeTime: 3000)
        self.splash?.delegate = self
        self.splash?.beiZi_loadAd()
    }
    
}

//MARK: - BeiZiSplashDelegate
extension AppDelegate: BeiZiSplashDelegate {
    
    /// 开屏请求成功
    func beiZi_splashDidLoadSuccess(_ beiziSplash: BeiZiSplash) {
        guard let keyWindow = self.window else { return }
        self.splash?.beiZi_showAd(with: keyWindow)
        //  如果不想显示本次广告
//        self.splash?.beiZi_removeAd()
    }
    /// 开屏展现
    func beiZi_splashDidPresentScreen(_ beiziSplash: BeiZiSplash) {
        if let window = UIApplication.shared.delegate?.window, let vc = window?.rootViewController {
            self.splash?.beiZi_showZoomOutSplashAd(with: vc)
        } else {
            print("🍌🍌 获取 rootViewController 失败....")
        }
    }
    func beiZi_splashBottomView() -> UIView {
        let bgView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENW , height: iPad() ? 159 : 145))
        bgView.backgroundColor = .white
        let startLog = UIImageView.init(image: UIImage.init(named: "start_logo"))
        bgView.addSubview(startLog)
        startLog.snp_makeConstraints { make in
            make.width.equalTo(220)
            make.height.equalTo(110)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        return bgView
    }
    
    /// 开屏广告消失
    func beiZi_splashDidDismissScreen(_ beiziSplash: BeiZiSplash) {
        //请求成功但没有开屏广告数据，通知加载首页
        NotificationCenter.default.post(name: NSNotification.Name.init("ScreenAdFinish"), object: nil)
    }
    
    /// 开屏请求失败
    func beiZi_splash(_ beiziSplash: BeiZiSplash, didFailToLoadAdWithError error: BeiZiRequestError) {
        print("🍌🍌 开屏请求失败 error = \(error.description)")
        
        //请求成功但没有开屏广告数据，通知加载首页
        NotificationCenter.default.post(name: NSNotification.Name.init("ScreenAdFinish"), object: nil)
    }
}

#endif
