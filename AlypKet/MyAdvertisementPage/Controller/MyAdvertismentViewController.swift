//
//  MyAdvertismentViewController.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/19/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class MyAdvertismentViewController: UIViewController {
    
    lazy var navBarNotify = BackNavBarView(title: "Мои объявления")
    
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
        tableView.register(MyAdViewCell.self, forCellReuseIdentifier: "advertismentCell")
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

extension  MyAdvertismentViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "advertismentCell", for: indexPath) as! MyAdViewCell
        cell.popupButton.tag = indexPath.row
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    
    
}

