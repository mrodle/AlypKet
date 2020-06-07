//
//  AppConstants.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 3/19/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit
class AppConstants {
    static let statusBarHeight = UIApplication.shared.statusBarFrame.height
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
    static let navBarHeight = UINavigationController().navigationBar.bounds.height
    static let saveMe = "saveMe"
    
    static func getTabbarHeight(_ tabBarController: UITabBarController?) -> CGFloat {
        return (tabBarController?.tabBar.frame.size.height)!
    }

    class API {

        //        MARK: - Base Url
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVlOTk1MmIyNzNlMmYzNzVhYzljOTJlNCIsImlhdCI6MTU4NzQwMjc4OSwiZXhwIjoxNTg5OTk0Nzg5fQ.kCL348zD7I0SOJKF4aMuiLO5--NvyskBMjKDYeGhpQQ"
        
        static let baseUrl = "https://gidirect.app/node/api/v1/"


        //        MARK: - General API
        
        static let sendCodeMessage = "auth/send/sms"
        static let getLogin = "auth/login"
        static let getRegistration = "auth/register"
        static let getItemList = "bootcamps"
        static let getEditUser = "users"
        static let createItem = "bootcamps"
        static let getCityList = "cities"
        static let getToFavourite = "favorites"
        static let getNotifications = "users/\(UserManager.getCurrentUser()!._id)/notifications"
        static let getMyBootcamps = "bootcamps/by/\(UserManager.getCurrentUser()!._id)"
    }
}
