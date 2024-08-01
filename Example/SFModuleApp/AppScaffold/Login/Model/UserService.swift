//
//  UserService.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/16.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

public class UserService: NSObject {
    @objc public static let service = UserService()
    
    /// 用户信息
    public private(set) var userModel: UserModel?
    /// token
    @objc public private(set) var token: String?
    /// 是否登录
    @objc public var isLogin: Bool { !(token?.isEmpty ?? true)}
    
    private override init() {
        super.init()
        if let dict = UserDefaults.standard.value(forKey: userDateStandKey) as? [String: Any] {
            self.userModel = UserModel.deserialize(from: dict)
        }
        if let token = UserDefaults.standard.value(forKey: tokenStandKey) as? String {
            self.token = token
        }
    }
}

public extension UserService {
    
    /// 用户登出, 会重新刷新页面
    @objc func logout() {
        if isLogin == false {
            goToLogin()
        } else {
            cleanUserDate()
            goToLogin()
        }
    }
    
    /// 登录成功
    @objc func loginSuccess() {
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "loginSuccess"), object: self, userInfo: nil)
    }

    /// 清除用户信息
    @objc func cleanUserDate() {
        userModel = nil
        token = nil
        UserDefaults.standard.removeObject(forKey: userDateStandKey)
        UserDefaults.standard.removeObject(forKey: tokenStandKey)
    }
    
    /// 前往登陆页, 不会重新刷新页面
    @objc func goToLogin() {
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "goToLogin"), object: self, userInfo: nil)
    }

    /// 保存用户信息
    @objc func saveUserDate(_ model: UserModel?) {
        guard let model = model, let json = model.toJSON() else { return }
        self.userModel = model
        UserDefaults.standard.setValue(json, forKey: userDateStandKey)
    }
    
    /// 保存token
    @objc func saveToken(_ token: String) {
        self.token = token
        UserDefaults.standard.setValue(token, forKey: tokenStandKey)
    }
}
