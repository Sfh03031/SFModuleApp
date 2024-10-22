//
//  CameraGlobals.swift
//  ALCameraViewController
//
//  Created by Alex Littlejohn on 2016/02/16.
//  Copyright © 2016 zero. All rights reserved.
//

import AVFoundation
import UIKit

let itemSpacing: CGFloat = 1
let columns: CGFloat = 4
let thumbnailDimension = (UIScreen.main.bounds.width - ((columns * itemSpacing) - itemSpacing)) / columns
let scale = UIScreen.main.scale

public class CameraGlobals {
    public static let shared = CameraGlobals()

//    public var bundle = Bundle(for: CameraViewController.self)
    public var stringsTable = "CameraView"
    public var photoLibraryThumbnailSize = CGSize(width: thumbnailDimension, height: thumbnailDimension)
    public var defaultCameraPosition = AVCaptureDevice.Position.back
}
