//
//  ChatListViewController.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 4/7/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ChatListViewController: UIViewController {
    
//    MARK: - Properties
    
    lazy var navBar: BackNavBarView = {
        let view = BackNavBarView(title: "Сообщения")
        view.backButton.isHidden = true
        
        return view
    }()
    
    lazy var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupView() -> Void {
        self.navigationController?.navigationBar.isHidden = true
        view.addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(AppConstants.navBarHeight+AppConstants.statusBarHeight)
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setupTableView() -> Void {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatListTableViewCell.self, forCellReuseIdentifier: ChatListTableViewCell.cellIdentifier())
        tableView.register(SearchHeaderView.self, forHeaderFooterViewReuseIdentifier: SearchHeaderView.cellIdentifier())

    }
    
}

extension ChatListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatListTableViewCell.cellIdentifier(), for: indexPath) as! ChatListTableViewCell
        cell.countOfMessage = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SearchHeaderView.cellIdentifier()) as! SearchHeaderView
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tabBarController!.navigationController?.pushViewController(ChatController(), animated: true)
    }
}
