//
//  UIImage+Extension.swift
//  CLCarmera
//
//  Created by Chen JmoVxia on 2024/2/27.
//

import UIKit

extension UIImage {
    func rotated(by orientation: UIImage.Orientation) -> UIImage {
        func swapWidthHeight(_ rect: inout CGRect) {
            (rect.size.width, rect.size.height) = (rect.size.height, rect.size.width)
        }

        let rect = CGRect(origin: .zero, size: size)
        var bounds = rect
        var transform = CGAffineTransform.identity

        switch orientation {
        case .up:
            return self
        case .upMirrored:
            transform = transform.translatedBy(x: rect.width, y: 0).scaledBy(x: -1, y: 1)
        case .down:
            transform = transform.translatedBy(x: rect.width, y: rect.height).rotated(by: .pi)
        case .downMirrored:
            transform = transform.translatedBy(x: 0, y: rect.height).scaledBy(x: 1, y: -1)
        case .left:
            swapWidthHeight(&bounds)
            transform = transform.translatedBy(x: 0, y: rect.width).rotated(by: CGFloat.pi * 3 / 2)
        case .leftMirrored:
            swapWidthHeight(&bounds)
            transform = transform.translatedBy(x: rect.height, y: rect.width).scaledBy(x: -1, y: 1).rotated(by: CGFloat.pi * 3 / 2)
        case .right:
            swapWidthHeight(&bounds)
            transform = transform.translatedBy(x: rect.height, y: 0).rotated(by: CGFloat.pi / 2)
        case .rightMirrored:
            swapWidthHeight(&bounds)
            transform = transform.scaledBy(x: -1, y: 1).rotated(by: CGFloat.pi / 2)
        @unknown default:
            return self
        }

        UIGraphicsBeginImageContext(bounds.size)
        defer {
            UIGraphicsEndImageContext()
        }

        guard let context = UIGraphicsGetCurrentContext() else { return self }
        switch orientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            context.scaleBy(x: -1, y: 1)
            context.translateBy(x: -rect.height, y: 0)
        default:
            context.scaleBy(x: 1, y: -1)
            context.translateBy(x: 0, y: -rect.height)
        }
        context.concatenate(transform)
        if let cgImage {
            context.draw(cgImage, in: rect)
        }
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}

extension UIImage {
    // 通过rect，裁切图片
    func crop(toRect: CGRect) -> UIImage {
        let imageRef = cgImage?.cropping(to: toRect)
        let image = UIImage(cgImage: imageRef!, scale: scale, orientation: imageOrientation)

        return image
    }
}

extension UIImage {
    /// 修复图片旋转
    func fixOrientation() -> UIImage {
        if imageOrientation == .up {
            return self
        }
        var transform = CGAffineTransform.identity
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: .pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: -.pi / 2)
        default:
            break
        }
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            break
        }
        let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage!.bitsPerComponent, bytesPerRow: 0, space: cgImage!.colorSpace!, bitmapInfo: cgImage!.bitmapInfo.rawValue)
        ctx?.concatenate(transform)
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.height), height: CGFloat(size.width)))
        default:
            ctx?.draw(cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.width), height: CGFloat(size.height)))
        }
        let cgimg: CGImage = (ctx?.makeImage())!
        let img = UIImage(cgImage: cgimg)
        return img
    }
}
