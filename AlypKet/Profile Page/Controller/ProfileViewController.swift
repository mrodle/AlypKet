//
//  ProfileViewController.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/18/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    let navBar:ProfileNavBar = {
        let view = ProfileNavBar()
        return view
    }()
    
    lazy var tableView = UITableView()

    
    let arrayTitle = ["Push-уведомления","Мои объявления","Уведомления","Условия использования","Выйти"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
    }
 
       
    private func setupTableView() -> Void {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileContentViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupViews() -> Void {
        view.addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(AppConstants.navBarHeight+AppConstants.statusBarHeight)
            
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.right.left.bottom.equalToSuperview()
        }
        
    }
    
}


extension ProfileViewController:UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileContentViewCell
        cell.selectionStyle = .none
        cell.label.text = arrayTitle[indexPath.row]
        cell.index = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ProfileHeaderView()
        addSubview(headerView)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 224
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1{
            let vc = ProfileEditingViewController()
            self.tabBarController!.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 0 {
//            let vc
            
        }
    }
    
}
