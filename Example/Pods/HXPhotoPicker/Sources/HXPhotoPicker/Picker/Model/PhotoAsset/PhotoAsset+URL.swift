//
//  PhotoAsset+URL.swift
//  HXPhotoPicker
//
//  Created by Slience on 2021/7/19.
//

import UIKit
import AVFoundation

public extension PhotoAsset {
    
    typealias AssetURLCompletion = (Result<AssetURLResult, AssetError>) -> Void
    
    /// 获取url
    /// - Parameters:
    ///   - fileConfig: 指定地址，若为heic格式的图片，可以设置图片地址为png / jpeg，内部会自动转换（如果为网络资源则忽略）
    ///   - compression: 压缩参数，nil - 原图
    ///   - completion: 获取完成
    func getURL(
        toFile fileConfig: FileConfig? = nil,
        compression: Compression? = nil,
        completion: @escaping AssetURLCompletion
    ) {
        getAssetURL(
            toFile: fileConfig,
            compression: compression,
            completion: completion
        )
    }
    
    /// 获取url
    /// - Parameters:
    ///   - fileConfig: 指定地址，若为heic格式的图片，可以设置图片地址为png / jpeg，内部会自动转换（如果为网络资源则忽略）
    ///   - compressionQuality: 压缩比例，不传就是原图。gif不会压缩
    ///   - completion: 获取完成
    func getAssetURL(
        toFile fileConfig: FileConfig? = nil,
        compression: Compression? = nil,
        completion: @escaping AssetURLCompletion
    ) {
        if mediaType == .photo {
            if mediaSubType == .livePhoto ||
                mediaSubType == .localLivePhoto {
                getLivePhotoURL(
                    imageFileURL: fileConfig?.imageURL,
                    videoFileURL: fileConfig?.videoURL,
                    compression: compression,
                    completion: completion
                )
                return
            }
            if let imageTarget = compression?.imageTarget {
                getImageURL(
                    toFile: fileConfig?.imageURL,
                    imageTarget: imageTarget,
                    completion: completion
                )
            }else {
                getImageURL(
                    toFile: fileConfig?.imageURL,
                    compressionQuality: compression?.imageCompressionQuality,
                    completion: completion
                )
            }
        }else {
            getVideoURL(
                toFile: fileConfig?.videoURL,
                exportParameter: compression?.videoExportParameter,
                completion: completion
            )
        }
    }
    
    /// 获取图片url
    /// - Parameters:
    ///   - fileURL: 指定地址，若为heic格式的图片，可以设置图片地址为png / jpeg，内部会自动转换（如果为网络资源则忽略）
    ///   - compressionQuality: 压缩比例，不传就是原图。gif不会压缩
    ///   - completion: 获取完成
    func getImageURL(
        toFile fileURL: URL? = nil,
        compressionQuality: CGFloat? = nil,
        completion: @escaping AssetURLCompletion
    ) {
        #if canImport(Kingfisher)
        if isNetworkAsset {
            getNetworkImageURL(
                resultHandler: completion
            )
            return
        }
        #endif
        requestImageURL(
            toFile: fileURL,
            compressionQuality: compressionQuality,
            resultHandler: completion
        )
    }
    
