//
//  CurrentTasksViewController.swift
//  Lesson4
//
//  Created by Михаил Беленко on 18.05.2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

// MVC
final class CurrentTasksViewController: UIViewController {
    
    private var tasks: [TaskEntity] {
        DBManager.shared.getOpenedTasks()
    }
    
    private let disposeBag = DisposeBag()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 32
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupConstraints()
        configureTableView()
        configureEvents()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(addButton)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        addButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.size.equalTo(64)
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInset = .init(top: 0, left: 0, bottom: 80, right: 0)
        
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    private func configureEvents() {
        DBManager.shared.changeTasks.subscribe(onNext: { [weak tableView] in
            tableView?.reloadData()
        }).disposed(by: disposeBag)
        
        addButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak navigationController] in
            let newTaskVC = NewTaskViewControllerImp()
            newTaskVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(newTaskVC, animated: true)
        }).disposed(by: disposeBag)
    }
}

extension CurrentTasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeDeleteContextualAction(forRowAt: indexPath),
            makeCloseContextualAction(forRowAt: indexPath)
        ])
    }
    
    //MARK: - Contextual Actions
    private func makeCloseContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: "Закрыть") { [weak self] (action, swipeButtonView, completion) in
            guard let self = self else { return }
            
            DBManager.shared.closeTask(task: self.tasks[indexPath.row])
            
            completion(true)
        }
    }
    
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Удалить") { [weak self] (action, swipeButtonView, completion) in
            guard let self = self else { return }
            
            DBManager.shared.deleteTask(task: self.tasks[indexPath.row])
            
            completion(true)
        }
    }
}

extension CurrentTasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? TaskTableViewCell else { return UITableViewCell() }
        cell.update(task: tasks[indexPath.row])
        return cell
    }
}
