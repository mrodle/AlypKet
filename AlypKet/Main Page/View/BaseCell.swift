//
//  BaseCell.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/5/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class BaseCell:UICollectionViewCell{
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Пакет с саркытом и с казы для детей братишки Серика"
        label.font = .getProximaNovaMediumFont(on: 14)
        label.numberOfLines = 2
        return label
    }()
    
    let priceLabel:UILabel = {
        let label = UILabel()
        label.text = "5,000тг"
        label.textColor = .black
        label.font = .getProximaNovaSemiboldFont(on: 16)
        return label
    }()
    
    let cityLabel:UILabel = {
        let label = UILabel()
        label.text = "Талдыкорган"
        label.textColor = #colorLiteral(red: 0.2, green: 0.247, blue: 0.322, alpha: 1)
        label.numberOfLines = 2
        label.font = .getProximaNovaMediumFont(on: 14)
        return label
    }()
    
    let timeLabel:UILabel = {
       let label = UILabel()
        label.text = "Cегодня в 00:15"
        label.textColor = #colorLiteral(red: 0.2, green: 0.247, blue: 0.322, alpha: 1)
        label.font = .getProximaNovaMediumFont(on: 14)
        return label
    }()
    
    let favouriteButton:UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.backgroundColor = #colorLiteral(red: 0.2, green: 0.2470588235, blue: 0.3215686275, alpha: 0.25)

        return button
    }()
    
    var favouriteBool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func saveToFavourite(){
        favouriteBool = !favouriteBool
        let image = favouriteBool ? #imageLiteral(resourceName: "yelStars") : #imageLiteral(resourceName: "star")
        favouriteButton.setImage(image, for: .normal)
    }
    
    func setupView(){
        
        favouriteButton.addTarget(self, action: #selector(saveToFavourite), for: .touchUpInside)
        
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(frame.width-30)
        }
        
        imageView.addSubview(favouriteButton)
        favouriteButton.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.top).offset(10)
            make.right.equalTo(imageView.snp.right).offset(-10)
            make.width.height.equalTo(32)
        }

        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
        }
        
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
        }

        addSubview(cityLabel)
        cityLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
        }
        
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cityLabel.snp.bottom).offset(2)
            make.left.right.equalToSuperview()
        }

//        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width-30)
//        nameLabel.frame = CGRect(x: 3, y: frame.width - 30 + 8, width: frame.width, height: 40)
//        priceLabel.frame = CGRect(x: 3, y: frame.width - 30 + 50, width: frame.width, height: 20)
//        cityLabel.frame = CGRect(x: 3, y: frame.width - 30 + 70, width: frame.width, height: 20)
//        timeLabel.frame = CGRect(x: 3, y: frame.width - 30 + 90, width: frame.width, height: 20)
        
    }

    func configuration(item: ItemModel) -> Void {
        nameLabel.text = item.title
        priceLabel.text = "\(item.price) тг"
        cityLabel.text = "\(item.fromLocation.name) - \(item.toLocation.name)"
        timeLabel.text = item.createdAt.dateConfiguration()
    }

    
}

