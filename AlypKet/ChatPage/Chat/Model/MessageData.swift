//
//  MessageData.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 4/7/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
class MessageData: Codable {
    var message: String
    var destination: String
    
    init(message: String, destination: String) {
        self.message = message
        self.destination = destination
    }
    
}

