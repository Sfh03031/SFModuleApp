//
//  CryptoManager.swift
//  crypto
//
//  Created by sfh on 2024/10/16.
//

import UIKit
import CryptoSwift

class CryptoManager: NSObject {
    
    public static let shared = CryptoManager()
    
    /// AES加密
    /// - Parameters:
    ///   - target: 需要加密的数据
    ///   - aesKey: 原始秘钥
    ///   - iv: 原始偏移量
    /// - Returns: 加密后数据
    func aes_encryptToBase64(_ target: String, aesKey: String, iv: String) -> String {
        var result = ""
        do {
            let aes = try AES(key: aesKey.bytes, blockMode: CBC(iv: iv.bytes), padding: .pkcs5)
            result = try target.encryptToBase64(cipher: aes)
        } catch let error {
            print(error.localizedDescription.description)
        }
        return result
    }
    
    /// AES解密
    /// - Parameters:
    ///   - target: 需要解密的数据
    ///   - aesKey: 原始秘钥
    ///   - iv: 原始偏移量
    /// - Returns: 解密后数据
    func aes_decryptBase64ToString(_ target: String, aesKey: String, iv: String) -> String {
        var result = ""
        do {
            let aes = try AES(key: aesKey.bytes, blockMode: CBC(iv: iv.bytes), padding: .pkcs5)
            result = try target.decryptBase64ToString(cipher: aes)
        } catch {
            print(error.localizedDescription.description)
        }
        
        return result
    }
    
    /// AES解密
    /// - Parameters:
    ///   - target: 需要解密的数据
    ///   - aesKey: 原始字节秘钥
    ///   - iv: 原始字节偏移量
    /// - Returns: 解密后数据
    func aes_decryptBase64ToString(_ target: String, aesKey: Array<UInt8>, iv: Array<UInt8>) -> String {
        var result = ""
        do {
            let aes = try AES(key: aesKey, blockMode: CBC(iv: iv), padding: .pkcs5)
            result = try target.decryptBase64ToString(cipher: aes)
        } catch {
            print(error.localizedDescription.description)
        }
        
        return result
    }
    
    /// 解密
    /// - Parameters:
    ///   - urlPath: 资源链接，视频/音频/PDF或本地资源
    ///   - aesKey: 秘钥, base64格式
    ///   - iv: 偏移量, base64格式
    ///   - isByte: 原始秘钥/原始偏移量是字节还是字符串
    /// - Returns: 解密后的真实地址
    func decryptIfNeeded(_ urlPath: String, aesKey: String, iv: String, isByte: Bool) -> String {
        // 拦截，没有加密的无需解密
        if urlPath.hasPrefix("http://") || urlPath.hasPrefix("https://") || urlPath.hasPrefix("file://") {
            return urlPath
        }
        if isByte {
            let originKey = base64ToBytes(value: aesKey)
            let originIv = base64ToBytes(value: iv)
            return aes_decryptBase64ToString(urlPath, aesKey: originKey, iv: originIv)
        } else {
            let originKey = base64ToString(value: aesKey)
            let originIv = base64ToString(value: iv)
            return aes_decryptBase64ToString(urlPath, aesKey: originKey, iv: originIv)
        }
        
    }
    
    /// base64转普通编码
    /// - Parameter value: base64秘钥
    /// - Returns: 秘钥原文字节
    func base64ToBytes(value: String) -> Array<UInt8> {
        let decodedData = Data(base64Encoded: value, options: .ignoreUnknownCharacters) ?? Data()
        return decodedData.bytes
    }
    
    /// base64转普通编码
    /// - Parameter value: base64秘钥
    /// - Returns: 秘钥原文字符串
    func base64ToString(value: String) -> String {
        let decodedData = Data(base64Encoded: value, options: .ignoreUnknownCharacters) ?? Data()
        return String(data: decodedData, encoding: .utf8) ?? ""
    }
}
