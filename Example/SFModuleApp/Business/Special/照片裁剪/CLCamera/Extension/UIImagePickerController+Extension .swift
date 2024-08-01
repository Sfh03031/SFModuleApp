//
//  UIImagePickerController+Extension .swift
//  Alamofire
//
//  Created by MC on 2018/12/10.
//

import Foundation
import Photos
import UIKit

/// 相片选择器类型：相册 PhotoLibrary，图库 SavedPhotosAlbum，相机 Camera，前置摄像头 Front，后置摄像头 Rear
public enum UIImagePickerType: Int {
    /// 相册 PhotoLibrary
    case UIImagePickerTypePhotoLibrary = 1
    /// 图库 SavedPhotosAlbum
    case UIImagePickerTypeSavedPhotosAlbum = 2
    /// 相机 Camera
    case UIImagePickerTypeCamera = 3
    /// 前置摄像头 Front
    case UIImagePickerTypeCameraFront = 4
    /// 后置摄像头 Rear
    case UIImagePickerTypeCameraRear = 5
}

public extension UIImagePickerController {
    // MARK: - 设备使用有效性判断

    // 相册 PhotoLibrary，图库 SavedPhotosAlbum，相机 Camera，前置摄像头 Front，后置摄像头 Rear
    class func isValidImagePickerType(type imagePickerType: UIImagePickerType) -> Bool {
        switch imagePickerType {
        case .UIImagePickerTypePhotoLibrary:
            if isValidPhotoLibrary {
                return true
            }
            return false
        case .UIImagePickerTypeSavedPhotosAlbum:
            if isValidSavedPhotosAlbum {
                return true
            }
            return false
        case .UIImagePickerTypeCamera:
            if isValidCameraEnable, isValidCamera {
                return true
            }
            return false
        case .UIImagePickerTypeCameraFront:
            if isValidCameraEnable, isValidCameraFront {
                return true
            }
            return false
        case .UIImagePickerTypeCameraRear:
            if isValidCamera, isValidCameraRear {
                return true
            }
            return false
        }
    }

    /// 相机设备是否启用
    class var isValidCameraEnable: Bool {
        let cameraStatus =
            AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)
        if cameraStatus == AVAuthorizationStatus.denied {
            return false
        }
        return true
    }

    /// 相机Camera是否可用（是否有摄像头）
    class var isValidCamera: Bool {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            return true
        }
        return false
    }

    /// 前置相机是否可用
    class var isValidCameraFront: Bool {
        if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerController.CameraDevice.front) {
            return true
        }
        return false
    }

    /// 后置相机是否可用
    class var isValidCameraRear: Bool {
        if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerController.CameraDevice.rear) {
            return true
        }
        return false
    }

    /// 相册PhotoLibrary是否可用
    class var isValidPhotoLibrary: Bool {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            return true
        }
        return false
    }

    /// 图库SavedPhotosAlbum是否可用
    class var isValidSavedPhotosAlbum: Bool {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum) {
            return true
        }
        return false
    }

    // MARK: - 属性设置

    func setImagePickerStyle(bgroundColor: UIColor?, titleColor: UIColor?, buttonTitleColor: UIColor?) {
        // 改navigationBar背景色
        if let bgroundColorTmp: UIColor = bgroundColor {
            navigationBar.barTintColor = bgroundColorTmp
        }

        // 改navigationBar标题色
        if let titleColorTmp: UIColor = titleColor {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColorTmp]
        }

        // 改navigationBar的button字体色
        if let buttonTitleColorTmp: UIColor = buttonTitleColor {
            navigationBar.tintColor = buttonTitleColorTmp
        }
    }
}
