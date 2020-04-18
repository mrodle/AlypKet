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

        static let baseUrl = "https://gidirect.app/node/api/v1/"


        //        MARK: - General API
        
        static let sendCodeMessage = "auth/send/sms"
        static let getLogin = "auth/login"
        static let getRegistration = "auth/register"
        static let getItemList = "bootcamps"

    }
}
