//
//  NotificationViewController.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/18/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    
    
    lazy var navBarNotify = BackNavBarView(title: "Уведомления")
    
    let titleArray = ["Ведутся технические работы, обещаем что к концу дня все будет решено","На этой неделе вашу заявку смотрели 3 человека"]
    
    lazy var tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
        setupActions()
    }
    
    
    private func setupTableView() -> Void {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(NotificationsViewCell.self, forCellReuseIdentifier: "notifyCell")
    }
    
    func setupViews() -> Void {
        addSubview(navBarNotify)
        navBarNotify.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(AppConstants.navBarHeight+AppConstants.statusBarHeight)
        }
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navBarNotify.snp.bottom)
            make.right.left.bottom.equalToSuperview()
        }
    }
    
    private func setupActions() -> Void {
        navBarNotify.goBack = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

extension  NotificationViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notifyCell", for: indexPath) as! NotificationsViewCell
        cell.selectionStyle = .none
        cell.notifyContentLabel.text = titleArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
}
