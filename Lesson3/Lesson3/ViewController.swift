//
//  ViewController.swift
//  Lesson3
//
//  Created by Михаил Беленко on 25.02.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    var disposeBag = DisposeBag()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Observable.merge(emailTextField.rx.controlEvent(.editingChanged).asObservable(), passwordTextField.rx.controlEvent(.editingChanged).asObservable()).subscribe(onNext: { [unowned self] _ in
            self.submitButton.isEnabled = self.checkErrors()
            }).disposed(by: disposeBag)
    }

    private func checkErrors() -> Bool {
        guard let email = emailTextField.text, let password = passwordTextField.text else { errorLabel.text = "Unknown error"; return false }

        if !isValidEmail(email) { errorLabel.text = "Некорректная почта"; return false }

        if password.count < 6 { errorLabel.text = "Слишком короткий пароль"; return false }

        errorLabel.text = ""
        return true
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

