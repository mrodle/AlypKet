//
//  ItemModel.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 4/18/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
class ItemDataModel: Codable {
    var data: ItemModel?
}

class ItemModel: Codable {
    var photo: String
    var _id: String
    var title: String
    var description: String
    var phone: String
    var fromLocation: City
    var toLocation: City
    var price: Int
    var date: String
    var user: String
    var createdAt: String
    var slug: String
    var __v: Int
    var id: String

}

class City: Codable {
    var id: String
    var name: String
}
