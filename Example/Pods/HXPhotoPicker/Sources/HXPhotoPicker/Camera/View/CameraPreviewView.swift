//
//  CameraPreviewView.swift
//  HXPhotoPicker
//
//  Created by Slience on 2021/8/30.
//

import UIKit
import AVFoundation

#if !targetEnvironment(macCatalyst)
protocol CameraPreviewViewDelegate: AnyObject {
    func previewView(didPreviewing previewView: CameraPreviewView)
    func previewView(_ previewView: CameraPreviewView, pinchGestureScale scale: CGFloat)
    func previewView(_ previewView: CameraPreviewView, tappedToFocusAt point: CGPoint)
    func previewView(didLeftSwipe previewView: CameraPreviewView)
    func previewView(didRightSwipe previewView: CameraPreviewView)
}

class CameraPreviewView: UIView {
    weak var delegate: CameraPreviewViewDelegate?
    
    var metalView: PreviewMetalView = .init()
    private var filterNameLb: UILabel!
    private var imageMaskView: UIImageView!
    private var shadeView: UIVisualEffectView!
    private var focusView: CameraFocusView!
    let config: CameraConfiguration
    var maxScale: CGFloat {
        config.videoMaxZoomScale
    }
    var effectiveScale: CGFloat = 1
    var beginGestureScale: CGFloat = 1
    
    var pixelBuffer: CVPixelBuffer? {
        didSet {
            metalView.pixelBuffer = pixelBuffer
        }
    }
    let cameraManager: CameraManager
    init(
        config: CameraConfiguration,
        cameraManager: CameraManager
    ) {
        self.config = config
        self.cameraManager = cameraManager
        super.init(frame: .zero)
        addSubview(metalView)
        metalView.didPreviewing = { [weak self] isPreviewing in
            guard let self = self else { return }
            if isPreviewing {
                self.removeMask()
                self.delegate?.previewView(didPreviewing: self)
            }
        }
        initViews()
    }
    private func initViews() {
        filterNameLb = UILabel()
        filterNameLb.textColor = .white
        filterNameLb.textAlignment = .center
        filterNameLb.font = .boldSystemFont(ofSize: 45)
        filterNameLb.shadowColor = .black.withAlphaComponent(0.4)
        filterNameLb.shadowOffset = .init(width: -1, height: 1)
        filterNameLb.isUserInteractionEnabled = false
        filterNameLb.alpha = 0
        filterNameLb.isHidden = true
        addSubview(filterNameLb)
        
        imageMaskView = UIImageView(image: PhotoManager.shared.cameraPreviewImage)
        imageMaskView.contentMode = .scaleAspectFill
        imageMaskView.clipsToBounds = true
        addSubview(imageMaskView)
        
        shadeView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        addSubview(shadeView)
        
        focusView = CameraFocusView(
            size: CGSize(width: 80, height: 80),
            color: config.tintColor
        )
        focusView.layer.opacity = 0
        focusView.isUserInteractionEnabled = false
        addSubview(focusView)
    }
    
