//
//  MyAdvertismentViewController.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/19/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class MyPostsViewController: LoaderBaseViewController {
    
    
    lazy var viewModel: MyPostViewModel = {
        let view = MyPostViewModel()
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
        tableView.register(MyPostTableViewCell.self, forCellReuseIdentifier: MyPostTableViewCell.cellIdentifier())
    }
    
    func setupViews() -> Void {
        view.backgroundColor = .white
        view.addSubview(navBarNotify)
        navBarNotify.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(AppConstants.navBarHeight+AppConstants.statusBarHeight)
        }
        view.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(navBarNotify.snp.bottom)
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
    
    
    private func deleteItem(_ indexPath: IndexPath) -> Void {
        self.showLoader()
        ParseManager.shared.deleteRequest(url: AppConstants.API.createItem+"/\(self.viewModel.myPostList[indexPath.row]._id)", success: { (result: EmptyResponse) in
            self.hideLoader()
            self.viewModel.myPostList.remove(at: indexPath.row)
            self.tableView.reloadData()
        }) { (error) in
            self.hideLoader()
            if error == "The data couldn’t be read because it is missing." {
                self.viewModel.myPostList.remove(at: indexPath.row)
                self.tableView.reloadData()
            } else {
                self.showErrorMessage(error)
            }
        }

    }
    
//    MARK: - Objc functions
    @objc func updateList() -> Void {
        viewModel.getMyPosts()
    }

}

extension MyPostsViewController: ProcessViewDelegate {
    func updateUI() {
        emptyLabel.isHidden = !viewModel.myPostList.isEmpty
        self.tableView.reloadData()
    }
    
    func endRefreshing() {
        self.refreshControl.endRefreshing()
    }
    
    
}

extension  MyPostsViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.myPostList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyPostTableViewCell.cellIdentifier(), for: indexPath) as! MyPostTableViewCell
        cell.configuration(item: viewModel.myPostList[indexPath.row])
        cell.moreButton.tag = indexPath.row
        cell.selectionStyle = .none
        
        cell.popUpView.selectClosure = { [weak self] index in
            guard let `self` = self else { return }
            if index == 0 {
                let vc = EditPostViewController(item: self.viewModel.myPostList[indexPath.row])
                vc.successBlock = {
                    self.updateList()
                }
                if #available(iOS 13.0, *) {
                    vc.isModalInPresentation = true
                } else {
                    // Fallback on earlier versions
                }

                self.present(vc, animated: true, completion: nil)
            } else {
                self.deleteItem(indexPath)
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailMainPageController(id: viewModel.myPostList[indexPath.row]._id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "", handler: {a,b,c in
            self.deleteItem(indexPath)
        })

        
        deleteAction.image = #imageLiteral(resourceName: "ic_outline-delete-outline")
        deleteAction.title = "Удалить"
        deleteAction.backgroundColor = #colorLiteral(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
        return UISwipeActionsConfiguration(actions: [deleteAction])

    }
}