    func getImageURL(
        toFile fileURL: URL? = nil,
        imageTarget: Compression.ImageTarget,
        completion: @escaping AssetURLCompletion
    ) {
        getImage(targetSize: imageTarget.size, targetMode: imageTarget.mode) { image, _ in
            guard let image else {
                completion(.failure(.failed))
                return
            }
            DispatchQueue.global().async {
                let imageData = PhotoTools.getImageData(for: image)
                if let imageData = imageData,
                   let imageURL = PhotoTools.write(
                    toFile: fileURL,
                    imageData: imageData
                   ) {
                    DispatchQueue.main.async {
                        completion(
                            .success(
                                .init(
                                    url: imageURL,
                                    urlType: .local,
                                    mediaType: .photo
                                )
                            )
                        )
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion(.failure(imageData == nil ? .invalidData : .fileWriteFailed))
                }
            }
        }
    }
    
    /// 获取视频url
    /// - Parameters:
    ///   - fileURL: 指定地址（如果为网络资源则忽略）
    ///   - exportParameter: 导出参数，nil 为原始视频
    ///   - exportSession: 导出视频时对应的 AVAssetExportSession
    ///   - completion: 获取完成
    func getVideoURL(
        toFile fileURL: URL? = nil,
        exportParameter: VideoExportParameter? = nil,
        exportSession: ((AVAssetExportSession) -> Void)? = nil,
        completion: @escaping AssetURLCompletion
    ) {
        if isNetworkAsset {
            getNetworkVideoURL(
                resultHandler: completion
            )
            return
        }
        requestVideoURL(
            toFile: fileURL,
            exportParameter: exportParameter,
            exportSession: exportSession,
            resultHandler: completion
        )
    }
    
    /// 获取LivePhoto里的图片和视频URL
    /// - Parameters:
    ///   - imageFileURL: 指定图片地址，若为heic格式的图片，可以设置图片地址为png / jpeg，内部会自动转换（如果为网络资源则忽略）
    ///   - videoFileURL: 指定视频地址（如果为网络资源则忽略）
    ///   - compression: 压缩参数，nil - 原图
    ///   - completion: 获取完成
    func getLivePhotoURL(
        imageFileURL: URL? = nil,
        videoFileURL: URL? = nil,
        compression: Compression? = nil,
        completion: @escaping AssetURLCompletion
    ) {
        requestLivePhotoURL(
            imageFileURL: imageFileURL,
            videoFileURL: videoFileURL,
            compression: compression,
            completion: completion
        )
    }
    
    func getAssetResult(
        toFile fileConfig: PhotoAsset.FileConfig?,
        compression: PhotoAsset.Compression?,
        completion: @escaping (Result<AssetResult, Error>) -> Void
    ) {
        var urlResult: AssetURLResult?
        var image: UIImage?
        var error: Error = PickerError.imageFetchFaild
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "HXPhotoPicker.request.assetResults", qos: .userInitiated)
        queue.async(group: group) {
            let semaphore = DispatchSemaphore(value: 0)
            self.getURL(toFile: fileConfig, compression: compression) {
                switch $0 {
                case .success(let result):
                    urlResult = result
                case .failure(let err):
                    error = err
                }
                semaphore.signal()
            }
            semaphore.wait()
        }
        queue.async(group: group) {
            let semaphore = DispatchSemaphore(value: 0)
            self.requestThumbnailImage(targetWidth: AssetManager.thumbnailTargetWidth) { img, _, info in
                if AssetManager.assetIsDegraded(for: info) {
                    return
                }
                if let img = img {
                    image = img
                }else {
                    error = PickerError.imageFetchFaild
                }
                semaphore.signal()
            }
            semaphore.wait()
        }
        group.notify(queue: .main) {
            if let image = image, let urlResult = urlResult {
                completion(.success(.init(image: image, urlReuslt: urlResult)))
            }else {
                completion(.failure(error))
            }
        }
    }
}

public extension PhotoAsset {
    /// 压缩参数
    struct Compression {
        let imageCompressionQuality: CGFloat?
        let imageTarget: ImageTarget?
        let videoExportParameter: VideoExportParameter?
        
        /// 压缩图片
        /// - Parameter imageCompressionQuality: 图片压缩质量 [0 - 1]
        public init(
            imageCompressionQuality: CGFloat
        ) {
            self.imageCompressionQuality = imageCompressionQuality
            self.imageTarget = nil
            self.videoExportParameter = nil
        }
        
        /// 压缩图片
        /// - Parameter imageTarget: 指定图片大小、裁剪模式
        public init(
            imageTarget: ImageTarget
        ) {
            self.imageTarget = imageTarget
            self.imageCompressionQuality = nil
            self.videoExportParameter = nil
        }
        
        /// 压缩视频
        /// - Parameters:
        ///   - videoExportParameter: 视频分辨率、视频质量 [1-10]
        public init(
            videoExportParameter: VideoExportParameter
        ) {
            self.imageCompressionQuality = nil
            self.imageTarget = nil
            self.videoExportParameter = videoExportParameter
        }
        
