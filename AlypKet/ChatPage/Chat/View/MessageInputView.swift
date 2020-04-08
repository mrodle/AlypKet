//
//  MessageInputView.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 4/7/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class MessageInputView: UIView {
    
//    MARK: - Properties
    
    lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.773, green: 0.816, blue: 0.871, alpha: 1)
        
        return view
    }()

    lazy var roundedView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.layer.borderColor = #colorLiteral(red: 0.773, green: 0.816, blue: 0.871, alpha: 1)
        view.layer.borderWidth = 1
        
        return view
    }()
    
    lazy var addPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "photo_camera"), for: .normal)
        
        return button
    }()
    
    lazy var attachButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "attach_file"), for: .normal)
        
        return button
    }()
    
    lazy var locationOrSendButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "place"), for: .normal)
        
        return button
    }()

    lazy var textView: UITextField = {
        let view = UITextField()
        view.placeholder = "Введите текст"
        view.delegate = self

        return view
    }()
    

//    MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    MARK: - SETUP FUNCTIONS
    
    private func setupView() -> Void {
        addSubview(underlineView)
        underlineView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(1)
        }
        
        addSubview(roundedView)
        roundedView.snp.makeConstraints { (make) in
            make.height.equalTo(48)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalTo(-24)
            make.top.equalTo(underlineView.snp.bottom).offset(12)
        }
        
        roundedView.addSubview(addPhotoButton)
        addPhotoButton.snp.makeConstraints { (make) in
            make.left.equalTo(24)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        roundedView.addSubview(locationOrSendButton)
        locationOrSendButton.snp.makeConstraints { (make) in
            make.right.equalTo(-24)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        roundedView.addSubview(attachButton)
        attachButton.snp.makeConstraints { (make) in
            make.right.equalTo(locationOrSendButton.snp.left).offset(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }

        roundedView.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(addPhotoButton.snp.right).offset(10)
            make.height.equalToSuperview()
            make.right.equalTo(locationOrSendButton.snp.left).offset(-10)
        }

    }
}

extension MessageInputView: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if !textField.text!.isEmpty {
            attachButton.isHidden = true
            locationOrSendButton.setImage(#imageLiteral(resourceName: "send"), for: .normal)

        } else {
            attachButton.isHidden = false
            locationOrSendButton.setImage(#imageLiteral(resourceName: "place"), for: .normal)

        }

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text!.isEmpty {
            attachButton.isHidden = false
            locationOrSendButton.setImage(#imageLiteral(resourceName: "place"), for: .normal)

        }
    }
}
