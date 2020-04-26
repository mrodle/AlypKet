//
//  MyAdViewCell.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/19/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class MyAdViewCell: UITableViewCell {
    
    var item: ItemModel?
    
    let cardView: UIView = {
        let view = UIView()
        return view
    }()
    
    let imageAd: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.image = #imageLiteral(resourceName: "Rectangle 275")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    let adContentLabel:UILabel  = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .getProximaNovaMediumFont(on: 16)
        label.text = "Корзина с белыми клубками для бабушки"
        label.textColor = #colorLiteral(red: 0.2470588235, green: 0.2, blue: 0.337254902, alpha: 1)
        
        return label
    }()
    
    let adPriceLabel:UILabel  = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .getProximaNovaSemiboldFont(on: 18)
        label.text = "2,000 тг"
        label.textColor = #colorLiteral(red: 0.2470588235, green: 0.2, blue: 0.337254902, alpha: 1)
        return label
    }()
    
    let adDateLabel:UILabel  = {
        let label = UILabel()
        label.font = .getProximaNovaRegularFont(on: 14)
        label.text = "От Сегодня в 12:14 до 18 мая"
        label.textColor = #colorLiteral(red: 0.2470588235, green: 0.2, blue: 0.337254902, alpha: 0.3955942623)
        return label
    }()
    
    
    let popUpView: PopUpLongPressView = {
         let popUpLongPressView = PopUpLongPressView()
        return popUpLongPressView
      }()
    
//    MARK:  - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Setup functions
    
    func setupViews() -> Void{
        addSubview(imageAd)
        imageAd.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.left.equalTo(16)
            make.size.equalTo(CGSize(width: 104, height: 96))
        }
        
        addSubview(cardView)
        cardView.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.right.equalTo(-16)
            make.left.equalTo(imageAd.snp.right).offset(16)
            make.bottom.equalTo(-12)
        }
                
        cardView.addSubview(adPriceLabel)
        adPriceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(4)
            make.right.equalTo(-24)
            make.left.equalToSuperview()
        }
        
        cardView.addSubview(adContentLabel)
        adContentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(adPriceLabel.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    
        cardView.addSubview(adDateLabel)
        adDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(adContentLabel.snp.bottom).offset(8)
            make.left.equalToSuperview()
        }
    }
    
    func configuration(item: ItemModel) -> Void {
        self.item = item
        adContentLabel.text = item.title
        adPriceLabel.text = "\(item.price) тг"
        adDateLabel.text = item.createdAt.dateConfiguration()
        if let photoList = item.photo {
            if !photoList.isEmpty {
                if let image = photoList.first {
                    if image == "no-photo.jpg" {
                        imageAd.image = #imageLiteral(resourceName: "no_image")
                    } else {
                        imageAd.kf.setImage(with: image.serverUrlString.url)
                    }
                } else {
                    imageAd.image = #imageLiteral(resourceName: "no_image")
                }
            }
        }
    }
//    MARK: - Onjc functions
    
    @objc func handlePopupView(sender: UIButton){
        popUpView.showSettings(index: sender.tag)
    }
    
}
