//
//  FontBlasterTableVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/4/30.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import JohnWick
import FontBlaster

class FontBlasterTableVC: UITableViewController {
    
    private lazy var fontNames = ["OpenSans",
                                  "OpenSans-Bold",
                                  "OpenSans-BoldItalic",
                                  "OpenSans-Extrabold",
                                  "OpenSans-ExtraboldItalic",
                                  "OpenSans-Italic",
                                  "OpenSans-Light",
                                  "OpenSans-Semibold",
                                  "OpenSans-SemiboldItalic",
                                  "OpenSansLight-Italic"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset.top = TopHeight
        
        let img = SFSymbol.symbol(name: "pencil.slash", pointSize: 25.0, weight: .regular, scale: .default, tintColor: .systemTeal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: img!, style: .plain, target: self, action: #selector(add(_:)))
    }
    
    @objc func add(_ sender: UIBarButtonItem) {
        navigationItem.rightBarButtonItem = nil
        FontBlaster.debugEnabled = true
        FontBlaster.blast { fonts -> Void in
            SFLog("Loaded Fonts: \(fonts)")
            self.fontNames = fonts.sorted()
            self.tableView.reloadSections([0], with: .automatic)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ReuseIdentifier")
        let fontName = fontNames[indexPath.item]
        if let label = cell.textLabel {
            label.text = fontName
            label.font = UIFont(name: fontName, size: label.font.pointSize)
        }
        return cell
    }

}
