//
//  MainPageViewController.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/4/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class MainPageViewController: LoaderBaseViewController {
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.mainPageViewController = self
        return mb
    }()
    
    lazy var viewModel: AllItemViewModel = {
        let view = AllItemViewModel()
        view.delegate = self
        
        return view
    }()
    
    let settingsLauncher = FilterLauncher()
    
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateList), for: .valueChanged)
        refresh.tintColor = .mainColor
        
        return refresh
    }()

        
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.refreshControl = refreshControl
        collectionView.register(BaseCell.self, forCellWithReuseIdentifier: BaseCell.cellIdentifier())
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarButtons()
        setupViews()
        setupLoaderView()
        showLoader()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isTranslucent = false
        updateList()
    }
    
    func setupViews(){
        view.addSubview(menuBar)
        menuBar.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        addSubview(collectionView)
        
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.menuBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }

    func setupNavBarButtons(){
        let searchImage = UIImage(named: "notification")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        let locationImage = UIImage(named: "location")?.withRenderingMode(.alwaysOriginal)
        let locationBarButtonItem = UIBarButtonItem(image: locationImage, style: .plain, target: self, action: nil)
        let locationTitleName = UIBarButtonItem(title: "Алматы", style: .plain, target: self, action: #selector(handleCity))
        navigationItem.rightBarButtonItems = [searchBarButtonItem]
        navigationItem.leftBarButtonItems = [locationBarButtonItem,locationTitleName]
    }
    
    func handleFilterAction(){
        let vc = UINavigationController(rootViewController: FilterViewController())
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

    @objc func handleSearch(){
        print("print")
    }
    
    @objc func handleCity(){
        settingsLauncher.showSettings()
    }
    
    @objc func updateList() -> Void {
        viewModel.getItemList()
    }
}

extension MainPageViewController: ProcessViewDelegate {
    func updateUI() {
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
}

extension MainPageViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseCell.cellIdentifier(), for: indexPath) as! BaseCell
        if viewModel.itemList.count > indexPath.row {
            cell.configuration(item: viewModel.itemList[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 24 , height: view.frame.width/2 + 57)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.itemList.count > indexPath.item {
            let vc = DetailMainPageController(id: viewModel.itemList[indexPath.item]._id)
            self.tabBarController!.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 14, bottom: 0, right: 14)
    }
    
}
