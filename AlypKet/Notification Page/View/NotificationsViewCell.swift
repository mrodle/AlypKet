//
//  NotificationsViewCell.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/19/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class NotificationsViewCell: UITableViewCell {
    
    let cardView:UIView = {
        let view = UIView()
        return view
    }()
    
    let imageNotify:UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.image = #imageLiteral(resourceName: "Rectangle 275")
        image.layer.masksToBounds = true
        return image
    }()
    
    let notifyContentLabel:UILabel  = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .getProximaNovaMediumFont(on: 16)
        label.text = "На этой неделе вашу заявку смотрели 3 человека"
        label.textColor = #colorLiteral(red: 0.2470588235, green: 0.2, blue: 0.337254902, alpha: 1)
        return label
    }()
    
    let notifyDateLabel:UILabel  = {
        let label = UILabel()
        label.font = .getProximaNovaRegularFont(on: 14)
        label.text = "19 Октябрь, 2019 (19:30)"
        label.textColor = #colorLiteral(red: 0.2470588235, green: 0.2, blue: 0.337254902, alpha: 0.3955942623)
        return label
    }()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupViews()
        // Configure the view for the selected state
    }
    
    
    
    func setupViews() -> Void{
        addSubview(cardView)
        cardView.snp.makeConstraints { (make) in
            make.top.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(58)
        }
        cardView.addSubview(imageNotify)
        imageNotify.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        cardView.addSubview(notifyContentLabel)
        notifyContentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(6)
            make.left.equalTo(imageNotify.snp.right).offset(10)
            make.right.equalTo(-1)
            make.bottom.equalTo(-6)
        }
        addSubview(notifyDateLabel)
        notifyDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cardView.snp.bottom).offset(-2)
            make.left.equalTo(notifyContentLabel.snp.left)
        }
        
    }
    
}
