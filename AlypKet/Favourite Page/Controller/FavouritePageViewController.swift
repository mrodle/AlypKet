//
//  FavouritePageViewController.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/14/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit


class FavouritePageViewController: UIViewController {
    
    
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
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = .getProximaNovaMediumFont(on: 22)
        label.text = "Избранное"
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysTemplate)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        navigationItem.rightBarButtonItem = searchBarButtonItem
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)

    }
    
    @objc func handleSearch(){
        print("print")
    }
    
    @objc func handleCity(){
        settingsLauncher.showSettings()
    }
    
    func setupViews(){
        addSubview(collectionView)
        
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.bottom.equalToSuperview()
        }
    }
    
}

extension FavouritePageViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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

       let vc = DetailMainPageController(id: "")
        self.tabBarController!.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 14, bottom: 0, right: 14)
    }
    
}
