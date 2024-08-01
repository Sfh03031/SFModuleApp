//
//  BouncyTableVC.swift
//  SFModuleApp_Example
//
//  Created by sfh on 2024/5/7.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

enum Example {
    case chatMessage
    case photosCollection
    case barGraph
    
    static let count = 3
    
    func controller() -> BouncyLayoutVC {
        return BouncyLayoutVC(example: self)
    }
    
    var title: String {
        switch self {
        case .chatMessage: return "Chat Messages"
        case .photosCollection: return "Photos Collection"
        case .barGraph: return "Bar Graph"
        }
    }
}

class BouncyTableVC: UITableViewController {

    let examples: [Example] = [.barGraph, .photosCollection, .chatMessage]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Examples"
        
        tableView.contentInset.top = TopHeight
        tableView.contentInset.bottom = SoftHeight
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if #available(iOS 11.0, *) {
//            navigationController?.navigationBar.prefersLargeTitles = true
//        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Example.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = examples[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(examples[indexPath.row].controller(), animated: true)
    }
}
