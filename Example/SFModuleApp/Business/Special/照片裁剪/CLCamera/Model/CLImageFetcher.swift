//
//  CLImageFetcher.swift
//  ALImagePickerViewController
//
//  Created by Alex Littlejohn on 2015/06/09.
//  Copyright (c) 2015 zero. All rights reserved.
//

import Photos
import UIKit

public typealias ImageFetcherSuccess = (PHFetchResult<PHAsset>) -> Void
public typealias ImageFetcherFailure = (NSError) -> Void

// extension PHFetchResult: Sequence {
//    public func makeIterator() -> NSFastEnumerationIterator {
//        return NSFastEnumerationIterator(self)
//    }
// }

public class CLImageFetcher {
    private var success: ImageFetcherSuccess?
    private var failure: ImageFetcherFailure?

    private var authRequested = false
    private let errorDomain = "com.zero.imageFetcher"

    let libraryQueue = DispatchQueue(label: "com.zero.ALCameraViewController.LibraryQueue")

    public init() {}

    public func onSuccess(_ success: @escaping ImageFetcherSuccess) -> Self {
        self.success = success
        return self
    }

    public func onFailure(_ failure: @escaping ImageFetcherFailure) -> Self {
        self.failure = failure
        return self
    }

    public func fetch() -> Self {
        onAuthorized()
        return self
    }

    private func onAuthorized() {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        libraryQueue.async {
            let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: options)
            DispatchQueue.main.async {
                self.success?(assets)
            }
        }
    }
}
