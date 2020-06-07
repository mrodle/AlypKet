//
//  ChatListTableViewCell.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 4/8/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {
    
//    MARK: - Properties
    
    var countOfMessage = 0 {
        didSet {
            self.countOfMessageLabel.text = "\(countOfMessage)"
            self.countOfMessageLabel.isHidden = countOfMessage == 0
        }
    }
    
    lazy var userImage: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "no_image")
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .getProximaNovaRegularFont(on: 14)
        label.textColor = #colorLiteral(red: 0.247, green: 0.2, blue: 0.337, alpha: 1)
        
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = .getProximaNovaMediumFont(on: 16)
        label.textColor = #colorLiteral(red: 0.247, green: 0.2, blue: 0.337, alpha: 1)

        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .getProximaNovaRegularFont(on: 14)
        label.textColor = #colorLiteral(red: 0.247, green: 0.2, blue: 0.337, alpha: 1)

        return label
    }()
    
    lazy var countOfMessageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .mainColor
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true    
        label.textAlignment = .center
        label.textColor = .white
        label.font = .getProximaNovaMediumFont(on: 12)
        
        return label
    }()
    
//    MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Setup function
    
    private func setupView() -> Void {
        selectionStyle = .none
        addSubview(userImage)
        userImage.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.greaterThanOrEqualTo(17)
            make.bottom.lessThanOrEqualTo(-17)
            make.height.width.equalTo(40)
            make.centerY.equalToSuperview()
        }
        
        addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userImage.snp.right).offset(10)
            make.bottom.equalTo(snp.centerY).offset(-2)
            make.width.lessThanOrEqualTo(180)
        }
        
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(usernameLabel)
            make.left.equalTo(usernameLabel.snp.right)
            make.right.equalTo(-52)
        }
        
        addSubview(countOfMessageLabel)
        countOfMessageLabel.snp.makeConstraints { (make) in
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
            make.right.equalTo(-16)
        }

        addSubview(messageLabel)
        messageLabel.snp.makeConstraints { (make) in
            make.left.equalTo(usernameLabel)
            make.right.equalTo(timeLabel)
            make.top.equalTo(usernameLabel.snp.bottom).offset(4)
        }
    }

    func configuration(message: MessageUser) -> Void {
        let userImageList: [UIImage] = [#imageLiteral(resourceName: "photo_2020-06-03 00.55.38"), #imageLiteral(resourceName: "photo_2020-06-03 00.55.46"), #imageLiteral(resourceName: "photo_2020-06-03 00.55.55"), #imageLiteral(resourceName: "photo_2020-06-03 00.55.59")]
        self.userImage.image = userImageList[message.id]
        self.usernameLabel.text = message.fromUserName
        self.messageLabel.text = message.message
        self.timeLabel.text = message.date
        self.countOfMessage = 0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
