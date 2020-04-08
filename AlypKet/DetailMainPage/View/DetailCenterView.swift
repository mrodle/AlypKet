//
//  DetailCenterView.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/8/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class DetailCenterView: UIView {
    
    let dateLabel:UILabel = {
        let label = UILabel()
        label.text = "2 апр 2020 г."
        label.font = .getProximaNovaMediumFont(on: 16)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.007843137255, blue: 0.1333333333, alpha: 0.4)
        return label
    }()
    
    let itemNameLabel:UILabel = {
        let label = UILabel()
        label.text = "Пакет с саркытом и с казы для детей братишки Серика"
        label.font = .getProximaNovaMediumFont(on: 22)
        label.numberOfLines = 2
        label.textColor = #colorLiteral(red: 0.007843137255, green: 0.09803921569, blue: 0.1254901961, alpha: 1)
        return label
    }()
    
    
    let priceLabel:UILabel = {
        let label = UILabel()
        label.text = "5 000тг."
        label.font = .getProximaNovaSemiboldFont(on: 26)
        label.numberOfLines = 2
        label.textColor = #colorLiteral(red: 0.007843137255, green: 0.09803921569, blue: 0.1254901961, alpha: 1)
        return label
    }()
    
    let weightLabel:UILabel = {
        let label = UILabel()
        label.text = "Вес: 3кг"
        label.font = .getProximaNovaMediumFont(on: 18)
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8980392157, blue: 0.9254901961, alpha: 1)
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.textColor = #colorLiteral(red: 0.007843137255, green: 0.09803921569, blue: 0.1254901961, alpha: 1)
        return label
    }()
    
    let locationLabel:UILabel = {
        let label = UILabel()
        label.text = "Доставить до: Талдыкорган"
        label.font = .getProximaNovaMediumFont(on: 18)
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8980392157, blue: 0.9254901961, alpha: 1)
        label.numberOfLines = 2
        label.textColor = #colorLiteral(red: 0.007843137255, green: 0.09803921569, blue: 0.1254901961, alpha: 1)
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        return label
    }()
    
    
    let dividerLineView:UIView = {
          let view = UIView()
           view.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.3215686275, blue: 0.3411764706, alpha: 0.4012679303)
           return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
    
    func setupViews(){
        addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(16)
            
        }
        
        addSubview(itemNameLabel)
        
        itemNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(dateLabel.snp.bottom).offset(16)
            make.right.equalTo(-16)
        }
        
        addSubview(priceLabel)
        
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(itemNameLabel.snp.bottom).offset(16)
            make.left.equalTo(16)
        }
        
        addSubview(dividerLineView)

        dividerLineView.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        addSubview(weightLabel)
        
        weightLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dividerLineView.snp.bottom).offset(16)
            make.left.equalTo(16)
            make.size.equalTo(CGSize(width: 99, height: 36))
        }
        
        addSubview(locationLabel)
        
        locationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(weightLabel.snp.bottom).offset(16)
            make.left.equalTo(16)
            make.size.equalTo(CGSize(width: 262, height: 36))
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