        /// 压缩图片、视频
        /// - Parameters:
        ///   - imageCompressionQuality: 图片压缩质量 [0 - 1]
        ///   - videoExportParameter: 视频分辨率、视频质量 [1-10]
        public init(
            imageCompressionQuality: CGFloat,
            videoExportParameter: VideoExportParameter
        ) {
            self.imageCompressionQuality = imageCompressionQuality
            self.imageTarget = nil
            self.videoExportParameter = videoExportParameter
        }
        
        
        /// 压缩图片、视频
        /// - Parameters:
        ///   - imageTarget: 指定图片大小、裁剪模式
        ///   - videoExportParameter: 视频分辨率、视频质量 [1-10]
        public init(
            imageTarget: ImageTarget,
            videoExportParameter: VideoExportParameter
        ) {
            self.imageTarget = imageTarget
            self.videoExportParameter = videoExportParameter
            self.imageCompressionQuality = nil
        }
        
        public struct ImageTarget {
            let size: CGSize
            let mode: HX.ImageTargetMode
            
            public init(size: CGSize, mode: HX.ImageTargetMode = .fill) {
                self.size = size
                self.mode = mode
            }
        }
    }
    
    struct FileConfig {
        public let imageURL: URL?
        public let videoURL: URL?
        
        public init(imageURL: URL, videoURL: URL? = nil) {
            self.imageURL = imageURL
            self.videoURL = videoURL
        }
        
        public init(imageURL: URL? = nil, videoURL: URL) {
            self.imageURL = imageURL
            self.videoURL = videoURL
        }
        
        public init(imageURL: URL, videoURL: URL) {
            self.imageURL = imageURL
            self.videoURL = videoURL
        }
    }
}

@available(iOS 13.0, *)
public protocol PhotoAssetObject {
    static func fetchObject(
        _ photoAsset: PhotoAsset,
        toFile fileConfig: PhotoAsset.FileConfig?,
        compression: PhotoAsset.Compression?
    ) async throws -> Self
}

@available(iOS 13.0, *)
extension URL: PhotoAssetObject {
    
    public static func fetchObject(
        _ photoAsset: PhotoAsset,
        toFile fileConfig: PhotoAsset.FileConfig?,
        compression: PhotoAsset.Compression?
    ) async throws -> Self {
        try await withCheckedThrowingContinuation { continuation in
            photoAsset.getURL(
                toFile: fileConfig,
                compression: compression
            ) {
                switch $0 {
                case .success(let result):
                    continuation.resume(with: .success(result.url))
                case .failure(let error):
                    continuation.resume(with: .failure(PickerError.urlFetchFaild(error)))
                }
            }
        }
    }
}

@available(iOS 13.0, *)
extension UIImage: PhotoAssetObject {
    
    public static func fetchObject(
        _ photoAsset: PhotoAsset,
        toFile fileConfig: PhotoAsset.FileConfig?,
        compression: PhotoAsset.Compression?
    ) async throws -> Self {
        if let imageTarget = compression?.imageTarget {
            return try await photoAsset.image(targetSize: imageTarget.size, targetMode: imageTarget.mode) as! Self
        }
        return try await photoAsset.image(compression?.imageCompressionQuality) as! Self
    }
}

@available(iOS 13.0, *)
extension Data: PhotoAssetObject {
    
    public static func fetchObject(
        _ photoAsset: PhotoAsset,
        toFile fileConfig: PhotoAsset.FileConfig?,
        compression: PhotoAsset.Compression?
    ) async throws -> Self {
        try await withCheckedThrowingContinuation { continuation in
            photoAsset.getImageData {
                switch $0 {
                case .success(let result):
                    continuation.resume(with: .success(result.imageData))
                case .failure(let error):
                    continuation.resume(with: .failure(PickerError.imageDataFetchFaild(error)))
                }
            }
        }
    }
}

