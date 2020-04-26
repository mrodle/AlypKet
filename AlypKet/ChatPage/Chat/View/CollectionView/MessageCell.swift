//
//  MessageCell.swift
//  GulMarket
//
//  Created by Yerassyl Zhassuzakhov on 6/3/19.
//  Copyright © 2019 Yerassyl Zhassuzakhov. All rights reserved.
//

import UIKit

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
    
    lazy var timeLabel: UILabel = {
        let tl = UILabel()
        tl.textAlignment = .left
        tl.textColor = #colorLiteral(red: 0.247, green: 0.2, blue: 0.337, alpha: 1)
        tl.text = "24 мин назад"
        tl.font = .getProximaNovaRegularFont(on: 14)
        
        return tl
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
        addSubview(timeLabel)
        addSubview(profileImageView)
        addSubview(textBubbleView)
        textBubbleView.addSubview(messageTextView)
        layer.addSublayer(selectionLayer)
    }
    
    func shouldSelectMessage(_ shouldSelect: Bool) {
        selectionLayer.backgroundColor = shouldSelect ? UIColor.blue.withAlphaComponent(0.4).cgColor : UIColor.clear.cgColor
    }
    
    func setCellLayoutAndData(message: String, owner: String) {
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
            textBubbleView.backgroundColor = #colorLiteral(red: 0.773, green: 0.816, blue: 0.871, alpha: 0.25)
            messageTextView.textColor = .black

            profileImageView.snp.makeConstraints { (make) in
                make.left.top.equalTo(16)
                make.height.width.equalTo(40)
            }

            textBubbleView.snp.makeConstraints { (make) in
                make.left.equalTo(66)
                make.top.equalToSuperview()
                make.width.equalTo(estimatedFrame.width + 16 + 8 + 8)
                make.height.equalTo(estimatedFrame.height + 20 + 20)
            }

            messageTextView.snp.makeConstraints { (make) in
                make.height.equalTo(estimatedFrame.height + 20)
                make.width.equalTo(estimatedFrame.width + 16)
                make.center.equalToSuperview()
            }

            timeLabel.snp.makeConstraints { (make) in
                make.left.equalTo(textBubbleView).offset(5)
                make.right.equalTo(textBubbleView)
                make.top.equalTo(textBubbleView.snp.bottom).offset(10)
                make.bottom.equalTo(-20)
            }

        } else {
            textBubbleView.backgroundColor = .mainColor
            messageTextView.textColor = .white

            profileImageView.snp.makeConstraints { (make) in
                make.right.equalTo(-16)
                make.top.equalTo(16)
                make.height.width.equalTo(40)
            }

            textBubbleView.snp.makeConstraints { (make) in
                make.right.equalTo(profileImageView.snp.left).offset(-10)
                make.top.equalToSuperview()
                make.width.equalTo(estimatedFrame.width + 16 + 8 + 8)
                make.height.equalTo(estimatedFrame.height + 20 + 20)
            }

            messageTextView.snp.makeConstraints { (make) in
                make.height.equalTo(estimatedFrame.height + 20)
                make.width.equalTo(estimatedFrame.width + 16)
                make.center.equalToSuperview()
            }

            timeLabel.snp.makeConstraints { (make) in
                make.left.equalTo(textBubbleView).offset(5)
                make.right.equalTo(textBubbleView)
                make.top.equalTo(textBubbleView.snp.bottom).offset(10)
                make.bottom.equalTo(-20)
            }

        }
    }
    
}

