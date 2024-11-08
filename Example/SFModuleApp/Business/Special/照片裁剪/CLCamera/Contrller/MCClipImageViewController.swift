//
//  MCClipImageViewController.swift
//  MCAPI
//
//  Created by MC on 2018/9/14.
//  Copyright © 2020年 MC. All rights reserved.
//

import Accelerate
import Foundation
import QuartzCore
import UIKit
import Photos

@objc public protocol MCClipImageViewControllerDelegate {
    @objc optional func clipImageViewControllerDidCancel(_ viewController: MCClipImageViewController)

    func clipImageViewController(_ viewController: MCClipImageViewController, didFinishClipingImage image: UIImage, data: Data)
}

public class MCClipImageViewController: UIViewController {
    public weak var delegate: MCClipImageViewControllerDelegate?

    // 裁剪的目标图片
    private var targetImage: UIImage = .init()
    // 裁剪的区域尺寸
    private var cropSize: CGSize = .zero
    // 裁切框的frame
    private var cropFrame = CGRect()
    // 镂空的frame
    private var otherFrame = CGRect()
    // 裁剪框
    private let cropOverlay = CropOverlay()
    private var cropOverlayLeftConstraint = NSLayoutConstraint()
    private var cropOverlayTopConstraint = NSLayoutConstraint()
    private var cropOverlayWidthConstraint = NSLayoutConstraint()
    private var cropOverlayHeightConstraint = NSLayoutConstraint()

    private var configTemp: MCClipImageConfig!

    public func initClipFunctionWithConfig(_ config: MCClipImageConfig) {
        configTemp = config

        if configTemp.clipImage == nil {
            print("\n\nMCClipImage:\n\n\n image 为nil，请检查！！！")
            return
        }

        targetImage = configTemp.clipImage!.repairOrientation()
        cropSize = CGSize(width: selfWidth, height: selfWidth / configTemp.clipScale)

        functionView.isShowResetScaleButton = configTemp.clipScaleType.count == 0 ? false : true

        // 填充图片数据并设置frame
        setImageViewFrameAndImage()

        // 矩形裁切框
        transparentCutSquareArea()

        // 调整imageView的位置
        scrollViewDidZoom(scrollView)

        // 增加镂空
        addLouKong()
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        baseSetting()

        initUI()
    }

//    // 隐藏状态栏
//    override public var prefersStatusBarHidden: Bool {
//        return true
//    }

    override public var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    /// 镂空部分
    func addLouKong() {
        view.layoutIfNeeded()

        let path = UIBezierPath(rect: containerView.frame)
        let overlayPath = UIBezierPath(rect: otherFrame)
        path.append(overlayPath)

        shapeLayer.path = path.cgPath
        shapeLayer.fillRule = CAShapeLayerFillRule.evenOdd
        containerView.layer.mask = shapeLayer
    }

    // MARK: - Setter & Getter

