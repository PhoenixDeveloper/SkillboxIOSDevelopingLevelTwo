//
//  DBManager.swift
//  Lesson4
//
//  Created by Михаил Беленко on 18.05.2021.
//

import RealmSwift
import RxSwift

final class DBManager {
    static let shared = DBManager()
    
    private let changeTaskSubject = PublishSubject<TaskEntity>()
    private let changeTasksSubject = PublishSubject<Void>()
    
    var changeTask: Observable<TaskEntity> {
        changeTaskSubject.share()
    }
    
    var changeTasks: Observable<Void> {
        changeTasksSubject.share()
    }
    
    private let disposeBag = DisposeBag()
    
    private lazy var tasks: [TaskEntity] = Array(self.realm.objects(TaskEntity.self))
    
    private let realm = try! Realm()
    
    private init() {
        changeTask.subscribe(onNext: { [weak self] task in
            do {
                try self?.realm.write {
                    task.statusString = task.status.rawValue
                }
                
                self?.changeTasksSubject.onNext(())
            }
            catch(let error) {
                print(error.localizedDescription)
            }
        }).disposed(by: disposeBag)
    }
    
    func addTask(name: String, deadline: Date, description: String) {
        do {
            let task = TaskEntity()
            task.title = name
            task.deadline = deadline
            task.descriptionTask = description
            
            try realm.write {
                realm.add(task)
            }
            
            tasks.append(task)
            
            changeTaskSubject.onNext(task)
        }
        catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    func getOpenedTasks() -> [TaskEntity] {
        tasks.filter({ $0.status == .opened })
    }
    
    func getClosedTasks() -> [TaskEntity] {
        tasks.filter({ $0.status == .closed })
    }
    
    func getDeletedTasks() -> [TaskEntity] {
        tasks.filter({ $0.status == .deleted })
    }
    
    func openTask(task: TaskEntity) {
        do {
            try realm.write {
                task.status = .opened
                task.statusString = TaskStatus.opened.rawValue
            }
            
            changeTaskSubject.onNext(task)
        }
        catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    func closeTask(task: TaskEntity) {
        do {
            try realm.write {
                task.status = .closed
                task.statusString = TaskStatus.closed.rawValue
            }
            
            changeTaskSubject.onNext(task)
        }
        catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    func deleteTask(task: TaskEntity) {
        do {
            try realm.write {
                task.status = .deleted
                task.statusString = TaskStatus.deleted.rawValue
            }
            
            changeTaskSubject.onNext(task)
        }
        catch(let error) {
            print(error.localizedDescription)
        }
    }
}
