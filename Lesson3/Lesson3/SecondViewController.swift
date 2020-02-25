//
//  SecondViewController.swift
//  Lesson3
//
//  Created by Михаил Беленко on 25.02.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SecondViewController: UIViewController {

    var disposeBag = DisposeBag()

    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.rx.controlEvent(.editingChanged)
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] _ in
                guard let text = self.searchTextField.text, !text.isEmpty else { return }

                print("Отправка запроса для \"\(text)\"")
            }).disposed(by: disposeBag)
    }
}
