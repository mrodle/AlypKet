//
//  CenterEditView.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/18/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//


import UIKit

class CenterEditView: UIView {
    
    let nameInputView:UITextField = {
        let tf = UITextField()
        tf.placeholder = " Маржан"
        tf.backgroundColor =  #colorLiteral(red: 233.0/255.0, green: 246.0/255.0, blue: 254.0/255.0, alpha: 1)
        tf.layer.cornerRadius = 10
        tf.layer.masksToBounds = true
        return tf
    }()
    
    let nameTitleInputView: UILabel = {
        let label = UILabel()
        label.text = "Имя"
        label.font = .getProximaNovaRegularFont(on: 18)
        label.textColor = #colorLiteral(red: 0.2, green: 0.2470588235, blue: 0.3215686275, alpha: 1)
        return label
    }()
    
    let surnameInputView:UITextField = {
        let tf = UITextField()
        tf.placeholder = " Нурдаулетова"
        tf.layer.cornerRadius = 10
        tf.layer.masksToBounds = true
        tf.backgroundColor =  #colorLiteral(red: 233.0/255.0, green: 246.0/255.0, blue: 254.0/255.0, alpha: 1)
        return tf
    }()
    
    let surnameTitleInputView:UILabel = {
        let label = UILabel()
        label.text = "Фамилия"
        label.textColor = #colorLiteral(red: 0.2, green: 0.2470588235, blue: 0.3215686275, alpha: 1)
        label.font = .getProximaNovaRegularFont(on: 18)
        return label
    }()
    
    
    let yourINNInputView:UITextField = {
        let tf = UITextField()
        tf.placeholder = " 990425450809"
        tf.layer.cornerRadius = 10
        tf.layer.masksToBounds = true
        tf.backgroundColor =  #colorLiteral(red: 233.0/255.0, green: 246.0/255.0, blue: 254.0/255.0, alpha: 1)
        return tf
    }()
    
    let yourINNTitleInputView:UILabel = {
        let label = UILabel()
        label.text = "Ваш ИИН"
        label.textColor = #colorLiteral(red: 0.2, green: 0.2470588235, blue: 0.3215686275, alpha: 1)
        label.font = .getProximaNovaRegularFont(on: 18)
        return label
    }()
    
    let emailInputView:UITextField = {
        let tf = UITextField()
        tf.placeholder = " unknown@gmail.com"
        tf.layer.cornerRadius = 10
        tf.layer.masksToBounds = true
        tf.backgroundColor =  #colorLiteral(red: 233.0/255.0, green: 246.0/255.0, blue: 254.0/255.0, alpha: 1)
        return tf
    }()
    
    let emailTitleInputView:UILabel = {
        let label = UILabel()
        label.text = "Электронная почта"
        label.textColor = #colorLiteral(red: 0.2, green: 0.2470588235, blue: 0.3215686275, alpha: 1)
        label.font = .getProximaNovaRegularFont(on: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() -> Void {
        addSubview(nameInputView)
        nameInputView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.height.equalTo(48)
        }
        
        addSubview(nameTitleInputView)
        nameTitleInputView.snp.makeConstraints { (make) in
            make.bottom.equalTo(nameInputView.snp.top).offset(-8)
            make.left.equalTo(nameInputView.snp.left)
        }
        
        addSubview(surnameInputView)
        surnameInputView.snp.makeConstraints { (make) in
            make.top.equalTo(nameInputView.snp.top)
            make.left.equalTo(nameInputView.snp.right).offset(8)
            make.right.equalTo(-16)
            make.width.height.equalTo(nameInputView)
        }
        
        addSubview(surnameTitleInputView)
        surnameTitleInputView.snp.makeConstraints { (make) in
            make.bottom.equalTo(surnameInputView.snp.top).offset(-8)
            make.left.equalTo(surnameInputView.snp.left)
        }
        
        addSubview(yourINNInputView)
        yourINNInputView.snp.makeConstraints { (make) in
            make.top.equalTo(surnameInputView.snp.bottom).offset(54)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(48)
        }
        
        addSubview(yourINNTitleInputView)
        yourINNTitleInputView.snp.makeConstraints { (make) in
            make.bottom.equalTo(yourINNInputView.snp.top).offset(-8)
            make.left.equalTo(yourINNInputView.snp.left)
        }
        
        addSubview(emailInputView)
        emailInputView.snp.makeConstraints { (make) in
            make.top.equalTo(yourINNInputView.snp.bottom).offset(54)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(48)
        }
        
        addSubview(emailTitleInputView)
        emailTitleInputView.snp.makeConstraints { (make) in
            make.bottom.equalTo(emailInputView.snp.top).offset(-8)
            make.left.equalTo(emailInputView.snp.left)
        }
     
    }
    
    
}
