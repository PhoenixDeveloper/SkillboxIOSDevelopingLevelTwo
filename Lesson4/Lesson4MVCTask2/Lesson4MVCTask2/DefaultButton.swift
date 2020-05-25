//
//  DefaultButton.swift
//  Lesson4MVCTask2
//
//  Created by Михаил Беленко on 25.05.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit

class DefaultButton: UIButton {
    private var isSetuped = false

    override func layoutSubviews() {
        super.layoutSubviews()

        if isSetuped { return }
        isSetuped = true

        setTitleColor(.white, for: .normal)

        backgroundColor = .systemBlue
        layer.cornerRadius = 10
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
    }
}
