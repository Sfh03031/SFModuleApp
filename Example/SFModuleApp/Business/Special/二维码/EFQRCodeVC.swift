//
//  EFQRCodeVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/23.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SafariServices

class EFQRCodeVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.3803921569, green: 0.8117647059, blue: 0.7803921569, alpha: 1)

        setupViews()
    }
    
    func setupViews() {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 48)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.text = "EFQRCode\(version == "" ? "" : "\n\(version)")"
        titleLabel.numberOfLines = 0
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            (make) in
            make.top.leading.equalTo(0)
            make.width.equalTo(view)
            make.height.equalTo(view).dividedBy(2.5)
        }

        let tableView = UITableView()
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = true
        #if os(iOS)
        tableView.separatorColor = .white
        #endif
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            (make) in
            make.leading.equalTo(0)
            make.top.equalTo(titleLabel.snp.bottom)
            make.width.equalTo(view)
            make.height.equalTo(view).dividedBy(3)
        }

        let bottomLabel = UIButton(type: .system)
        bottomLabel.titleLabel?.font = .systemFont(ofSize: 20)
        bottomLabel.setTitleColor(.white, for: .normal)
        bottomLabel.setTitle("https://www.efqrcode.com/", for: .normal)
        #if os(iOS)
        bottomLabel.addTarget(self, action: #selector(openWeb), for: .touchDown)
        #endif
        view.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints {
            (make) in
            make.leading.equalTo(0)
            make.bottom.equalTo(-CGFloat.bottomSafeArea() - 20)
            make.width.equalTo(view)
        }
    }
    
    @objc func openWeb() {
        if let tryUrl = URL(string: "https://www.efqrcode.com/") {
            openURLWithSafari(tryUrl, controller: self)
        }
    }
    
    func openURLWithSafari(_ url: URL, title: String? = nil, controller: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        let safariController: SFSafariViewController = SFSafariViewController(url: url)
        if let title = title {
            safariController.title = title
        }
        if #available(iOS 11.0, *) {
            safariController.dismissButtonStyle = SFSafariViewController.DismissButtonStyle.close
        }
        if #available(iOS 10.0, *) {
            safariController.preferredBarTintColor = UIColor.white
            safariController.preferredControlTintColor = #colorLiteral(red: 0.3803921569, green: 0.8117647059, blue: 0.7803921569, alpha: 1)
        } else {
            safariController.view.tintColor = #colorLiteral(red: 0.3803921569, green: 0.8117647059, blue: 0.7803921569, alpha: 1)
        }
        controller.present(safariController, animated: animated, completion: completion)
    }

    lazy var titles: [String] = {
        #if os(iOS)
        return [
            NSLocalizedString("Recognizer", comment: "Menu option to QR code scanning page"),
            NSLocalizedString("Generator", comment: "Menu option to QR code generation page"),
            NSLocalizedString("More", comment: "Menu option to more page")
        ]
        #else
        return [
            NSLocalizedString("Generator", comment: "Menu option to QR code generation page")
        ]
        #endif
    }()

}

extension EFQRCodeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        #if os(iOS)
        navigationController?.pushViewController(
            [
                RecognizerController.self,
                GeneratorController.self,
                MoreViewController.self
            ][indexPath.row].init(), animated: true
        )
        #else
        navigationController?.pushViewController(GeneratorController(), animated: true)
        #endif
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .zeroHeight
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zeroHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let text = titles[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        cell.textLabel?.text = text
        let backView = UIView()
        backView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.64)
        cell.selectedBackgroundView = backView
        let imageView = UIImageView(image: UIImage(named: text))
        imageView.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        imageView.contentMode = .scaleAspectFit
        cell.accessoryView = imageView
        return cell
    }

    #if os(iOS)
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !UIDevice.current.model.contains("iPad") {
            if titles.count - 1 == indexPath.row {
                cell.separatorInset = UIEdgeInsets(
                    top: 15, left: 0, bottom: 0, right: max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
                )
            }
        }
    }
    #endif
}