    func setupGestureRecognizer() {
        let pinch = UIPinchGestureRecognizer(
            target: self,
            action: #selector(handlePinchGesture(_:))
        )
        pinch.delegate = self
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTapGesture(_:))
        )
        
        let leftSwipe = UISwipeGestureRecognizer(
            target: self,
            action: #selector(handleSwipeGesture(_:))
        )
        leftSwipe.direction = .left
        let rightSwipe = UISwipeGestureRecognizer(
            target: self,
            action: #selector(handleSwipeGesture(_:))
        )
        rightSwipe.direction = .right
            
        addGestureRecognizer(pinch)
        addGestureRecognizer(tap)
        addGestureRecognizer(leftSwipe)
        addGestureRecognizer(rightSwipe)
    }

    @objc
    func handlePinchGesture(_ pinch: UIPinchGestureRecognizer) {
        if pinch.state == .changed {
            let scale = beginGestureScale * pinch.scale
            effectiveScale = min(scale, maxScale)
            effectiveScale = max(effectiveScale, 1)
            delegate?.previewView(self, pinchGestureScale: effectiveScale)
        }
    }
    
    @objc
    func handleTapGesture(_ tap: UITapGestureRecognizer) {
        let point = tap.location(in: metalView)
        PhotoTools.focusAnimation(for: focusView, at: point)
        delegate?.previewView(self, tappedToFocusAt: captureDevicePoint(for: point))
    }
    
    @objc
    func handleSwipeGesture(_ swipe: UISwipeGestureRecognizer) {
        if swipe.direction == .left {
            delegate?.previewView(didLeftSwipe: self)
        }else {
            delegate?.previewView(didRightSwipe: self)
        }
    }
    func showFilterName(_ filterName: String, _ isRight: Bool) {
        filterNameLb.layer.removeAllAnimations()
        filterNameLb.text = filterName.localized
        filterNameLb.isHidden = false
        filterNameLb.alpha = 0
        filterNameLb.centerX = !isRight ? width * 0.5 + 50 :  width * 0.5 - 50
        UIView.animate(withDuration: 0.25) {
            self.filterNameLb.alpha = 1
            self.filterNameLb.centerX = self.width * 0.5
        } completion: { isFinished in
            if !isFinished { return }
            UIView.animate(withDuration: 0.25, delay: 1) {
                self.filterNameLb.alpha = 0
            } completion: { _ in
                if self.filterNameLb.alpha == 0 {
                    self.filterNameLb.isHidden = true
                }
            }
        }
    }
    
    func initialFocus() {
        let point = CGPoint(x: width * 0.5, y: height * 0.5)
        PhotoTools.focusAnimation(for: focusView, at: point)
        delegate?.previewView(self, tappedToFocusAt: captureDevicePoint(for: point))
    }
    func resetOrientation() {
        guard let capture = cameraManager.videoOutput.connection(with: .video),
              capture.isVideoOrientationSupported else { return }
        let videoOrientation: AVCaptureVideoOrientation
        let interfaceOrientation = UIApplication.shared.statusBarOrientation
        switch interfaceOrientation {
        case .portrait:
            videoOrientation = .portrait
        case .portraitUpsideDown:
            videoOrientation = .portraitUpsideDown
        case .landscapeLeft:
            videoOrientation = .landscapeLeft
        case .landscapeRight:
            videoOrientation = .landscapeRight
        default:
            videoOrientation = .portrait
        }
        capture.videoOrientation = videoOrientation
        if let videoDevicePosition = cameraManager.activeVideoInput?.device.position {
            let rotation = PreviewMetalView.Rotation(
                with: interfaceOrientation,
                videoOrientation: capture.videoOrientation,
                cameraPosition: videoDevicePosition
            )
            metalView.mirroring = (videoDevicePosition == .front)
            if let rotation = rotation {
                metalView.rotation = rotation
            }
        }
    }
    
    func resetMask(_ image: UIImage?) {
        if let image = image {
            metalView.pixelBuffer = nil
            imageMaskView.image = image
        }
        imageMaskView.alpha = 1
        addSubview(imageMaskView)
        shadeView.viewWithTag(1)?.alpha = 1
        let effect = UIBlurEffect(style: .light)
        shadeView.effect = effect
        addSubview(shadeView)
    }
    
    func removeMask(_ animation: Bool = true) {
        if shadeView.superview == nil {
            return
        }
        if animation {
            UIView.animate(withDuration: 0.35) {
                self.shadeView.effect = nil
                self.shadeView.viewWithTag(1)?.alpha = 0
                self.imageMaskView.alpha = 0
            } completion: { _ in
                self.shadeView.removeFromSuperview()
                self.imageMaskView.removeFromSuperview()
                self.initialFocus()
            }
        }else {
            shadeView.effect = nil
            shadeView.removeFromSuperview()
            imageMaskView.removeFromSuperview()
            initialFocus()
        }
    }
    
    func captureDevicePoint(for point: CGPoint) -> CGPoint {
        guard let texturePoint = metalView.texturePointForView(point: point) else {
            return CGPoint(x: 0.5, y: 0.5)
        }
        return texturePoint
    }
    func clearMeatalPixelBuffer() {
        metalView.pixelBuffer = nil
        metalView.flushTextureCache()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        metalView.frame = bounds
        imageMaskView.frame = bounds
        shadeView.frame = bounds
        filterNameLb.frame = CGRect(x: 0, y: 0, width: width, height: height - 130)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CameraPreviewView: UIGestureRecognizerDelegate {
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UIPinchGestureRecognizer {
            beginGestureScale = effectiveScale
        }
        return true
    }
}

