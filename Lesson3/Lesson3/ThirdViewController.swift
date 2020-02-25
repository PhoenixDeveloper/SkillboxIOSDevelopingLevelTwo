//
//  ThirdViewController.swift
//  Lesson3
//
//  Created by Михаил Беленко on 25.02.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import DTTableViewManager

class ThirdViewController: UIViewController, DTTableViewManageable {

    var disposeBag = DisposeBag()
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var deleteLastButton: UIButton!

    @IBOutlet weak var tableView: UITableView!

    private let variantNames = ["Михаил", "Виталий", "Антон", "Алексей", "Марина"]
    private var names = BehaviorRelay(value: ["Михаил", "Виталий", "Антон", "Алексей", "Марина"])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        manager.register(ThirdTableViewCell.self)

        names.subscribe { [unowned self] _ in
            self.manager.memoryStorage.setItems(self.names.value)
        }.disposed(by: disposeBag)

        addButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [unowned self] _ in
            var buffer = self.names.value
            buffer.append(self.variantNames[Int.random(in: 0..<self.variantNames.count)])
            self.names.accept(buffer)
            }).disposed(by: disposeBag)

        deleteLastButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [unowned self] _ in
            var buffer = self.names.value
            buffer.removeLast()
            self.names.accept(buffer)
            }).disposed(by: disposeBag)
    }
}
