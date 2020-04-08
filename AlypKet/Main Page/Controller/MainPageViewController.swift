//
//  MainPageViewController.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/4/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    let settingsLauncher = FilterLauncher()
    
    let imageArray =  [#imageLiteral(resourceName: "Rectangle 274"), #imageLiteral(resourceName: "Rectangle 275"), #imageLiteral(resourceName: "Rectangle 275-2"), #imageLiteral(resourceName: "Rectangle 275-3")]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(BaseCell.self, forCellWithReuseIdentifier: BaseCell.cellIdentifier())
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        setupNavBarButtons()
        setupViews()
        
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
    
    @objc func handleSearch(){
        print("print")
    }
    
    @objc func handleCity(){
        settingsLauncher.showSettings()
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
    
}

extension MainPageViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseCell.cellIdentifier(), for: indexPath) as! BaseCell
        cell.imageView.image = imageArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 24 , height: view.frame.width/2 + 57)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

       let vc = DetailMainPageController()
        self.tabBarController!.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 14, bottom: 0, right: 14)
    }
    
}
