//
//  NewTaskRouter.swift
//  Lesson4
//
//  Created by Михаил Беленко on 19.05.2021.
//

import UIKit

protocol NewTaskRouter: class {
    func dismiss()
}

// VIPER
final class NewTaskRouterImp: NewTaskRouter {
    weak private var presenter: NewTaskPresenter?
    weak private var navigationController: UINavigationController?
    
    init(presenter: NewTaskPresenter, navigationController: UINavigationController?) {
        self.presenter = presenter
        self.navigationController = navigationController
    }
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
}
