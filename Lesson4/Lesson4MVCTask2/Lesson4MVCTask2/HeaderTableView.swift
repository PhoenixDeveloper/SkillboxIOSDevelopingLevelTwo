//
//  HeaderTableView.swift
//  Lesson4MVCTask2
//
//  Created by Михаил Беленко on 25.05.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit
import SnapKit

class HeaderTableView: UITableViewHeaderFooterView {

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        return button
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        contentView.addSubview(button)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        button.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
    }

}
