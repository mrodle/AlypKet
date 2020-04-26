//
//  ProfileViewController.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/18/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateData), for: .valueChanged)
        refresh.tintColor = .mainColor
        
        return refresh
    }()

    lazy var navBar: ProfileNavBar = {
        let view = ProfileNavBar(title: "Профиль", buttonImage: #imageLiteral(resourceName: "🔹Icon Color"))
        view.navBarButtonTarget = {
            self.moveToNextController()
        }
        
        return view
    }()
    
    let headerView = ProfileHeaderView()

    lazy var tableView = UITableView()

    
    let arrayTitle = ["Push-уведомления","Мои объявления","Уведомления","Условия использования","Выйти"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
    }
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        setupData()
    }
        
    private func setupTableView() -> Void {
        tableView.refreshControl = refreshControl
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileContentViewCell.self, forCellReuseIdentifier: ProfileContentViewCell.cellIdentifier())
    }
    
    func setupViews() -> Void {
        view.addSubview(tableView)
        view.addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(AppConstants.statusBarHeight + AppConstants.navBarHeight)
        }
        
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.right.left.bottom.equalToSuperview()
        }
    }
    
    private func setupData() -> Void {
        if let user = UserManager.getCurrentUser() {
            self.headerView.nameLabel.text = user.name
            self.headerView.emailLabel.text = user.email
    
            if let url = user.photo {
                self.headerView.imageView.kf.setImage(with: url.serverUrlString.url)
            } else {
                self.headerView.imageView.image = #imageLiteral(resourceName: "no_image")
            }
        }
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func moveToNextController(){
        let vc = ProfileEditingViewController()
        self.tabBarController!.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func updateData() -> Void {
        setupData()
    }
}


extension ProfileViewController:UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileContentViewCell.cellIdentifier(), for: indexPath) as! ProfileContentViewCell
        cell.selectionStyle = .none
        cell.label.text = arrayTitle[indexPath.row]
        cell.index = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1{
            let vc = MyAdvertismentViewController()
            self.tabBarController!.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 2{
            let vc = NotificationViewController()
            self.tabBarController!.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
