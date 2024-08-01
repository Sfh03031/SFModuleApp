//
//  AssetManager.swift
//  照片选择器-Swift
//
//  Created by Silence on 2020/11/9.
//  Copyright © 2020 Silence. All rights reserved.
//

import UIKit
import Photos

public struct AssetManager {
    
    /// 保存资源到系统相册
    /// - Parameters:
    ///   - type: 保存类型
    ///   - customAlbumName: 需要保存到自定义相册的名称，默认BundleName
    ///   - creationDate: 创建时间，默认当前时间
    ///   - location: 位置信息
    @available(iOS 13.0.0, *)
    @discardableResult
    public static func save(
        type: AssetSaveUtil.SaveType,
        customAlbumName: String? = nil,
        creationDate: Date = .init(),
        location: CLLocation? = nil
    ) async throws -> PHAsset {
        try await AssetSaveUtil.save(
            type: type,
            customAlbumName: customAlbumName,
            creationDate: creationDate,
            location: location
        )
    }
    
    /// 保存资源到系统相册
    /// - Parameters:
    ///   - type: 保存类型
    ///   - customAlbumName: 需要保存到自定义相册的名称，默认BundleName
    ///   - creationDate: 创建时间，默认当前时间
    ///   - location: 位置信息
    ///   - completion: 保存之后的结果
    public static func save(
        type: AssetSaveUtil.SaveType,
        customAlbumName: String? = nil,
        creationDate: Date = .init(),
        location: CLLocation? = nil,
        completion: @escaping (Result<PHAsset, Error>) -> Void
    ) {
        AssetSaveUtil.save(
            type: type,
            customAlbumName: customAlbumName,
            creationDate: creationDate,
            location: location,
            completion: completion
        )
    }
}
