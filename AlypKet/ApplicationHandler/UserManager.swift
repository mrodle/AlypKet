//
//  UserManager.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 3/19/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
class UserManager {

    //    MARK: - Properties
    static let userDefaults = UserDefaults.standard

    //    MARK: - Creation of user session

    static func createSessionWithUser(_ user: AuthModel) throws {
        let jsonEncoder = JSONEncoder()
        do {
            
            let userData = try jsonEncoder.encode(user.user)
            guard let token = user.token else { return }
            setCurrentToken(to: token)
            userDefaults.set(userData, forKey: Key.currentUser)
            
        } catch {
            throw error
        }
    }
    
    private static func setCurrentToken(to token: String) {
        userDefaults.set(token, forKey: Key.currentToken)
    }
    
    static func getCurrentToken() -> String? {
        return userDefaults.string(forKey: Key.currentToken)
    }
    
    static func getCurrentUser() -> User? {
        let jsonDecoder = JSONDecoder()
        if let userData = userDefaults.value(forKey: Key.currentUser) as? Data {
            do {
                let currentUser = try jsonDecoder.decode(User.self, from: userData)
                return currentUser
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    static func deleteCurrentSession() {
        userDefaults.set(nil, forKey: Key.currentToken)
        userDefaults.set(nil, forKey: Key.currentUser)
    }
}
