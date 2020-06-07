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
    var messageList: [MessageUser] = [MessageUser(id: 0, fromUserName: "Assylkhan Turan", message: "сегодня же", date: "", thomb: "0"), MessageUser(id: 1, fromUserName: "Zhanibek Santai", message: "Вечером я сам вам напишу", date: "", thomb: "1"), MessageUser(id: 2, fromUserName: "Marzhan Nurdauletova", message: "Онда кешіріңіз, маған ертерек жеткізілуі қажет", date: "", thomb: "2"), MessageUser(id: 3, fromUserName: "Laura Askarbekova", message: "договороились", date: "", thomb: "3")]  {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var navBar: ProfileNavBar = {
        let view = ProfileNavBar(title: "Сообщения", buttonImage: #imageLiteral(resourceName: "search-1"))
        view.navBarButtonTarget = {

        }
        
        return view
    }()

    lazy var tableView = UITableView()
    let popUpLongPressView:PopUpLongPressView = {
       let popUpLongPressView = PopUpLongPressView()
        return popUpLongPressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(longPressGestureRecognizer:)))
        self.view.addGestureRecognizer(longPressRecognizer)
    }
    
    
    
    @objc func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint = longPressGestureRecognizer.location(in: self.view)
            if let index = self.tableView.indexPathForRow(at: touchPoint)  {
                popUpLongPressView.showSettings(index: index[1])
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        if MessageManager.getUserList().isEmpty {
            do { try? MessageManager.setUserList(messageList) }
        } else {
            self.messageList = MessageManager.getUserList()
            do { try? MessageManager.setUserList(messageList) }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if MessageManager.getUserList().isEmpty {
            do { try? MessageManager.setUserList(messageList) }
        } else {
            self.messageList = MessageManager.getUserList()
            do { try? MessageManager.setUserList(messageList) }
        }

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
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatListTableViewCell.cellIdentifier(), for: indexPath) as! ChatListTableViewCell
        cell.configuration(message: messageList[indexPath.row])
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SearchHeaderView.cellIdentifier()) as! SearchHeaderView
//        
//        return header
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tabBarController!.navigationController?.pushViewController(ChatController(user: messageList[indexPath.row]), animated: true)
    }
}
