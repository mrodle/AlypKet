//
//  FavouritePageViewController.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/14/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit


class FavouritePageViewController: LoaderBaseViewController {
    
//    MARK: - Properties
    
    let settingsLauncher = FilterLauncher()
    var itemList: [ItemModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    lazy var viewModel: AllItemViewModel = {
        let view = AllItemViewModel()
        view.delegate = self
        
        return view
    }()

    
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateList), for: .valueChanged)
        refresh.tintColor = .mainColor
        
        return refresh
    }()

    lazy var emptyImage: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "Group 802"))
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(BaseCell.self, forCellWithReuseIdentifier: BaseCell.cellIdentifier())
        collectionView.refreshControl = refreshControl
        
        return collectionView
    }()
    
//    MARK: - Lifecycle
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
    
//    MARK: - Setup functions
    func setupViews(){
        view.addSubview(emptyImage)
        emptyImage.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func setupNavBarButtons(){
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = .getProximaNovaMediumFont(on: 22)
        label.text = "Избранное"
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysTemplate)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        navigationItem.rightBarButtonItem = searchBarButtonItem
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)

    }
    
    private func setupData(_ itemList: [ItemModel]) -> Void {
        var list = [ItemModel]()
        
        for item in itemList {
            if item.inFavorite {
                list.append(item)
            }
        }
        
        self.itemList = list
        self.emptyImage.isHidden = !self.itemList.isEmpty
    }
   
//    MARK: - ACTIONS
    
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

extension FavouritePageViewController: ProcessViewDelegate {
    func updateUI() {
        self.setupData(viewModel.itemList)
        self.refreshControl.endRefreshing()
    }
    
    func endRefreshing() {
        self.refreshControl.endRefreshing()
    }
    
    
}


extension FavouritePageViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseCell.cellIdentifier(), for: indexPath) as! BaseCell
        cell.configuration(item: itemList[indexPath.item])
        cell.favouriteTarget = {
            self.updateList()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 24 , height: view.frame.width/2 + 57)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

       let vc = DetailMainPageController(id: viewModel.itemList[indexPath.item]._id)
       self.tabBarController!.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 14, bottom: 0, right: 14)
    }
    
}
