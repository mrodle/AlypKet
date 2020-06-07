//
//  NotificationViewController.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/18/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class NotificationViewController: LoaderBaseViewController {
    
    
    lazy var navBarNotify = BackNavBarView(title: "Уведомления")
    
    let titleArray = ["Ведутся технические работы, обещаем что к концу дня все будет решено","На этой неделе вашу заявку смотрели 3 человека"]
    
    lazy var viewModel: NotificationViewModel = {
        let view = NotificationViewModel()
        view.delegate = self
        
        return view
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateList), for: .valueChanged)
        refresh.tintColor = .mainColor
        
        return refresh
    }()


    lazy var tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
        setupActions()
        setupLoaderView()
        self.showLoader()
        updateList()
    }
    
    
    private func setupTableView() -> Void {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.refreshControl = refreshControl
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
    
    @objc func updateList() -> Void {
        viewModel.getNotificationList()
    }
    
}

extension  NotificationViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notifyCell", for: indexPath) as! NotificationsViewCell
        cell.selectionStyle = .none
        cell.configuration(viewModel.notificationList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension NotificationViewController: ProcessViewDelegate {
    func updateUI() {
        self.tableView.reloadData()
    }
    
    func endRefreshing() {
        self.refreshControl.endRefreshing()
    }
    
    
}
