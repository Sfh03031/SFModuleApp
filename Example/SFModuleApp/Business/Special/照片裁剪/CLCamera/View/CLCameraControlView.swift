//
//  CLCameraControlView.swift
//  CLCamera
//
//  Created by Chen JmoVxia on 2024/2/21.
//

import SnapKit
import UIKit

protocol CLCameraControlDelegate: AnyObject {
    func cameraControlDidTapExit(_ controlView: CLCameraControlView)
    func cameraControlDidTapChangeCamera(_ controlView: CLCameraControlView)
    func cameraControlDidTapOpenlib(_ controlView: CLCameraControlView)
    func cameraControlDidTapOpenLight(_ controlView: CLCameraControlView, changeConfig config: CLCameraConfig)
    func cameraControlDidPrepareForZoom(_ controlView: CLCameraControlView)
    func cameraControl(_ controlView: CLCameraControlView, didFocusAt point: CGPoint)
    func cameraControlDidTakePhoto(_ controlView: CLCameraControlView)
    func cameraControlDidBeginTakingVideo(_ controlView: CLCameraControlView)
    func cameraControlDidEndTakingVideo(_ controlView: CLCameraControlView)
    func cameraControl(_ controlView: CLCameraControlView, didChangeVideoZoom zoomScale: Double)
}

class CLCameraControlView: UIView {
    init(config: CLCameraConfig) {
        self.config = config
        super.init(frame: .zero)
        setupUI()
        makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    private lazy var closeBtn: UIButton = {
        let view = UIButton()
        view.setImage(image("ClipImage_close"), for: .normal)
        view.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        return view
    }()

    private(set) lazy var previewContentView: UIView = {
        let view = UIView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(focusTapGes(_:))))
        view.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(zoomPinchGesture(_:))))
        view.backgroundColor = .black
        return view
    }()

    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blurEffect)
        view.isUserInteractionEnabled = false
        view.backgroundColor = .black
        return view
    }()

    private lazy var animationView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isHidden = true
        view.isUserInteractionEnabled = false
        return view
    }()

    private lazy var cameraButton: CLCameraButton = {
        let view = CLCameraButton()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        tapGesture.isEnabled = config.allowTakingPhoto
        view.addGestureRecognizer(tapGesture)
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGesture(_:)))
        longPressGesture.isEnabled = config.allowTakingVideo
        longPressGesture.minimumPressDuration = 0.5
        view.addGestureRecognizer(longPressGesture)
        return view
    }()

    private lazy var tipLabel: UILabel = {
        let view = UILabel()
        view.alpha = 0.0
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.textColor = .white
        view.text = {
            var text = config.allowTakingPhoto ? "请用手机竖屏拍摄录入" : ""
            text += config.allowTakingVideo ? (text.isEmpty ? "按住摄像" : ",按住摄像") : ""
            return text
        }()
        return view
    }()

    private lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.isUserInteractionEnabled = true
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.insetsLayoutMarginsFromSafeArea = true
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .zero
        view.spacing = 0
        return view
    }()

    private lazy var bottomStackView: UIStackView = {
        let view = UIStackView()
        view.isUserInteractionEnabled = true
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.alignment = .center
        view.insetsLayoutMarginsFromSafeArea = true
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 30, left: 0, bottom: 25, right: 0)
        return view
    }()

    private lazy var leftView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var rightView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var libButton: UIButton = {
        let view = UIButton()
        view.contentMode = .center
        view.tintColor = .white
        view.setImage(image("camera_lib")?.withRenderingMode(.alwaysTemplate), for: .normal)
        view.setTitle("相册导入", for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        view.titleLabel?.textAlignment = .right
        view.addTarget(self, action: #selector(libButtonClick), for: .touchUpInside)
        view.imageEdgeInsets = UIEdgeInsets(top: -5, left: 16, bottom: 0, right: 0)
        view.titleEdgeInsets = UIEdgeInsets(top: 44, left: -26, bottom: 0, right: 0)
        return view
    }()

    private lazy var changeCameraButton: UIButton = {
        let view = UIButton()
        view.contentMode = .center
        view.tintColor = .white
        view.setImage(flashImage(config)?.withRenderingMode(.alwaysTemplate), for: .normal)
        view.addTarget(self, action: #selector(flashCameraButtonClick), for: .touchUpInside)
        view.setTitle("闪光灯", for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        view.imageEdgeInsets = UIEdgeInsets(top: -5, left: 16, bottom: 0, right: 0)
        view.titleEdgeInsets = UIEdgeInsets(top: 44, left: -26, bottom: 0, right: 0)
        return view
    }()

    private lazy var focusImageView: UIImageView = {
        let view = UIImageView()
        view.alpha = 0.0
        view.frame = CGRect(origin: .zero, size: CGSize(width: 70, height: 70))
        view.image = image("camera_focus")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .green
        return view
    }()

    private var isAnimating: Bool = false {
        didSet {
            previewContentView.isUserInteractionEnabled = !isAnimating
            cameraButton.isUserInteractionEnabled = !isAnimating
            changeCameraButton.isUserInteractionEnabled = !isAnimating
        }
    }

    private var isRecording: Bool = false {
        didSet {
            libButton.isUserInteractionEnabled = !isRecording
            changeCameraButton.isUserInteractionEnabled = !isRecording
        }
    }

    private var isFocusing: Bool = false

    private var videoTimer: Timer?

    private var videoRecordTime: Double = 0

    private var config: CLCameraConfig

    weak var delegate: CLCameraControlDelegate?
}

// MARK: - JmoVxia---布局

private extension CLCameraControlView {
    func setupUI() {
        backgroundColor = .clear
        addSubview(mainStackView)
        addSubview(previewContentView)
        addSubview(blurEffectView)
        addSubview(animationView)
        addSubview(tipLabel)
        addSubview(focusImageView)
        topView.addSubview(closeBtn)
        mainStackView.addArrangedSubview(topView)
        mainStackView.addArrangedSubview(previewContentView)
        mainStackView.addArrangedSubview(bottomStackView)
        bottomStackView.addArrangedSubview(leftView)
        bottomStackView.addArrangedSubview(libButton)
        bottomStackView.addArrangedSubview(cameraButton)
        bottomStackView.addArrangedSubview(changeCameraButton)
        bottomStackView.addArrangedSubview(rightView)
    }

    func makeConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        topView.snp.makeConstraints { make in
//            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(44)
        }

        closeBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(7)
            make.centerY.equalToSuperview()
            make.size.equalTo(30)
        }

        blurEffectView.snp.makeConstraints { make in
            make.edges.equalTo(previewContentView)
        }

        animationView.snp.makeConstraints { make in
            make.edges.equalTo(previewContentView)
        }

        tipLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(previewContentView.snp.top).offset(117.5)
        }

        libButton.snp.makeConstraints { make in
            make.height.equalTo(65)
            make.width.equalTo(60)
        }

        changeCameraButton.snp.makeConstraints { make in
            make.height.equalTo(65)
            make.width.equalTo(60)
        }

        bottomStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
    }
}

