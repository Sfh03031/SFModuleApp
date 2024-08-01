//
//  CLSingleImageFetcher.swift
//  ALCameraViewController
//
//  Created by Alex Littlejohn on 2016/02/16.
//  Copyright © 2016 zero. All rights reserved.
//

import Photos
import UIKit

public typealias SingleImageFetcherSuccess = (UIImage) -> Void
public typealias SingleImageFetcherFailure = (NSError) -> Void

public class SingleImageFetcher {
    private let errorDomain = "com.zero.singleImageSaver"

    private var success: SingleImageFetcherSuccess?
    private var failure: SingleImageFetcherFailure?

    private var asset: PHAsset?
    private var targetSize = PHImageManagerMaximumSize
    private var cropRect: CGRect?

    public init() {}

    public func onSuccess(_ success: @escaping SingleImageFetcherSuccess) -> Self {
        self.success = success
        return self
    }

    public func onFailure(_ failure: @escaping SingleImageFetcherFailure) -> Self {
        self.failure = failure
        return self
    }

    public func setAsset(_ asset: PHAsset) -> Self {
        self.asset = asset
        return self
    }

    public func setTargetSize(_ targetSize: CGSize) -> Self {
        self.targetSize = targetSize
        return self
    }

    public func setCropRect(_ cropRect: CGRect) -> Self {
        self.cropRect = cropRect
        return self
    }

    public func fetch() -> Self {
        _fetch()
        return self
    }

    private func _fetch() {
        guard let asset else {
            let errorString = "图片初始化失败"
            let errorInfo = [NSLocalizedDescriptionKey: errorString]
            let error = NSError(domain: errorDomain, code: 0, userInfo: errorInfo)
            failure?(error)
            return
        }

        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true

        if let cropRect {
            options.normalizedCropRect = cropRect
            options.resizeMode = .exact

            let targetWidth = floor(CGFloat(asset.pixelWidth) * cropRect.width)
            let targetHeight = floor(CGFloat(asset.pixelHeight) * cropRect.height)

            targetSize = CGSize(width: targetWidth, height: targetHeight)
        }

        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options) { image, _ in
            if let image {
                self.success?(image)
            } else {
                let errorString = "图片初始化失败"
                let errorInfo = [NSLocalizedDescriptionKey: errorString]
                let error = NSError(domain: self.errorDomain, code: 0, userInfo: errorInfo)
                self.failure?(error)
            }
        }
    }
}
