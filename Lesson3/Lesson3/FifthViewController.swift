//
//  FifthViewController.swift
//  Lesson3
//
//  Created by Михаил Беленко on 25.02.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FifthViewController: UIViewController {

    var disposeBag = DisposeBag()

    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var readyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Observable.zip(firstButton.rx.controlEvent(.touchUpInside), secondButton.rx.controlEvent(.touchUpInside)).subscribe(onNext: { _ in
            self.readyLabel.textColor = UIColor.systemGreen
            self.readyLabel.text = "Ракета запущена"
            }).disposed(by: disposeBag)
    }
}
