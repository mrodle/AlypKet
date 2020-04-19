//
//  AddImageSliderView.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 4/20/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class AddImageSliderView: UIView {

//    MARK: - Properties
    var createTarget: (() -> ())?
    var imageList = [UIImage]() {
        didSet {
            collectionView.isHidden = imageList.isEmpty
            createButton.isHidden = !imageList.isEmpty
            collectionView.reloadData()
        }
    }
    
    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        return layout
    }()

    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

    lazy var createButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add_a_photo"), for: .normal)
        button.setTitle("   Добавить фотографии", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2, green: 0.247, blue: 0.322, alpha: 0.4), for: .normal)
        button.titleLabel?.font = .getProximaNovaMediumFont(on: 18)
        button.layer.cornerRadius = 10
        button.backgroundColor = #colorLiteral(red: 0.773, green: 0.816, blue: 0.871, alpha: 0.4)
        
        return button
    }()
    
//MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Setup function
    
    private func setupView() -> Void {
        collectionView.isHidden = imageList.isEmpty
        createButton.isHidden = !imageList.isEmpty
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.height.equalTo(100)
            make.left.right.bottom.top.equalToSuperview()
        }
        
        addSubview(createButton)
        createButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        createButton.addTarget(self, action: #selector(createAction), for: .touchUpInside)
    }
    
    private func setupCollectionView() -> Void {
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CreatePostImageCollectionViewCell.self, forCellWithReuseIdentifier: CreatePostImageCollectionViewCell.cellIdentifier())
        
        self.collectionView.reloadData()
        self.collectionView.layoutIfNeeded()
    }
    
    @objc func createAction() -> Void {
        createTarget?()
    }
}

extension AddImageSliderView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreatePostImageCollectionViewCell.cellIdentifier(), for: indexPath) as! CreatePostImageCollectionViewCell
        cell.setupPresent(indexPath, imageList.count)
        
        if !imageList.isEmpty {
            cell.imageView.image = indexPath.item == 0 ? nil : imageList[indexPath.item - 1]
        }
        
        cell.createButton.addTarget(self, action: #selector(createAction), for: .touchUpInside)
        
        cell.deleteTarget = {
            self.imageList.remove(at: indexPath.item - 1)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 108, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    }

    
}

