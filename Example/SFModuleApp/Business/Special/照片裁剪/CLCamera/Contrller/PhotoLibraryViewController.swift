//
//  PhotoLibraryViewController.swift
//  ALImagePickerViewController
//
//  Created by Alex Littlejohn on 2015/06/09.
//  Copyright (c) 2015 zero. All rights reserved.
//

import Photos
import UIKit

let ImageCellIdentifier = "CLImageCell"

let defaultItemSpacing: CGFloat = 1

public typealias PhotoLibraryViewSelectionComplete = (UIImage) -> Void
private var spinner: UIActivityIndicatorView?

public class PhotoLibraryViewController: UIViewController {
    var assets: PHFetchResult<PHAsset>? = nil

    public var onSelectionComplete: PhotoLibraryViewSelectionComplete?

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        layout.itemSize = CameraGlobals.shared.photoLibraryThumbnailSize
        layout.minimumInteritemSpacing = defaultItemSpacing
        layout.minimumLineSpacing = defaultItemSpacing
        layout.sectionInset = UIEdgeInsets.zero

        let collectionView = UICollectionView(frame: CGRect(x: 0, y: UIDevice.mc_navBarAndStatusBarHeight(), width: UIDevice.mc_getScreenWith(), height: UIDevice.mc_getScreenHeight() - UIDevice.mc_navBarAndStatusBarHeight()), collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }()

    private lazy var topView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIDevice.mc_getScreenWith(), height: UIDevice.mc_navBarAndStatusBarHeight()))
        view.backgroundColor = .black
        return view
    }()

    private lazy var closeBtn: UIButton = {
        let view = UIButton(frame: CGRect(x: 7, y: 7 + UIDevice.mc_statusBarHeight(), width: 30, height: 30))
        view.setImage(image("ClipImage_close"), for: .normal)
        view.addTarget(self, action: #selector(dismissLibrary), for: .touchUpInside)
        return view
    }()

    override public func viewDidLoad() {
        super.viewDidLoad()

        setNeedsStatusBarAppearanceUpdate()

        view.addSubview(topView)
        topView.addSubview(closeBtn)
        view.backgroundColor = .black
        view.addSubview(collectionView)

        _ = CLImageFetcher()
            .onFailure(onFailure)
            .onSuccess(onSuccess)
            .fetch()
    }

    override public var preferredStatusBarStyle: UIStatusBarStyle {
        UIStatusBarStyle.lightContent
    }

    public func present(_ inViewController: UIViewController, animated: Bool) {
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.navigationBar.barTintColor = UIColor.black
        navigationController.navigationBar.barStyle = UIBarStyle.black
        inViewController.present(navigationController, animated: animated, completion: nil)
    }

    @objc public func dismissLibrary() {
        dismiss(animated: true, completion: nil)
    }

    private func onSuccess(_ photos: PHFetchResult<PHAsset>) {
        assets = photos
        configureCollectionView()
    }

    private func onFailure(_ error: NSError) {
        showError(.libPermissionDenied)
    }

    func showError(_ error: CLCameraError) {
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }

    private func configureCollectionView() {
        collectionView.register(CLImageCell.self, forCellWithReuseIdentifier: ImageCellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func itemAtIndexPath(_ indexPath: IndexPath) -> PHAsset? {
        assets?[(indexPath as NSIndexPath).row]
    }

    func showSpinner() {
        spinner = UIActivityIndicatorView()
        spinner!.activityIndicatorViewStyle = .white
        spinner!.center = view.center
        spinner!.startAnimating()

        view.addSubview(spinner!)
        view.bringSubview(toFront: spinner!)
    }

    func hideSpinner() {
        spinner?.stopAnimating()
        spinner?.removeFromSuperview()
    }

    func image(_ name: String) -> UIImage? {
        let filePath = Bundle(for: CLCameraControlView.classForCoder()).resourcePath! + "/CLCamera.bundle"
        let bundle = Bundle(path: filePath)
        let scale = max(min(Int(UIScreen.main.scale), 2), 3)
        return .init(named: "\(name)@\(scale)x", in: bundle, compatibleWith: nil)
    }
}

// MARK: - UICollectionViewDataSource -

extension PhotoLibraryViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        assets?.count ?? 0
    }

    @objc(collectionView:willDisplayCell:forItemAtIndexPath:) public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if cell is CLImageCell {
            if let model = itemAtIndexPath(indexPath) {
                (cell as! CLImageCell).configureWithModel(model)
            }
        }
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: ImageCellIdentifier, for: indexPath)
    }
}

// MARK: - UICollectionViewDelegate -

extension PhotoLibraryViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showSpinner()
        if let asset = itemAtIndexPath(indexPath) {
            _ = SingleImageFetcher()
                .onSuccess { [weak self] image in
                    self?.hideSpinner()
                    self?.dismiss(animated: false, completion: nil)
                    self?.onSelectionComplete?(image)
                }
                .onFailure { [weak self] error in
                    self?.hideSpinner()
                }
                .setAsset(asset)
                .fetch()
        } else {
            hideSpinner()
        }
    }
}
