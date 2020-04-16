//
//  SendMessageModel.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 4/15/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
class SendMessageModel: Codable {
    var data: CodeMessage?
//    var success: Bool
}

class CodeMessage: Codable {
    var message: Int?
    var code: String?
}
