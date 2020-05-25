//
//  CategoryTableViewCell.swift
//  Lesson4MVCTask1
//
//  Created by Михаил Беленко on 25.04.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit
import DTModelStorage
import Kingfisher
import SnapKit

class CategoryTableViewCell: UITableViewCell, ModelTransfer {

    private let imageSize: CGSize = CGSize(width: 100, height: 100)

    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    func update(with model: CategoriesModel) {
        nameLabel.text = model.name
        categoryImageView.kf.setImage(with: URL(string: "https://blackstarshop.ru/\(model.image)"))
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(nameLabel)
        contentView.addSubview(categoryImageView)

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        categoryImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(16)
            make.size.equalTo(imageSize)
        }

        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(categoryImageView.snp.trailing).offset(8)
            make.top.trailing.bottom.equalToSuperview().inset(16)
        }
    }

}