    private lazy var topView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIDevice.mc_getScreenWith(), height: UIDevice.mc_navBarAndStatusBarHeight()))
        view.backgroundColor = .black
        return view
    }()

    private lazy var closeBtn: UIButton = {
        let view = UIButton(frame: CGRect(x: 7, y: 7 + UIDevice.mc_statusBarHeight(), width: 30, height: 30))
        view.setImage(image("ClipImage_close"), for: .normal)
        view.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        return view
    }()

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.delegate = self
        view.scrollsToTop = false
        view.minimumZoomScale = 0.5
        view.maximumZoomScale = 10
        view.frame = CGRect(x: 0, y: UIDevice.mc_navBarAndStatusBarHeight(), width: selfWidth, height: selfHeight - UIDevice.mc_navBarAndStatusBarHeight() - 120 - UIDevice.mc_bottomSafeAreaHeight())
        view.isUserInteractionEnabled = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        view.contentMode = UIView.ContentMode.scaleAspectFill
        return view
    }()

    private lazy var containerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: selfWidth, height: selfHeight))
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.isUserInteractionEnabled = false
        return view
    }()

    lazy var shapeLayer = CAShapeLayer()

    lazy var functionView: MCClipImageToolBar = {
        let view = MCClipImageToolBar()
        view.cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        view.sureButton.addTarget(self, action: #selector(sureButtonClicked), for: .touchUpInside)
        view.rotatingButton.addTarget(self, action: #selector(rotatingButtonClicked), for: .touchUpInside)
        return view
    }()
}

// MARK: 通知回调，闭包回调，点击事件，网络请求

extension MCClipImageViewController {
    // 取消
    @objc func cancelButtonClicked() {
        delegate?.clipImageViewControllerDidCancel?(self)
        dismiss(animated: false, completion: nil)
    }

//    // 重设裁切框
//    @objc func resetButtonClicked() {
//
//        UIAlertController.showActionSheet(on: self, items: configTemp.clipScaleType, confirm:{ [weak self] (index, value) in
//            self?.scrollView.minimumZoomScale = 1.0
//            self?.scrollView.setZoomScale(1.0, animated: true)
//
//            self?.configTemp.clipScale = value
//            self?.initClipFunctionWithConfig(self?.configTemp ?? MCClipImageConfig())
//        })
//    }

    // 确定
    @objc func sureButtonClicked() {
        let image = getClippingImage()
        let data = compressImage(image, toKB: 900) ?? image.jpegData(compressionQuality: 0.2)
        saveImageToPhotosAlbum(image: image)
        delegate?.clipImageViewController(self, didFinishClipingImage: image, data: data!)
//        dismiss(animated: true, completion: nil)
    }

    // 图片旋转
    @objc func rotatingButtonClicked() {
        // 清空之前设置的scale。否则会错乱
        scrollView.minimumZoomScale = 0.5
        scrollView.setZoomScale(1.0, animated: true)

        let image = targetImage.rotationImage(orientation: .left)
        imageView.image = image
        targetImage = image

//        configTemp.clipImage = image
//        initClipFunctionWithConfig(configTemp)
    }
    
    
    func saveImageToPhotosAlbum(image: UIImage) {
        // 确保应用有权访问相册
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                // 保存图片到相册
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }
    }
}

// MARK: UI的处理,通知的接收

extension MCClipImageViewController {
    func baseSetting() {
        view.backgroundColor = UIColor.black
        scrollView.contentInsetAdjustmentBehavior = .never
    }

    func initUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        view.addSubview(containerView)
        view.addSubview(cropOverlay)

        view.addSubview(topView)
        topView.addSubview(closeBtn)
        view.addSubview(functionView)

