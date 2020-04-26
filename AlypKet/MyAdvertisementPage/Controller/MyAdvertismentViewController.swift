//
//  MyAdvertismentViewController.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/19/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class MyAdvertismentViewController: LoaderBaseViewController {
    
    var itemList: [ItemModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var viewModel: AllItemViewModel = {
        let view = AllItemViewModel()
        view.delegate = self
        
        return view
    }()

    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Пусто"
        label.textColor = .lightGray
        label.font = .getProximaNovaMediumFont(on: 15)
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var navBarNotify = BackNavBarView(title: "Мои объявления")
    
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateList), for: .valueChanged)
        refresh.tintColor = .mainColor
        
        return refresh
    }()

    lazy var tableView = UITableView()
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
        setupActions()
        setupLoaderView()
        showLoader()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.updateList()
    }
//    MARK: - Setup functions
    
    private func setupTableView() -> Void {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.refreshControl = refreshControl
        tableView.register(MyAdViewCell.self, forCellReuseIdentifier: MyAdViewCell.cellIdentifier())
    }
    
    func setupViews() -> Void {
        view.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(navBarNotify.snp.bottom)
        }
        view.addSubview(navBarNotify)
        navBarNotify.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(AppConstants.navBarHeight+AppConstants.statusBarHeight)
        }
        view.addSubview(tableView)
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
    
     private func setupData(_ itemList: [ItemModel]) -> Void {
         var list = [ItemModel]()
         
         for item in itemList {
            if item.userModal._id == UserManager.getCurrentUser()!._id {
                 list.append(item)
             }
         }
         
        self.itemList = list
        emptyLabel.isHidden = !self.itemList.isEmpty
     }
    
    private func deleteItem(_ id: ItemModel) -> Void {
    }
    
//    MARK: - Objc functions
    @objc func updateList() -> Void {
        viewModel.getItemList()
    }

}

extension MyAdvertismentViewController: ProcessViewDelegate {
    func updateUI() {
        self.setupData(viewModel.itemList)
        self.refreshControl.endRefreshing()
    }
    
    func endRefreshing() {
        self.refreshControl.endRefreshing()
    }
    
    
}


extension  MyAdvertismentViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyAdViewCell.cellIdentifier(), for: indexPath) as! MyAdViewCell
        cell.configuration(item: itemList[indexPath.row])
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailMainPageController(id: itemList[indexPath.row]._id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "", handler: {a,b,c in
            ParseManager.shared.deleteRequest(url: AppConstants.API.createItem+"/\(self.itemList[indexPath.row]._id)", success: { (result: EmptyResponse) in
                self.itemList.remove(at: indexPath.row)
                self.tableView.reloadData()
            }) { (error) in
                if error == "The data couldn’t be read because it is missing." {
                    self.itemList.remove(at: indexPath.row)
                    self.tableView.reloadData()
                } else {
                    self.showErrorMessage(error)
                }
            }
        })

        
        deleteAction.image = #imageLiteral(resourceName: "ic_outline-delete-outline")
        deleteAction.title = "Удалить"
        deleteAction.backgroundColor = #colorLiteral(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
        return UISwipeActionsConfiguration(actions: [deleteAction])

    }
}

