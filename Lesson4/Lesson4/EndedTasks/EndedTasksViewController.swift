//
//  EndedTasksViewController.swift
//  Lesson4
//
//  Created by Михаил Беленко on 18.05.2021.
//

import UIKit
import SnapKit

protocol EndedTasksViewController: class {
    func reloadTableView()
}

// MVVM
final class EndedTasksViewControllerImp: UIViewController {
    
    private var viewModel: EndedTasksViewModel?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = EndedTasksViewModelImp(viewController: self)
        
        addSubviews()
        setupConstraints()
        configureTableView()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInset = .init(top: 0, left: 0, bottom: 80, right: 0)
        
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
    }
}

extension EndedTasksViewControllerImp: EndedTasksViewController {
    func reloadTableView() {
        tableView.reloadData()
    }
}

extension EndedTasksViewControllerImp: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeOpenedContextualAction(forRowAt: indexPath)
        ])
    }
    
    //MARK: - Contextual Actions
    private func makeOpenedContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: "Возобновить") { [weak viewModel] (action, swipeButtonView, completion) in
            
            viewModel?.openTask(index: indexPath.row, status: indexPath.section == 0 ? .closed : .deleted)
            
            completion(true)
        }
    }
}

extension EndedTasksViewControllerImp: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "Закрытые" : "Удаленные"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (section == 0 ? viewModel?.getClosedTaskCount() : viewModel?.getDeletedTaskCount()) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let task = viewModel?.getTask(index: indexPath.row, status: indexPath.section == 0 ? .closed : .deleted) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? TaskTableViewCell else {
                let cell = TaskTableViewCell(style: .default, reuseIdentifier: Constants.cellIdentifier)
                cell.update(task: task)
                return cell
            }
            cell.update(task: task)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