// MARK: - JmoVxia---objc

@objc private extension CLCameraControlView {
    func zoomPinchGesture(_ gesture: UIPinchGestureRecognizer) {
        guard gesture.numberOfTouches == 2 else { return }
        if gesture.state == .began { delegate?.cameraControlDidPrepareForZoom(self) }
        delegate?.cameraControl(self, didChangeVideoZoom: gesture.scale)
    }

    func longPressGesture(_ res: UIGestureRecognizer) {
        switch res.state {
        case .began:
            longPressBegin()
            delegate?.cameraControlDidPrepareForZoom(self)
        case .changed:
            let pointY = res.location(in: cameraButton).y
            let zoom = pointY > 0 ? 1 : -pointY / (Double(bounds.width) * 0.15) + 1
            delegate?.cameraControl(self, didChangeVideoZoom: zoom)
        default:
            longPressEnd()
        }
    }

    func focusTapGes(_ gesture: UIGestureRecognizer) {
        showFocusAnimationAt(point: gesture.location(in: previewContentView))
    }

    func cancelButtonClick() {
        delegate?.cameraControlDidTapExit(self)
    }

    func libButtonClick() {
        delegate?.cameraControlDidTapOpenlib(self)
    }

    func tapGesture() {
        delegate?.cameraControlDidTakePhoto(self)
        animationView.isHidden = false
        UIView.animate(withDuration: 0.75) {
            self.animationView.backgroundColor = .clear
        } completion: { _ in
            self.animationView.isHidden = true
            self.animationView.backgroundColor = .black
        }
    }

