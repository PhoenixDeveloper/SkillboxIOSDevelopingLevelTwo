//
//  TaskEntity.swift
//  Lesson4
//
//  Created by Михаил Беленко on 18.05.2021.
//

import RealmSwift

enum TaskStatus: String {
    case opened, closed, deleted
}

class TaskEntity: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var descriptionTask: String = ""
    @objc dynamic var createdDate: Date = Date()
    @objc dynamic var deadline: Date = Date()
    @objc dynamic var statusString: String = "opened"
    
    lazy var status: TaskStatus = TaskStatus(rawValue: statusString) ?? .opened
    
    override class func ignoredProperties() -> [String] {
        ["status"]
    }
}
