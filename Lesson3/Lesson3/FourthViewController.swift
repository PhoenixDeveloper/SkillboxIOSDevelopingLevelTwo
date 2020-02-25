//
//  FourthViewController.swift
//  Lesson3
//
//  Created by Михаил Беленко on 25.02.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FourthViewController: UIViewController {

    var disposeBag = DisposeBag()

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!

    private var counter = BehaviorRelay(value: 0)

    override func viewDidLoad() {
        super.viewDidLoad()

        counter.map { $0.description }.bind(to: counterLabel.rx.text).disposed(by: disposeBag)

        addButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [unowned self] _ in
            self.counter.accept(self.counter.value + 1)
            }).disposed(by: disposeBag)
    }
}
