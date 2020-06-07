//
//  MessageManager.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 5/30/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
class MessageManager {
    //    MARK: - Properties
    static let userDefaults = UserDefaults.standard

    //    MARK: - Creation of user session

    static func setUserList(_ list: [MessageUser]) throws {
        let jsonEncoder = JSONEncoder()
        do {
            
            let userData = try jsonEncoder.encode(list)
            userDefaults.set(userData, forKey: Key.messageUserList)
            
        } catch {
            throw error
        }
    }
    
    
    static func getUserList() -> [MessageUser] {
        let jsonDecoder = JSONDecoder()
        if let userData = userDefaults.value(forKey: Key.messageUserList) as? Data {
            do {
                let list = try jsonDecoder.decode([MessageUser].self, from: userData)
                return list
            } catch {
                print(error.localizedDescription)
            }
        }
        return []
    }
    
    static func setMessageList(_ list: [[MessageData]]) throws {
        let jsonEncoder = JSONEncoder()
        do {
            
            let messageData = try jsonEncoder.encode(list)
            userDefaults.set(messageData, forKey: Key.messageList)
            
        } catch {
            throw error
        }
    }
    
    static func getMessageList() -> [[MessageData]] {
        let jsonDecoder = JSONDecoder()
        if let messageData = userDefaults.value(forKey: Key.messageList) as? Data {
            do {
                let list = try jsonDecoder.decode([[MessageData]].self, from: messageData)
                return list
            } catch {
                print(error.localizedDescription)
            }
        }
        return []
    }

}
