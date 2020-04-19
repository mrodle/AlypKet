//
//  ProfileHeaderView.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/18/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {
    
    let imageView:UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 55
        image.layer.masksToBounds = true
        image.image = #imageLiteral(resourceName: "Circle - S")
        image.layer.borderWidth = 4
        image.layer.borderColor = #colorLiteral(red: 0.6705882353, green: 0.8235294118, blue: 0.9529411765, alpha: 1)
        return image
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Маржан Нурдаулетова"
        label.font = .getProximaNovaMediumFont(on: 22)
        label.textColor = #colorLiteral(red: 0.2, green: 0.2470588235, blue: 0.3215686275, alpha: 1)
        return label
        
    }()
    
    let emailLabel:UILabel = {
        let label = UILabel()
        label.text = "unknown@gmail.com"
        label.font = .getProximaNovaRegularFont(on: 18)
        label.textColor = #colorLiteral(red: 0.2, green: 0.2470588235, blue: 0.3215686275, alpha: 0.4)
        return label
        
    }()
    
    let dividerLineView:UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.7725490196, green: 0.8156862745, blue: 0.8705882353, alpha: 0.4)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupViews()
    }
    
    
    
    func setupViews() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(16)
            make.size.equalTo(CGSize(width: 110, height: 110))
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        addSubview(emailLabel)
        emailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-24)
        }
        
        addSubview(dividerLineView)
        dividerLineView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