        let y = selfHeight - 120 - UIDevice.mc_bottomSafeAreaHeight()
        functionView.frame = CGRect(x: 0, y: y, width: selfWidth, height: 120)

//        overlayView.frame = view.frame
//        scrollView.frame = CGRect.init(x: 0, y: 0, width: selfWidth, height: selfHeight)
    }

    func setImageViewFrameAndImage() {
        // 1.添加图片
        imageView.image = targetImage

        // 2.设置裁剪区域
        let x = (selfWidth - cropSize.width) / 2
        let y = (selfHeight - cropSize.height) / 2
        cropFrame = CGRect(x: x, y: ceil(y), width: cropSize.width, height: cropSize.height)
        otherFrame = CGRect(x: x + 15, y: ceil(y + 15), width: cropSize.width - 30, height: cropSize.height - 30)
        // 3.计算imgeView的frame
        let imageW = targetImage.size.width
        let imageH = targetImage.size.height
        let cropW = cropSize.width
        var imageViewW, imageViewH, imageViewX, imageViewY: CGFloat
        imageViewW = cropW
        imageViewH = imageH * imageViewW / imageW
        imageViewX = (selfWidth - imageViewW) / 2
        imageViewY = (selfHeight - imageViewH) / 2

        imageView.frame = CGRect(x: imageViewX, y: ceil(imageViewY), width: imageViewW, height: imageViewH)

        scrollView.contentSize = imageView.frame.size
    }

    // 设置矩形裁剪区域
    func transparentCutSquareArea() {
        cropOverlay.translatesAutoresizingMaskIntoConstraints = false

        cropOverlayLeftConstraint = cropOverlay.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        cropOverlayTopConstraint = cropOverlay.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        cropOverlayWidthConstraint = cropOverlay.widthAnchor.constraint(equalToConstant: 0)
        cropOverlayHeightConstraint = cropOverlay.heightAnchor.constraint(equalToConstant: 0)

        cropOverlay.delegate = self
        cropOverlay.isHidden = false
        cropOverlay.isResizable = true
        cropOverlay.isMovable = true
        cropOverlay.topOffset = UIDevice.mc_navBarAndStatusBarHeight()
        cropOverlay.bottomOffset = 120 + UIDevice.mc_bottomSafeAreaHeight()
        activateCropOverlayConstraint()
    }

    private func activateCropOverlayConstraint() {
        cropOverlayLeftConstraint.constant = cropFrame.origin.x
        cropOverlayTopConstraint.constant = cropFrame.origin.y
        cropOverlayWidthConstraint.constant = cropFrame.size.width
        cropOverlayHeightConstraint.constant = cropFrame.size.height

        cropOverlayLeftConstraint.isActive = true
        cropOverlayTopConstraint.isActive = true
        cropOverlayWidthConstraint.isActive = true
        cropOverlayHeightConstraint.isActive = true
    }

    private func makeProportionalCropRect() -> CGRect {
        var cropRect = cropOverlay.croppedRect
        cropRect.origin.y = cropRect.origin.y - UIDevice.mc_navBarAndStatusBarHeight()
        cropRect.origin.x += scrollView.contentOffset.x - imageView.frame.origin.x
        cropRect.origin.y += scrollView.contentOffset.y - imageView.frame.origin.y

        let normalizedX = max(0, cropRect.origin.x / imageView.frame.width)
        let normalizedY = max(0, cropRect.origin.y / imageView.frame.height)

        let extraWidth = min(0, cropRect.origin.x)
        let extraHeight = min(0, cropRect.origin.y)

        let normalizedWidth = min(1, (cropRect.width + extraWidth) / imageView.frame.width)
        let normalizedHeight = min(1, (cropRect.height + extraHeight) / imageView.frame.height)

        return CGRect(x: normalizedX, y: normalizedY, width: normalizedWidth, height: normalizedHeight)
    }

    // 获取被裁剪的图片
    func getClippingImage() -> UIImage {
        let cropRect = makeProportionalCropRect()
        let resizedCropRect = CGRect(x: (targetImage.size.width) * cropRect.origin.x,
                                     y: (targetImage.size.height) * cropRect.origin.y,
                                     width: targetImage.size.width * cropRect.width,
                                     height: targetImage.size.height * cropRect.height)

        return targetImage.crop(rect: resizedCropRect)
    }

    func image(_ name: String) -> UIImage? {
        let filePath = Bundle(for: CLCameraControlView.classForCoder()).resourcePath! + "/CLCamera.bundle"
        let bundle = Bundle(path: filePath)
        let scale = max(min(Int(UIScreen.main.scale), 2), 3)
        return .init(named: "\(name)@\(scale)x", in: bundle, compatibleWith: nil)
    }
    
    func compressImage(_ image: UIImage, toKB fileSize: Int) -> Data? {
        let bytes = fileSize * 1024
        var compression: CGFloat = 1.0
        var imageData = image.jpegData(compressionQuality: compression)
        
        while (imageData?.count ?? 0) > bytes && compression > 0 {
            compression -= 0.1
            imageData = image.jpegData(compressionQuality: compression)
        }
        
        if let data = imageData {
            return data
        }
        
        return nil
    }
}

