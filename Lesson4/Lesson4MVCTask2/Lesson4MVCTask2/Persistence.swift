//
//  Persistence.swift
//  Lesson4MVCTask2
//
//  Created by Михаил Беленко on 25.05.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import RealmSwift

class Persistence {

    static var storage = Persistence()

    private init() {}

    private lazy var tasks: [TaskModel] = Array(self.realm.objects(TaskModel.self))

    private let realm = try! Realm()

    func addTask(task: TaskModel) {
        try! realm.write {
            realm.add(task)
            tasks.append(task)
        }
    }

    func deleteTask(task: TaskModel) {
        try! realm.write {
            realm.delete(task)
            tasks.removeAll(where: { $0 == task})
        }
    }

    func getTasks() -> [TaskModel] {
        return tasks
    }
}
