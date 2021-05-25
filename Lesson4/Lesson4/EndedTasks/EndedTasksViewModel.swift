//
//  EndedTasksViewModel.swift
//  Lesson4
//
//  Created by Михаил Беленко on 18.05.2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol EndedTasksViewModel: class {
    func getClosedTaskCount() -> Int
    func getDeletedTaskCount() -> Int
    func getTask(index: Int, status: TaskStatus) -> TaskEntity?
    func openTask(index: Int, status: TaskStatus)
}

// MVVM
final class EndedTasksViewModelImp: EndedTasksViewModel {
    weak private var viewController: EndedTasksViewController?
    
    private var closedTasks: [TaskEntity] {
        DBManager.shared.getClosedTasks()
    }
    
    private var deletedTasks: [TaskEntity] {
        DBManager.shared.getDeletedTasks()
    }
    
    private let disposeBag = DisposeBag()
    
    init(viewController: EndedTasksViewController) {
        self.viewController = viewController
        configureEvents()
    }
    
    func getClosedTaskCount() -> Int {
        closedTasks.count
    }
    
    func getDeletedTaskCount() -> Int {
        closedTasks.count
    }
    
    func getTask(index: Int, status: TaskStatus) -> TaskEntity? {
        switch status {
        case .closed:
            return index < closedTasks.count ? closedTasks[index] : nil
        case .deleted:
            return index < deletedTasks.count ? deletedTasks[index] : nil
        default:
            return nil
        }
    }
    
    func openTask(index: Int, status: TaskStatus) {
        switch status {
        case .closed:
            DBManager.shared.openTask(task: closedTasks[index])
        case .deleted:
            DBManager.shared.openTask(task: deletedTasks[index])
        default:
            return
        }
    }
    
    private func configureEvents() {
        DBManager.shared.changeTasks.subscribe(onNext: { [weak viewController] in
            viewController?.reloadTableView()
        }).disposed(by: disposeBag)
    }
}
