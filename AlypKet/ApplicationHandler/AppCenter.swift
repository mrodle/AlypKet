//
//  AppCenter.swift
//  Santo
//
//  Created by Eldor Makkambayev on 9/24/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit

class AppCenter{
    
    //MARK: - Properties
    var window: UIWindow = UIWindow()
    static let shared = AppCenter()
    private var currentViewController: UIViewController = UIViewController()
    private var width = UIScreen.main.bounds.width
    
    
    //MARK: - Start functions
    func createWindow(_ window: UIWindow) -> Void {
        self.window = window
    }
    
    func start() -> Void {
        makeKeyAndVisible()
        makeRootController()
    }
       
    func startWithToken() -> Void {
        self.setRootController(TabBarViewController().inNavigation())
    }

    private func makeKeyAndVisible() -> Void {
        window.backgroundColor = .white
        window.makeKeyAndVisible()
    }
    
    func setRootController(_ controller: UIViewController) -> Void {
        currentViewController = controller
        window.rootViewController = currentViewController
    }
     
    func makeRootController() -> Void {
        let vc = WelcomeViewController().inNavigation()
        setRootController(vc)
    }
    
    //MARK: - functions
    func addSubview(view: UIView) -> Void {
        window.addSubview(view)
    }
    
}
