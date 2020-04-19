//
//  CreatePostImageCollectionViewCell.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 4/20/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class CreatePostImageCollectionViewCell: UICollectionViewCell {
    
    //    MARK: - Properties
    var deleteTarget: (() -> ())?
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        
        return view
    }()

    lazy var upperView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.247, green: 0.2, blue: 0.337, alpha: 0.55)
        view.layer.cornerRadius = 10

        return view
    }()
    
    lazy var createUpperView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.773, green: 0.816, blue: 0.871, alpha: 0.4)
        view.layer.cornerRadius = 10

        return view
    }()
    
    lazy var createUpperImage: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "add_a_photo"))
    
        return view
    }()
    
    lazy var createButton = UIButton()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "close-2"), for: .normal)
        
        return button
    }()
    
    lazy var mainPhotoLabel: UILabel = {
        let label = UILabel()
        label.text = "Главное фото"
        label.textColor = .white
        label.font = .getProximaNovaRegularFont(on: 14)
        label.textAlignment = .center
        
        return label
    }()
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Setup functions
    
    private func setupView() -> Void {
        backgroundColor = .white
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        addSubview(upperView)
        upperView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        upperView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { (make) in
            make.right.equalTo(-6)
            make.top.equalTo(6)
            make.height.width.equalTo(20)
        }
        
        upperView.addSubview(mainPhotoLabel)
        mainPhotoLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-8)
        }
        
        addSubview(createUpperView)
        createUpperView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        createUpperView.addSubview(createUpperImage)
        createUpperImage.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(32)
        }
        
        createUpperView.addSubview(createButton)
        createButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupAction() -> Void {
        deleteButton.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
    }
    
    func setupPresent(_ indexPath: IndexPath, _ listCount: Int) -> Void {
        createUpperView.isHidden = indexPath.item != 0
        upperView.isHidden = indexPath.item == 0
        mainPhotoLabel.isHidden = indexPath.item != listCount
    }
    
    @objc func deleteAction() -> Void {
        deleteTarget?()
    }

}