class CameraFocusView: UIView {
    private var rectLayer: CAShapeLayer!
    private var lineLayer: CAShapeLayer!
    private let color: UIColor
    init(
        size: CGSize,
        color: UIColor
    ) {
        self.color = color
        super.init(frame: CGRect(origin: .zero, size: size))
        
        rectLayer = CAShapeLayer()
        rectLayer.lineWidth = 2
        rectLayer.lineJoin = .round
        rectLayer.lineCap = .round
        rectLayer.strokeColor = color.cgColor
        rectLayer.fillColor = UIColor.clear.cgColor
        rectLayer.contentsScale = UIScreen._scale
        let rectPath = UIBezierPath(rect: bounds)
        rectLayer.path = rectPath.cgPath
        layer.addSublayer(rectLayer)
        
        lineLayer = CAShapeLayer()
        lineLayer.lineWidth = 1
        lineLayer.lineJoin = .round
        lineLayer.lineCap = .round
        lineLayer.strokeColor = color.cgColor
        lineLayer.fillColor = UIColor.clear.cgColor
        let linePath = UIBezierPath()
        let lineLength: CGFloat = 10
        linePath.move(to: CGPoint(x: width * 0.5, y: 0))
        linePath.addLine(to: CGPoint(x: width * 0.5, y: lineLength))
        
        linePath.move(to: CGPoint(x: width * 0.5, y: height - lineLength))
        linePath.addLine(to: CGPoint(x: width * 0.5, y: height))
        
        linePath.move(to: CGPoint(x: 0, y: height * 0.5))
        linePath.addLine(to: CGPoint(x: lineLength, y: height * 0.5))
        
        linePath.move(to: CGPoint(x: width - lineLength, y: height * 0.5))
        linePath.addLine(to: CGPoint(x: width, y: height * 0.5))
        
        lineLayer.path = linePath.cgPath
        layer.addSublayer(lineLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        rectLayer.frame = bounds
        lineLayer.frame = bounds
    }
}

extension PreviewMetalView.Rotation {
    init?(
        with interfaceOrientation: UIInterfaceOrientation,
        videoOrientation: AVCaptureVideoOrientation,
        cameraPosition: AVCaptureDevice.Position
    ) {
        switch videoOrientation {
        case .portrait:
            switch interfaceOrientation {
            case .landscapeRight:
                if cameraPosition == .front {
                    self = .rotate90Degrees
                } else {
                    self = .rotate270Degrees
                }
                
            case .landscapeLeft:
                if cameraPosition == .front {
                    self = .rotate270Degrees
                } else {
                    self = .rotate90Degrees
                }
                
            case .portrait:
                self = .rotate0Degrees
                
            case .portraitUpsideDown:
                self = .rotate180Degrees
                
            default: return nil
            }
        case .portraitUpsideDown:
            switch interfaceOrientation {
            case .landscapeRight:
                if cameraPosition == .front {
                    self = .rotate270Degrees
                } else {
                    self = .rotate90Degrees
                }
                
            case .landscapeLeft:
                if cameraPosition == .front {
                    self = .rotate90Degrees
                } else {
                    self = .rotate270Degrees
                }
                
            case .portrait:
                self = .rotate180Degrees
                
            case .portraitUpsideDown:
                self = .rotate0Degrees
                
            default: return nil
            }
            
        case .landscapeRight:
            switch interfaceOrientation {
            case .landscapeRight:
                self = .rotate0Degrees
                
            case .landscapeLeft:
                self = .rotate180Degrees
                
            case .portrait:
                if cameraPosition == .front {
                    self = .rotate270Degrees
                } else {
                    self = .rotate90Degrees
                }
                
            case .portraitUpsideDown:
                if cameraPosition == .front {
                    self = .rotate90Degrees
                } else {
                    self = .rotate270Degrees
                }
                
            default: return nil
            }
            
        case .landscapeLeft:
            switch interfaceOrientation {
            case .landscapeLeft:
                self = .rotate0Degrees
                
            case .landscapeRight:
                self = .rotate180Degrees
                
            case .portrait:
                if cameraPosition == .front {
                    self = .rotate90Degrees
                } else {
                    self = .rotate270Degrees
                }
                
            case .portraitUpsideDown:
                if cameraPosition == .front {
                    self = .rotate270Degrees
                } else {
                    self = .rotate90Degrees
                }
                
            default: return nil
            }
        @unknown default:
            fatalError("Unknown orientation.")
        }
    }
}
#endif