extension MCClipImageViewController: CropOverlayDelegate {
    func didMoveCropOverlay(newFrame: CGRect) {
        cropOverlayLeftConstraint.constant = newFrame.origin.x
        cropOverlayTopConstraint.constant = newFrame.origin.y
        cropOverlayWidthConstraint.constant = newFrame.size.width
        cropOverlayHeightConstraint.constant = newFrame.size.height
        cropFrame = newFrame
        otherFrame = CGRect(x: newFrame.origin.x + 15.0, y: newFrame.origin.y + 15.0, width: newFrame.size.width - 30.0, height: newFrame.size.height - 30.0)
        addLouKong()
    }
}

extension MCClipImageViewController: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }

    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // 图片比例改变以后，让改变后的ImageView保持在ScrollView的中央
//        let size_W = scrollView.bounds.size.width
//        let size_H = scrollView.bounds.size.height
//
//        let contentSize_W = scrollView.contentSize.width
//        let contentSize_H = scrollView.contentSize.height
//
//        let offsetX = (size_W > contentSize_W) ? (size_W - contentSize_W) * 0.5 : 0.0
//        let offsetY = (size_H > contentSize_H) ? (size_H - contentSize_H) * 0.5 : 0.0
//        imageView.center = CGPoint(x: contentSize_W * 0.5 + offsetX, y: contentSize_H * 0.5 + offsetY)
//
//        // 设置scrollView的contentSize，最小为self.view.frame.size
//        let scrollW = contentSize_W >= selfWidth ? contentSize_W : selfWidth
//        let scrollH = contentSize_H >= selfHeight ? contentSize_H : selfHeight
//        scrollView.contentSize = CGSize(width: scrollW, height: scrollH)
//
//        // 设置scrollView的contentInset
//        let imageWidth = imageView.frame.size.width
//        let imageHeight = imageView.frame.size.height
//        let cropWidth = cropSize.width
//        let cropHeight = cropSize.height
//
//        var leftRightInset: CGFloat = 0
//        var topBottomInset: CGFloat = 0
//
//        // imageview的大小和裁剪框大小的三种情况，保证imageview最多能滑动到裁剪框的边缘
//        if imageWidth <= cropWidth {
//            leftRightInset = 0
//        } else if imageWidth >= cropWidth, imageWidth <= selfWidth {
//            leftRightInset = (imageWidth - cropWidth) * 0.5
//        } else {
//            leftRightInset = (selfWidth - cropSize.width) * 0.5
//        }
//
//        if imageHeight <= cropHeight {
//            topBottomInset = 0
//        } else if imageHeight >= cropHeight, imageHeight <= selfHeight {
//            topBottomInset = (imageHeight - cropHeight) * 0.5
//        } else {
//            topBottomInset = (selfHeight - cropSize.height) * 0.5
//        }
//
//        scrollView.contentInset = UIEdgeInsets(top: topBottomInset, left: leftRightInset, bottom: topBottomInset, right: leftRightInset)
        centerScrollViewContent()
    }

    private func centerScrollViewContent() {
        guard let image = imageView.image else {
            return
        }

        let imgViewSize = imageView.frame.size
        let imageSize = image.size

        let realImgSize = if imageSize.width / imageSize.height > imgViewSize.width / imgViewSize.height {
            CGSize(width: imgViewSize.width, height: imgViewSize.width / imageSize.width * imageSize.height)
        } else {
            CGSize(width: imgViewSize.height / imageSize.height * imageSize.width, height: imgViewSize.height)
        }

        var frame = CGRect.zero
        frame.size = realImgSize
        imageView.frame = frame

        let screenSize = scrollView.frame.size
        let offx = screenSize.width > realImgSize.width ? (screenSize.width - realImgSize.width) / 2 : 0
        let offy = screenSize.height > realImgSize.height ? (screenSize.height - realImgSize.height) / 2 : 0
        scrollView.contentInset = UIEdgeInsets(top: offy,
                                               left: offx,
                                               bottom: offy,
                                               right: offx)
    }
}

