//
//  MainTabBarController.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/4/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//


import UIKit

class TabBarViewController: UITabBarController {
    
    //    MARK: - Properties
    let addTabbarController = UIViewController().inNavigation()

    lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .mainColor
        button.setImage(#imageLiteral(resourceName: "🔹addIcon"), for: .normal)
        button.layer.cornerRadius = 30
        
        return button
    }()
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNav()
        setupAction()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true

    }
    
    //MARK: - setupviews
    func setupViews() -> Void {
        let mainController = MainPageViewController().inNavigation()
        mainController.tabBarItem = UITabBarItem.init(title: "Главная", image: #imageLiteral(resourceName: "search"), tag: 0)

        let favouriteController = FavouritePageViewController().inNavigation()
        favouriteController.tabBarItem = UITabBarItem.init(title: "Избранное", image: #imageLiteral(resourceName: "🔹 Icon Color-3"), tag: 1)

        addTabbarController.tabBarItem.image = nil
        
        let chatController = ChatListViewController().inNavigation()
        chatController.tabBarItem = UITabBarItem.init(title: "Сообщения", image: #imageLiteral(resourceName: "🔹 Icon Color-4"), tag: 2)

        
        let profileController = ProfileViewController().inNavigation()
        profileController.tabBarItem = UITabBarItem.init(title: "Профиль", image: #imageLiteral(resourceName: "🔹 Icon Color-5"), tag: 3)

        viewControllers = [mainController, favouriteController, addTabbarController, chatController, profileController]
    }
    
    func setupNav() -> Void {
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.384, green: 0.384, blue: 0.384, alpha: 1)
        
        self.tabBar.backgroundColor = .white
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = .mainColor
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(tabBar.snp.top)
            make.width.height.equalTo(60)
        }
    }
    
    func setupAction() -> Void {
        addButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    
//    MARK: - Tabbar delegate
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        if viewController == addTabbarController {
            return false
        }

        return true
    }
    
    //MARK: - actions
    @objc func buttonAction() -> Void {
        self.present(CreatePostViewController(), animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

