//
//  ProfileContentViewCell.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/18/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ProfileContentViewCell: UITableViewCell {
    
     let label:UILabel = {
        let label = UILabel()
        label.text = "adadada"
        label.font = .getProximaNovaMediumFont(on: 18)
        label.textColor = #colorLiteral(red: 0.2, green: 0.2470588235, blue: 0.3215686275, alpha: 1)
        return label
    }()
    
     let switchContent:UISwitch = {
       let sw = UISwitch()
        sw.isOn = false
        return sw
    }()
    
    let enterImage:UIImageView = {
       let image = UIImageView()
        image.image = #imageLiteral(resourceName: "🔹 Icon Color-6")
        return image
    }()
    
    let dividerLineView:UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.7725490196, green: 0.8156862745, blue: 0.8705882353, alpha: 0.4)
        return view
    }()
    
    var index:Int = 0 {
        didSet{
            if index == 0 {
                switchContent.isHidden = false
                enterImage.isHidden = true
            }else{
                switchContent.isHidden = true
                enterImage.isHidden = false
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupViews()
    }
    
    func setupViews() -> Void {
        self.backgroundColor = .white
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
        }
        
        addSubview(switchContent)
        switchContent.snp.makeConstraints { (make) in
//            make.top.equalTo(16)
            make.centerY.equalTo(label.snp.centerY)
            make.right.equalTo(-16)
            make.size.equalTo(CGSize(width: 40, height: 24))
        }
        
        addSubview(dividerLineView)
        dividerLineView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        addSubview(enterImage)
        enterImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-23)
            make.size.equalTo(CGSize(width: 10, height: 14))
        }
    }

}

