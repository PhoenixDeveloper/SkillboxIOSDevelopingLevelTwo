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
        getCategories() { [unowned self] categories in
            self.manager.memoryStorage.setItems(categories)
        }
    }

    private func getCategories(_ function: @escaping (([CategoriesModel]) -> Void)) {
        AF.request(URL(string: "https://blackstarshop.ru/index.php?route=api/v1/categories")!).responseJSON { response in
            if let data = response.data {
                let parse = try! JSONDecoder().decode(Dictionary<String, CategoriesModel>.self, from: data)
                let categories = parse.map({ $1 })
                function(categories)
            }
        }
    }


}

