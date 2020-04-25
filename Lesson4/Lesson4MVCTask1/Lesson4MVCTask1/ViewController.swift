//
//  ViewController.swift
//  Lesson4MVCTask1
//
//  Created by Михаил Беленко on 25.04.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit
import DTTableViewManager
import Alamofire

class ViewController: UIViewController, DTTableViewManageable {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        manager.register(CategoryTableViewCell.self)
    }

    private func getCategories() {
        AF.request(URL(string: "https://blackstarshop.ru/index.php?route=api/v1/categories")!).responseJSON { json in
            jso
        }
    }


}