    func timeRecord() {
        videoRecordTime += 0.1
        let progress = videoRecordTime / config.maximumVideoDuration
        progress >= 1 ? longPressEnd() : cameraButton.updateProgress(progress)
    }

    func changeCameraButtonClick() {
        blurEffectView.effect = UIBlurEffect(style: .regular)
        UIView.transition(with: previewContentView, duration: 0.75, options: .transitionFlipFromLeft) {
            self.blurEffectView.effect = nil
            self.delegate?.cameraControlDidTapChangeCamera(self)
        }
    }

    func flashCameraButtonClick() {
        if config.flashMode == .on {
            config.flashMode = .off
        } else if config.flashMode == .off {
            config.flashMode = .auto
        } else {
            config.flashMode = .on
        }

        changeCameraButton.setImage(flashImage(config)?.withRenderingMode(.alwaysTemplate), for: .normal)
        delegate?.cameraControlDidTapOpenLight(self, changeConfig: config)
    }
}

// MARK: - JmoVxia---私有方法

private extension CLCameraControlView {
    func longPressBegin() {
        isRecording = true
        cameraButton.showBeginAnimation()
        videoTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timeRecord), userInfo: nil, repeats: true)
        delegate?.cameraControlDidBeginTakingVideo(self)
    }

    func longPressEnd() {
        isRecording = false
        guard videoRecordTime != .zero else { return }
        videoTimer?.invalidate()
        videoTimer = nil
        videoRecordTime = .zero
        cameraButton.showEndAnimation()
        delegate?.cameraControlDidEndTakingVideo(self)
    }

    func image(_ name: String) -> UIImage? {
        let filePath = Bundle(for: CLCameraControlView.classForCoder()).resourcePath! + "/CLCamera.bundle"
        let bundle = Bundle(path: filePath)
        let scale = max(min(Int(UIScreen.main.scale), 2), 3)
        return .init(named: "\(name)@\(scale)x", in: bundle, compatibleWith: nil)
    }

    func flashImage(_ mode: CLCameraConfig) -> UIImage? {
        let imageName = switch mode.flashMode {
        case .auto:
            "camera_flashauto"
        case .on:
            "camera_flashon"
        case .off:
            "camera_flashoff"
        }

        return image(imageName)
    }
}

// MARK: - JmoVxia---公共方法

extension CLCameraControlView {
    func showRunningAnimation() {
        guard !isAnimating else { return }
        isAnimating = true
        let blurInAnimator = UIViewPropertyAnimator(duration: 0.75, curve: .easeOut) {
            self.blurEffectView.backgroundColor = nil
        }

        let blurOutAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut) {
            self.blurEffectView.effect = nil
        }

        let tipLabelInAnimator = UIViewPropertyAnimator(duration: 1.0, curve: .easeIn) {
            self.tipLabel.alpha = 1.0
        }

        let tipLabelOutAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut) {
            self.tipLabel.alpha = 0.0
        }

        blurInAnimator.addCompletion { _ in
            blurOutAnimator.startAnimation()
        }

        blurOutAnimator.addCompletion { _ in
            self.isAnimating = false
            tipLabelInAnimator.startAnimation()
        }

        tipLabelInAnimator.addCompletion { _ in
            tipLabelOutAnimator.startAnimation(afterDelay: 2.0)
        }

        blurInAnimator.startAnimation()
    }

    func showFocusAnimationAt(point: CGPoint) {
        guard !isFocusing else { return }
        isFocusing = true

        focusImageView.center = previewContentView.convert(point, to: focusImageView.superview)
        focusImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        focusImageView.alpha = 1.0

        let transformIn = UIViewPropertyAnimator(duration: 0.3, curve: .easeIn) {
            self.focusImageView.alpha = 0.1
            self.focusImageView.transform = .identity
        }
        let alphaIn = UIViewPropertyAnimator(duration: 0.3, curve: .easeIn) {
            self.focusImageView.alpha = 1.0
        }
        let alphaOut = UIViewPropertyAnimator(duration: 0.2, curve: .easeOut) {
            self.focusImageView.alpha = 0.0
        }
        transformIn.addCompletion { _ in
            alphaIn.startAnimation()
        }
        alphaIn.addCompletion { _ in
            alphaOut.startAnimation()
        }
        alphaOut.addCompletion { _ in
            self.isFocusing = false
        }
        transformIn.startAnimation()
        delegate?.cameraControl(self, didFocusAt: point)
    }
}
