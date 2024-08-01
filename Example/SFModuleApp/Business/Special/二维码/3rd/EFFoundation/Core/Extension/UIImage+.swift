//
//  UIImage+.swift
//  EFFoundation
//
//  Created by EyreFree on 2019/8/15.
//


import CoreGraphics
import ImageIO

#if canImport(UIKit)
import UIKit

#if canImport(CoreImage)
import CoreImage
#endif

public extension UIImage {

    #if canImport(CoreImage)
    func ciImage() -> CIImage? {
        return ciImage ?? CIImage(image: self)
    }
    #endif

    func cgImage() -> CGImage? {
        let rtnValue: CGImage? = cgImage
        #if canImport(CoreImage)
        if nil == rtnValue {
            return ciImage()?.cgImage()
        }
        #endif
        return rtnValue
    }
}


#if os(iOS)
public extension UIImage {

    static let appIcon: UIImage? = {
        if let icons = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String: Any],
            let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
            let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
            let lastIcon = iconFiles.last {
            return UIImage(named: lastIcon)
        }
        return nil
    }()

    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        UIGraphicsBeginImageContext(size)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let tryCGImage = newImage?.cgImage {
            self.init(cgImage: tryCGImage)
        } else {
            return nil
        }
    }

    func cornerRadiused(radius: CGFloat) -> UIImage? {
        let imageLayer: CALayer = CALayer()
        imageLayer.frame = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        imageLayer.contents = self.cgImage
        imageLayer.masksToBounds = true
        imageLayer.cornerRadius = radius
        UIGraphicsBeginImageContext(self.size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageLayer.render(in: context)
        let roundedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage
    }

    var png: Data? {
        
        return UIImagePNGRepresentation(self)
    }

    func jpg(compressionQuality: CGFloat = 1) -> Data? {
        return UIImageJPEGRepresentation(self, compressionQuality)
    }

    func resize(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    func nine(insets: UIEdgeInsets? = nil) -> UIImage {
        let insets: UIEdgeInsets? = insets ?? {
            let width: CGFloat = self.size.width
            let height: CGFloat = self.size.height
            if width > 3 && height > 3 {
                let hMargin: CGFloat = (width - 1) / 2
                let vMargin: CGFloat = (height - 1) / 2
                return UIEdgeInsets(top: vMargin, left: hMargin, bottom: vMargin, right: hMargin)
            }
            printLog("UIImage size too small!")
            return nil
            } (
        )
        guard let insetsV = insets else { return self }
        return self.resizableImage(withCapInsets: insetsV, resizingMode: .stretch)
    }
}
#endif

// GIF
fileprivate struct AssociatedObjectKeys {
    static var dataGifKey: String = "dataGifKey"
}

public extension UIImage {

    var dataGif: Data? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectKeys.dataGifKey) as? Data
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectKeys.dataGifKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    static func gif(data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            printLog("SwiftGif: Source for the image does not exist")
            return nil
        }
        let image: UIImage? = UIImage.animatedImageWithSource(source)
        image?.dataGif = data
        return image
    }

    static func gif(url: String) -> UIImage? {
        guard let bundleURL = URL(string: url) else {
            printLog("SwiftGif: This image named \"\(url)\" does not exist")
            return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            printLog("SwiftGif: Cannot turn image named \"\(url)\" into NSData")
            return nil
        }
        return gif(data: imageData)
    }

    static func gif(name: String) -> UIImage? {
        guard let bundleURL = Bundle.main.url(forResource: name, withExtension: "gif") else {
            printLog("SwiftGif: This image named \"\(name)\" does not exist")
            return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            printLog("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        return gif(data: imageData)
    }

    internal static func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay: Double = 0.1
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
        if CFDictionaryGetValueIfPresent(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque(), gifPropertiesPointer) == false {
            return delay
        }
        let gifProperties: CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()), to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        delay = delayObject as? Double ?? 0
        if delay < 0.1 {
            delay = 0.1
        }
        return delay
    }

    internal static func gcdForPair(_ paramA: Int?, _ paramB: Int?) -> Int {
        guard var a = paramA, var b = paramB else {
            if let paramB = paramB {
                return paramB
            } else if let paramA = paramA {
                return paramA
            }
            return 0
        }
        if a < b {
            let c = a
            a = b
            b = c
        }
        var rest: Int
        while true {
            rest = a % b
            if rest == 0 {
                return b
            } else {
                a = b
                b = rest
            }
        }
    }

    internal static func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        var gcd: Int = array[0]
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        return gcd
    }

    internal static func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count: Int = CGImageSourceGetCount(source)
        var images: [CGImage] = [CGImage]()
        var delays: [Int] = [Int]()

        for i in 0 ..< count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            let delaySeconds: Double = UIImage.delayForImageAtIndex(Int(i), source: source)
            delays.append(Int(delaySeconds * 1000.0))
        }

        let duration: Int = {
            var sum: Int = 0
            for val: Int in delays {
                sum += val
            }
            return sum
        }()

        let gcd: Int = gcdForArray(delays)
        var frames: [UIImage] = [UIImage]()

        var frame: UIImage
        var frameCount: Int
        for i in 0 ..< count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            for _ in 0 ..< frameCount {
                frames.append(frame)
            }
        }

        let animation = UIImage.animatedImage(with: frames, duration: Double(duration) / 1000.0)
        return animation
    }
}
#endif
