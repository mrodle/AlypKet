//
//  BaseCell.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/5/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit
import Kingfisher
class BaseCell:UICollectionViewCell{
    
    var item: ItemModel?
    var favouriteBool = false
    var favouriteId: String = ""
    var favouriteTarget: (() -> ())?
    
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
    
    let favouriteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.backgroundColor = #colorLiteral(red: 0.2, green: 0.2470588235, blue: 0.3215686275, alpha: 0.25)

        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func saveToFavourite(){
        favouriteBool ? deleteFromFavourite() : getToFavourate()
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

        
    }

    func configuration(item: ItemModel) -> Void {
        self.item = item
        self.favouriteBool = item.inFavorite
        self.favouriteId = item.favoriteId
        let image = item.inFavorite ? #imageLiteral(resourceName: "yelStars") : #imageLiteral(resourceName: "star")
        self.favouriteButton.setImage(image, for: .normal)
        nameLabel.text = item.title
        priceLabel.text = "\(item.price) тг"
        cityLabel.text = "\(item.fromLocation.name) - \(item.toLocation.name)"
        timeLabel.text = item.createdAt.dateConfiguration()
        if let photoList = item.photo {
            if !photoList.isEmpty {
                if let image = photoList.first {
                    if image == "no-photo.jpg" {
                        imageView.image = item.price == 5000 ? #imageLiteral(resourceName: "IMAGE 2020-06-07 18:28:15") : #imageLiteral(resourceName: "no_image")
                    } else {
                        imageView.kf.setImage(with: image.serverUrlString.url)
                    }
                } else {
                    imageView.image = item.price == 5000 ? #imageLiteral(resourceName: "IMAGE 2020-06-07 18:28:15") : #imageLiteral(resourceName: "no_image")
                }
            }
        }
    }
    
    func getToFavourate() -> Void {
        ParseManager.shared.postRequest(url: AppConstants.API.getToFavourite, parameters: ["bootcampId": item!._id], success: { (result: FavouriteDataModel) in
            self.favouriteId = result.data!._id
            self.favouriteBool.toggle()
            self.favouriteButton.setImage(#imageLiteral(resourceName: "yelStars"), for: .normal)
        }) { (error) in
            
        }
    }
    
    func deleteFromFavourite() -> Void {
        ParseManager.shared.deleteRequest(url: AppConstants.API.getToFavourite+"/\(favouriteId)", success: { (result: DeleteFavouriteModel) in
            self.favouriteTarget?()
            self.favouriteBool.toggle()
            self.favouriteButton.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        }) { (error) in
            if error == "The data couldn’t be read because it is missing." {
                self.favouriteTarget?()
                self.favouriteBool.toggle()
                self.favouriteButton.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            }
        }
    }

    
}

