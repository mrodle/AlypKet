//
//  User.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 3/19/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
class User: Codable {
    var id: Int
    var name: String
    var token: String?
    var password: String
    var phone: String
    var device_id: String?
}
