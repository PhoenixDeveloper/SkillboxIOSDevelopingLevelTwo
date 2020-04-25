//
//  CategoriesModel.swift
//  Lesson4MVCTask1
//
//  Created by Михаил Беленко on 25.04.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import Foundation

struct CategoriesModel: Codable {
    public var name: String
    public var sortOrder: String
    public var image: String
    public var iconImage: String
    public var iconImageActive: String
    public var subcategories: [SubcatigoriesModel]
}

struct SubcatigoriesModel: Codable {
    public var id: String
    public var iconImage: String
    public var sortOrder: String
    public var name: String
    public var type: String
}
