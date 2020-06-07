//
//  MessageCell.swift
//  GulMarket
//
//  Created by Yerassyl Zhassuzakhov on 6/3/19.
//  Copyright © 2019 Yerassyl Zhassuzakhov. All rights reserved.
//

import UIKit
import Kingfisher
class MessageCell: UICollectionViewCell {
//    MARK: - Properties
    
    lazy var messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.getProximaNovaMediumFont(on: 16)
        textView.backgroundColor = .clear
        textView.textColor = .black
        textView.isEditable = false
        textView.isSelectable = false
        textView.isUserInteractionEnabled = false
        textView.isExclusiveTouch = false
        
        return textView
    }()
    
    lazy var textBubbleView: UIView = {
        let tbv = UIView()
        tbv.backgroundColor = .mainColor
        tbv.layer.cornerRadius = 10
        tbv.layer.masksToBounds = true
        
        return tbv
    }()
    
    lazy var profileImageView: UIImageView = {
        let piv = UIImageView()
        piv.layer.cornerRadius = 20
        piv.layer.masksToBounds = true
        piv.image = #imageLiteral(resourceName: "no_image")
        piv.contentMode = .scaleAspectFill

        return piv
    }()
    
    lazy var selectionLayer: CALayer = {
        let sl = CALayer()
        sl.frame = contentView.frame
        
        return sl
    }()

//    MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Setup functions
    
    private func setupViews() {
        contentView.backgroundColor = .white
        addSubview(profileImageView)
        addSubview(textBubbleView)
        textBubbleView.addSubview(messageTextView)
        layer.addSublayer(selectionLayer)
        
        profileImageView.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.top.equalTo(16)
            make.height.width.equalTo(40)
        }

        textBubbleView.snp.makeConstraints { (make) in
            make.right.equalTo(profileImageView.snp.left).offset(-10)
            make.top.equalToSuperview()
            make.width.equalTo( 16 + 8 + 8)
            make.height.equalTo(20 + 20)
        }

        messageTextView.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.width.equalTo(16)
            make.center.equalToSuperview()
            make.bottom.equalTo(-20)
        }

    }
    
    func shouldSelectMessage(_ shouldSelect: Bool) {
        selectionLayer.backgroundColor = shouldSelect ? UIColor.blue.withAlphaComponent(0.4).cgColor : UIColor.clear.cgColor
    }
    
    func setCellLayoutAndData(message: String, owner: String, user: MessageUser) {
        var isOwner = Bool()
        if owner == "toUser" {
            isOwner = true
        } else {
            isOwner = false
        }
        messageTextView.text = message
        var estimatedFrame = message.estimatedFrame()
        estimatedFrame.size.width = estimatedFrame.width < 100 ? 100 : estimatedFrame.width
        if isOwner {
            let userImageList: [UIImage] = [#imageLiteral(resourceName: "photo_2020-06-03 00.55.38"), #imageLiteral(resourceName: "photo_2020-06-03 00.55.46"), #imageLiteral(resourceName: "photo_2020-06-03 00.55.55"), #imageLiteral(resourceName: "photo_2020-06-03 00.55.59")]
            profileImageView.image = userImageList[Int(user.thomb)!]
            textBubbleView.backgroundColor = #colorLiteral(red: 0.773, green: 0.816, blue: 0.871, alpha: 0.25)
            messageTextView.textColor = .black

            profileImageView.snp.remakeConstraints { (make) in
                make.left.top.equalTo(16)
                make.height.width.equalTo(40)
            }

            textBubbleView.snp.remakeConstraints { (make) in
                make.left.equalTo(66)
                make.top.equalToSuperview()
                make.width.equalTo(estimatedFrame.width + 16 + 8 + 8)
                make.height.equalTo(estimatedFrame.height + 20)
                make.bottom.equalTo(-20)
            }

            messageTextView.snp.remakeConstraints { (make) in
                make.height.equalTo(estimatedFrame.height + 20)
                make.width.equalTo(estimatedFrame.width + 16)
                make.center.equalToSuperview()
            }

        } else {
            textBubbleView.backgroundColor = .mainColor
            messageTextView.textColor = .white
            if let image = UserManager.getCurrentUser()?.photo {
                profileImageView.kf.setImage(with: image.serverUrlString.url)
            } else {
                
            }
            profileImageView.snp.remakeConstraints { (make) in
                make.right.equalTo(-16)
                make.top.equalTo(16)
                make.height.width.equalTo(40)
            }

            textBubbleView.snp.remakeConstraints { (make) in
                make.right.equalTo(profileImageView.snp.left).offset(-10)
                make.top.equalToSuperview()
                make.width.equalTo(estimatedFrame.width + 16 + 8 + 8)
                make.height.equalTo(estimatedFrame.height + 20)
                make.bottom.equalTo(-20)
            }

            messageTextView.snp.remakeConstraints { (make) in
                make.height.equalTo(estimatedFrame.height + 20)
                make.width.equalTo(estimatedFrame.width + 16)
                make.center.equalToSuperview()
            }

        }
    }
    
}

