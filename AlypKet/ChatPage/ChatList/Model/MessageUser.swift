//
//  MessageList.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 5/30/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
import  UIKit
class MessageUser: Codable {
    var id: Int
    var fromUserName: String
    var message: String
    var date: String
    var thomb: String
    
    init(id: Int, fromUserName: String, message: String, date: String, thomb: String) {
        self.id = id
        self.fromUserName = fromUserName
        self.message = message
        self.date = date
        self.thomb = thomb
    }
}
