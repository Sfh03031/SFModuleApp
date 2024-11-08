//
//  CLCameraController.swift
//  CLCamera
//
//  Created by Chen JmoVxia on 2024/2/26.
//

import Photos
import SnapKit
import UIKit

// MARK: - JmoVxia---CLCameraViewControllerDelegate

public protocol CLCameraControllerDelegate: AnyObject {
    func cameraController(_ controller: CLCameraController, didFinishTakingPhoto photo: UIImage, data: Data)
    func cameraController(_ controller: CLCameraController, didFinishTakingVideo videoURL: URL)
}

// MARK: - JmoVxia---类-属性

public class CLCameraController: UIViewController {
    public init(config: ((CLCameraConfig) -> Void)? = nil) {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
        modalPresentationCapturesStatusBarAppearance = true
        config?(self.config)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {}

    private lazy var controlView: CLCameraControlView = {
        let view = CLCameraControlView(config: config)
        view.delegate = self
        return view
    }()

    private lazy var hepler: CLCameraHelper = {
        let helper = CLCameraHelper(config: config)
        helper.delegate = self
        return helper
    }()

    private var config = CLCameraConfig()

    public weak var delegate: CLCameraControllerDelegate?
}

// MARK: - JmoVxia---生命周期

public extension CLCameraController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        makeConstraints()
        configData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

// MARK: - JmoVxia---布局

private extension CLCameraController {
    func setupUI() {
        view.backgroundColor = .black
        view.addSubview(controlView)
    }

    func makeConstraints() {
        controlView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - JmoVxia---数据

private extension CLCameraController {
    func configData() {
        CLPermissions.request([.camera, .photoLibrary]) { state in
            guard CLPermissions.isAllowed(.camera) else { return self.showError(.cameraPermissionDenied) }
            guard CLPermissions.isAllowed(.photoLibrary) else { return self.showError(.libPermissionDenied) }
            DispatchQueue.main.async {
                self.setupPreviewLayer()
                self.showAnimation()
            }
        }
    }
}

// MARK: - JmoVxia---override

public extension CLCameraController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }

//    override var prefersStatusBarHidden: Bool {
//        true
//    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

// MARK: - JmoVxia---objc

@objc private extension CLCameraController {}

// MARK: - JmoVxia---私有方法

private extension CLCameraController {
    func setupPreviewLayer() {
        hepler.setupPreviewLayer(to: controlView.previewContentView)
    }

    func showAnimation() {
        controlView.showRunningAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
            self.controlView.showFocusAnimationAt(point: self.controlView.previewContentView.center)
        }
    }

    func stopRunning() {
        hepler.stopRunning()
    }

    func showError(_ error: CLCameraError) {
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: { [weak self] _ in
            switch error {
            case .cameraPermissionDenied,
                 .failedToInitializeCameraDevice,
                 .failedToInitializeMicrophoneDevice,
                 .microphonePermissionDenied,
                 .imageNotFound,
                 .underlying:
                self?.dismiss(animated: true, completion: nil)
            case .libPermissionDenied: break
            }
        }))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - JmoVxia---公共方法

extension CLCameraController {}

// MARK: - JmoVxia---CLCameraHelperDelegate

extension CLCameraController: CLCameraHelperDelegate {
    func cameraHelper(_ helper: CLCameraHelper, didOccurError error: CLCameraError) {
        showError(error)
    }

    func cameraHelper(_ helper: CLCameraHelper, didFinishTakingPhoto photo: UIImage) {
//        let controller = CLCameraImagePreviewController(image: photo)
//        controller.delegate = self
//        present(controller, animated: false, completion: nil)

        let config = MCClipImageConfig()
        config.clipImage = photo

        let vc = MCClipImageViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        vc.initClipFunctionWithConfig(config)
        present(vc, animated: false, completion: nil)
    }

    func cameraHelper(_ helper: CLCameraHelper, didFinishTakingVideo url: URL) {
        let controller = CLCameraVideoPreviewController(url: url)
        controller.delegate = self
        present(controller, animated: false, completion: nil)
    }
}

// MARK: - JmoVxia---CLCameraControlDelegate

extension CLCameraController: CLCameraControlDelegate {
    // 打开相册
    func cameraControlDidTapOpenlib(_ controlView: CLCameraControlView) {
        if CLPermissions.isAllowed(.photoLibrary) {
            let libraryViewController = hepler.imagePickerViewController()
            libraryViewController.modalPresentationStyle = .fullScreen
            present(libraryViewController, animated: true, completion: nil)
        } else { return showError(.libPermissionDenied) }
    }

    // 闪光灯
    func cameraControlDidTapOpenLight(_ controlView: CLCameraControlView, changeConfig config: CLCameraConfig) {
        hepler.cycleFlash(config)
    }

    func cameraControlDidTapExit(_ controlView: CLCameraControlView) {
        dismiss(animated: true, completion: nil)
    }

    func cameraControlDidTapChangeCamera(_ controlView: CLCameraControlView) {
        hepler.switchCamera()
    }

    func cameraControlDidTakePhoto(_ controlView: CLCameraControlView) {
        hepler.capturePhoto()
    }

    func cameraControlDidBeginTakingVideo(_ controlView: CLCameraControlView) {
        hepler.startRecordingVideo()
    }

    func cameraControlDidEndTakingVideo(_ controlView: CLCameraControlView) {
        hepler.stopRecordingVideo()
    }

    func cameraControl(_ controlView: CLCameraControlView, didChangeVideoZoom zoomScale: Double) {
        hepler.zoom(zoomScale)
    }

    func cameraControl(_ controlView: CLCameraControlView, didFocusAt point: CGPoint) {
        hepler.focusAt(point)
    }

    func cameraControlDidPrepareForZoom(_ controlView: CLCameraControlView) {
        hepler.prepareForZoom()
    }
}

// MARK: - JmoVxia---CLCameraImagePreviewControllerDelegate

extension CLCameraController: MCClipImageViewControllerDelegate {
    public func clipImageViewController(_ viewController: MCClipImageViewController, didFinishClipingImage image: UIImage, data: Data) {
        delegate?.cameraController(self, didFinishTakingPhoto: image, data: data)
    }
}

// MARK: - JmoVxia---CLCameraControlDelegate

extension CLCameraController: CLCameraVideoPreviewControllerDelegate {
    func videoPreviewController(_ controller: CLCameraVideoPreviewController, didClickDoneButtonWith videoURL: URL) {
        delegate?.cameraController(self, didFinishTakingVideo: videoURL)
    }
}
