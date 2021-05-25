//
//  TaskTableViewCell.swift
//  Lesson4
//
//  Created by Михаил Беленко on 18.05.2021.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var deadlineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        return dateFormatter
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initilization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(task: TaskEntity) {
        titleLabel.text = task.title
        deadlineLabel.text = "Выполнить до: \(dateFormatter.string(from: task.deadline))"
        descriptionLabel.text = task.descriptionTask
        
        switch task.status {
        case .opened:
            titleLabel.textColor = .black
            deadlineLabel.textColor = .darkGray
            descriptionLabel.textColor = .black
        case .closed:
            titleLabel.textColor = .darkGray
            deadlineLabel.textColor = .gray
            descriptionLabel.textColor = .lightGray
        case .deleted:
            titleLabel.textColor = .systemRed
            deadlineLabel.textColor = .systemRed
            descriptionLabel.textColor = .systemRed
        }
    }
    
    private func initilization() {
        selectionStyle = .none
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(deadlineLabel)
        addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
        }
        
        deadlineLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(deadlineLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
}
