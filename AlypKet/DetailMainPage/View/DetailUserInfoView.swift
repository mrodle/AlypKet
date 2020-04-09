//
//  DetailUserInfoView.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/8/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//


import UIKit

class DetailUserInfoView: UIView {
    
    let imageView:UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Circle - S")
        return image
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Паленше Тугеншеев"
        label.textColor = #colorLiteral(red: 0.007843137255, green: 0.09803921569, blue: 0.1254901961, alpha: 1)
        label.font = .getProximaNovaMediumFont(on: 18)
        return label
    }()
    let statusLabel:UILabel = {
        let label = UILabel()
        label.text = "был(-а) в сети сегодня"
        label.font = .getProximaNovaMediumFont(on: 14)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.007843137255, blue: 0.1333333333, alpha: 0.3951331967)
        return label
    }()
    
    let dividerLineView:UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.3215686275, blue: 0.3411764706, alpha: 0.4012679303)
        return view
    }()
    
    
    let view:UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9568627451, blue: 0.9882352941, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        addSubview(view)
        
        view.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(100)
            make.bottom.equalTo(-24)
        }
        
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(16)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView).offset(10)
            make.left.equalTo(imageView.snp.right).offset(8)
            make.right.equalTo(-16)
        }
        
        view.addSubview(statusLabel)
        
        statusLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.equalTo(imageView.snp.right).offset(8)
            make.right.equalTo(-16)
            
        }
        
        addSubview(dividerLineView)
        
        dividerLineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

