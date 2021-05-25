//
//  NewTaskInteractor.swift
//  Lesson4
//
//  Created by Михаил Беленко on 19.05.2021.
//

import Foundation

protocol NewTaskInteractor: class {
    func save(name: String, deadline: Date, description: String)
}

// VIPER
final class NewTaskInteractorImp: NewTaskInteractor {
    weak private var presenter: NewTaskPresenter?
    
    init(presenter: NewTaskPresenter) {
        self.presenter = presenter
    }
    
    func save(name: String, deadline: Date, description: String) {
        DBManager.shared.addTask(name: name, deadline: deadline, description: description)
        presenter?.dismiss()
    }
}
