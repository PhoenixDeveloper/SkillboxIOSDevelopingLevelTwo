//
//  NewTaskPresenter.swift
//  Lesson4
//
//  Created by Михаил Беленко on 19.05.2021.
//

import UIKit

protocol NewTaskPresenter: class {
    func dismiss()
    func save(name: String, deadline: Date, description: String)
}

// VIPER
final class NewTaskPresenterImp: NewTaskPresenter {
    weak private var viewController: NewTaskViewController?
    private var interactor: NewTaskInteractor?
    private var router: NewTaskRouter?
    
    init(viewController: NewTaskViewController, navigationController: UINavigationController?) {
        self.viewController = viewController
        self.interactor = NewTaskInteractorImp(presenter: self)
        self.router = NewTaskRouterImp(presenter: self, navigationController: navigationController)
    }
    
    func dismiss() {
        router?.dismiss()
    }
    
    func save(name: String, deadline: Date, description: String) {
        interactor?.save(name: name, deadline: deadline, description: description)
    }
}