@available(iOS 13.0, *)
extension AssetURLResult: PhotoAssetObject {
    public static func fetchObject(
        _ photoAsset: PhotoAsset,
        toFile fileConfig: PhotoAsset.FileConfig?,
        compression: PhotoAsset.Compression?
    ) async throws -> Self {
        try await withCheckedThrowingContinuation { continuation in
            photoAsset.getURL(
                toFile: fileConfig,
                compression: compression
            ) {
                switch $0 {
                case .success(let reuslt):
                    continuation.resume(with: .success(reuslt))
                case .failure(let error):
                    continuation.resume(with: .failure(PickerError.urlResultFetchFaild(error)))
                }
            }
        }
    }
}

@available(iOS 13.0, *)
extension PhotoAsset {
    
    /// 获取 UIImage
    /// - Parameter compression: 压缩参数
    /// - Returns: 获取结果
    public func image(
        _ compression: PhotoAsset.Compression? = nil
    ) async throws -> UIImage {
        try await .fetchObject(self, toFile: nil, compression: compression)
    }
    
    /// 获取 UIImage Data
    /// - Parameter compression: 压缩参数
    /// - Returns: 获取结果
    public func imageData() async throws -> Data {
        try await .fetchObject(self, toFile: nil, compression: nil)
    }
    
    /// 获取 URL
    /// - Parameters:
    ///   - compression: 压缩参数
    ///   - fileConfig: 指定地址（如果为网络资源则忽略）
    /// - Returns: 获取结果
    public func url(
        _ compression: PhotoAsset.Compression? = nil,
        toFile fileConfig: PhotoAsset.FileConfig? = nil
    ) async throws -> URL {
        try await .fetchObject(self, toFile: fileConfig, compression: compression)
    }
    
    /// 获取 AssetURLResult
    /// - Parameters:
    ///   - compression: 压缩参数
    ///   - fileConfig: 指定地址（如果为网络资源则忽略）
    /// - Returns: 获取结果
    public func urlResult(
        _ compression: PhotoAsset.Compression? = nil,
        toFile fileConfig: PhotoAsset.FileConfig? = nil
    ) async throws -> AssetURLResult {
        try await .fetchObject(self, toFile: fileConfig, compression: compression)
    }
    
    /// 获取 AssetResult
    /// - Parameters:
    ///   - compression: 压缩参数
    ///   - fileConfig: 指定地址（如果为网络资源则忽略）
    /// - Returns: 获取结果
    public func assetResult(
        _ compression: PhotoAsset.Compression? = nil,
        toFile fileConfig: PhotoAsset.FileConfig? = nil
    ) async throws -> AssetResult {
        try await .fetchObject(self, toFile: fileConfig, compression: compression)
    }
    
    /// 获取 指定对象
    /// - Parameters:
    ///   - compression: 压缩参数
    ///   - fileConfig: 指定地址（如果为网络资源则忽略）
    /// - Returns: 获取结果
    public func object<T: PhotoAssetObject>(
        _ compression: PhotoAsset.Compression? = nil,
        toFile fileConfig: PhotoAsset.FileConfig? = nil
    ) async throws -> T {
        try await T.fetchObject(self, toFile: fileConfig, compression: compression)
    }
    
    /// 获取`UIImage`，视频为封面图片
    /// - Parameters:
    ///   - targetSize: 指定`imageSize`
    ///   - targetMode: 裁剪模式
    /// - Returns: 获取结果
    public func image(
        targetSize: CGSize,
        targetMode: HX.ImageTargetMode = .fill
    ) async throws -> UIImage {
        try await withCheckedThrowingContinuation { continuation in
            getImage(targetSize: targetSize, targetMode: targetMode) { image, _ in
                if let image = image {
                    continuation.resume(with: .success(image))
                }else {
                    continuation.resume(with: .failure(PickerError.imageFetchFaild))
                }
            }
        }
    }
    
    fileprivate func image(_ compressionQuality: CGFloat?) async throws -> UIImage {
       try await withCheckedThrowingContinuation { continuation in
           getImage(compressionQuality: compressionQuality) { image in
               if let image = image {
                   continuation.resume(with: .success(image))
               }else {
                   continuation.resume(with: .failure(PickerError.imageFetchFaild))
               }
           }
       }
   }
}