// 屏幕的宽高
private var selfWidth = UIScreen.main.bounds.size.width
private var selfHeight = UIScreen.main.bounds.size.height

// Helper function inserted by Swift 4.2 migrator.
private func convertToCAShapeLayerFillRule(_ input: String) -> CAShapeLayerFillRule {
    CAShapeLayerFillRule(rawValue: input)
}

extension UIImage {
    func crop(rect: CGRect) -> UIImage {
        var rectTransform = switch imageOrientation {
        case .left:
            CGAffineTransform(rotationAngle: radians(90)).translatedBy(x: 0, y: -size.height)
        case .right:
            CGAffineTransform(rotationAngle: radians(-90)).translatedBy(x: -size.width, y: 0)
        case .down:
            CGAffineTransform(rotationAngle: radians(-180)).translatedBy(x: -size.width, y: -size.height)
        default:
            CGAffineTransform.identity
        }

        rectTransform = rectTransform.scaledBy(x: scale, y: scale)

        if let cropped = cgImage?.cropping(to: rect.applying(rectTransform)) {
            return UIImage(cgImage: cropped, scale: scale, orientation: imageOrientation).fixOrientation()
        }

        return self
    }

    func radians(_ degrees: CGFloat) -> CGFloat {
        degrees / 180 * .pi
    }

    /**
     * 修复图片旋转
     */
    public func repairOrientation() -> UIImage {
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

extension UIDevice {
    /** 屏幕的宽度 */
    @objc static func mc_getScreenWith() -> CGFloat {
        UIScreen.main.bounds.size.width
    }

    /** 屏幕的高度 */
    @objc static func mc_getScreenHeight() -> CGFloat {
        UIScreen.main.bounds.size.height
    }

    /** 顶部安全区高度 */
    @objc static func mc_topSafeAreaHeight() -> CGFloat {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else {
                return 0
            }
            guard let window = windowScene.windows.first else {
                return 0
            }
            return window.safeAreaInsets.top
        } else if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.windows.first else {
                return 0
            }
            return window.safeAreaInsets.top
        }

        return 0
    }

    /** 底部安全区高度 */

    @objc static func mc_bottomSafeAreaHeight() -> CGFloat {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else {
                return 0
            }
            guard let window = windowScene.windows.first else {
                return 0
            }
            return window.safeAreaInsets.bottom
        } else if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.windows.first else {
                return 0
            }
            return window.safeAreaInsets.bottom
        }

        return 0
    }

    /** 顶部状态栏高度(包括安全区) */
    @objc static func mc_statusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0.0
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else {
                return 0
            }
            // i0S14后不准确
//            guard let statusBarManager = windowScene.statusBarManager else {
//                return 0
//            }
//            statusBarHeight = statusBarManager.statusBarFrame.height
            guard let window = windowScene.windows.first else {
                return 0
            }
            statusBarHeight = window.safeAreaInsets.top
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }

        return statusBarHeight
    }

    /** 顶部导航栏高度 */
    @objc static func mc_topNavBarHeight() -> CGFloat {
        44.0
    }

    /** 导航栏 + 状态栏的高度 */
    @objc static func mc_navBarAndStatusBarHeight() -> CGFloat {
        UIDevice.mc_topNavBarHeight() + UIDevice.mc_statusBarHeight()
    }

    /** 底部导航栏高度 */
    @objc static func mc_bottomTabBarHeight() -> CGFloat {
        49.0
    }

    /** 底部导航栏 + 底部安全区的高度 */
    @objc static func mc_tabBarAndBottomSafeAreaHeight() -> CGFloat {
        UIDevice.mc_bottomTabBarHeight() + UIDevice.mc_bottomSafeAreaHeight()
    }
}
