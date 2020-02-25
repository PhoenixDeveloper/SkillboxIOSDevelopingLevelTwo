//
//  ThirdTableViewCell.swift
//  Lesson3
//
//  Created by Михаил Беленко on 25.02.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit
import DTModelStorage
import SnapKit

class ThirdTableViewCell: UITableViewCell, ModelTransfer {

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(nameLabel)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with model: String) {
        nameLabel.text = model
    }

    private func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(16)
            make.trailing.greaterThanOrEqualToSuperview().inset(16)
        }
    }
}
