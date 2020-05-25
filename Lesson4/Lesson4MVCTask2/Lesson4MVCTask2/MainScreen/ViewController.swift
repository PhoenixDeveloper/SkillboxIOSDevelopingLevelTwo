//
//  ViewController.swift
//  Lesson4MVCTask2
//
//  Created by Михаил Беленко on 25.05.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit
import DTTableViewManager
import SnapKit
import RxCocoa
import RxSwift

class ViewController: UIViewController, DTTableViewManageable {

    @IBOutlet weak var tableView: UITableView!

    private var disposeBag = DisposeBag()

    private lazy var addTaskView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 70))
        let button = DefaultButton()
        button.setTitle("Добавить задачу", for: .normal)

        button.rx.controlEvent(.touchUpInside).subscribe(onNext: { [unowned self] _ in
            self.showAddTaskAlert()
        }).disposed(by: self.disposeBag)

        view.addSubview(button)

        button.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        manager.register(TaskTableViewCell.self)
        tableView.tableHeaderView = addTaskView

        manager.memoryStorage.setItems(Persistence.storage.getTasks())

        manager.didSelect(TaskTableViewCell.self, { [unowned self] _, model, _ in
            Persistence.storage.deleteTask(task: model)
            self.manager.memoryStorage.setItems(Persistence.storage.getTasks())
        })
    }

    func showAddTaskAlert() {

        let alert = UIAlertController(title: "Добавление задачи", message: "Введите название задачи", preferredStyle: .alert)

        alert.addTextField()
        let textField = alert.textFields![0] // Force unwrapping because we know it exists.
        let saveAction = UIAlertAction(title: "OK", style: .default, handler: { [unowned self] (_) in
            let task = TaskModel()
            task.name = textField.text!
            Persistence.storage.addTask(task: task)
            self.manager.memoryStorage.addItem(task)
        })

        let cancelAction = UIAlertAction(title: "Отмена",
            style: .default) { (action: UIAlertAction!) -> Void in
        }

        textField.rx.text.subscribe(onNext: { text in
            if let text = text, !text.isEmpty {
                saveAction.isEnabled = true
            }
            else {
                saveAction.isEnabled = false
            }
            }).disposed(by: disposeBag)

        alert.addAction(saveAction)
        alert.addAction(cancelAction)


        self.present(alert, animated: true, completion: nil)
    }



}

