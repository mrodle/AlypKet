//
//  CreateItem.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 4/25/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
class CreateItemModel: Codable {
    var data: CreateItem
}

class CreateItem: Codable {
    var inFavorite: Bool
    var photo: [String]?
    var _id: String
    var title: String
    var description: String
    var phone: String
    var fromLocation: String
    var toLocation: String
    var mass: Int
    var price: Int
    var date: String
    var user: String
    var createdAt: String
    var slug: String
    var __v: Int
    var id: String

}
