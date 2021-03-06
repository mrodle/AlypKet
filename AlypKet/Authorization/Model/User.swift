//
//  User.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 3/19/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
class User: Codable {
    var photo: String?
    var role: String
    var _id: String
    var name: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var iin: Int?
    var phone: Int
    var isOnline: Bool
    var pushIsOn: Bool
    var createdAt: String
    var __v: Int

}
