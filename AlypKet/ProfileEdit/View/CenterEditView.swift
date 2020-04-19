//
//  CenterEditView.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/18/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//


import UIKit

class CenterEditView: UIView {
    
    lazy var firstNameInputView: TitleInputView = {
        let view = TitleInputView(title: "Имя", inputType: .plainText, placeholder: "Eldor")
        
        return view
    }()
    
    lazy var lastNameInputView: TitleInputView = {
        let view = TitleInputView(title: "Фамилия", inputType: .plainText, placeholder: "Makkambayev")
        
        return view
    }()
    
    lazy var iinInputView: TitleInputView = {
        let view = TitleInputView(title: "Ваш ИИН", inputType: .plainText, placeholder: "XXX-XXX-XXX-XXX")
        view.inputViewType = .iin
        
        return view
    }()
    
    lazy var emailInputView: TitleInputView = {
        let view = TitleInputView(title: "Электронная почта", inputType: .plainText, placeholder: "indushkin@gmail.com")
        view.inputViewType = .email

        return view
    }()
//    let nameInputView:UITextField = {
//        let tf = UITextField()
//        tf.placeholder = " Маржан"
//        tf.backgroundColor =  #colorLiteral(red: 233.0/255.0, green: 246.0/255.0, blue: 254.0/255.0, alpha: 1)
//        tf.layer.cornerRadius = 10
//        tf.layer.masksToBounds = true
//        return tf
//    }()
//
//    let nameTitleInputView: UILabel = {
//        let label = UILabel()
//        label.text = "Имя"
//        label.font = .getProximaNovaRegularFont(on: 18)
//        label.textColor = #colorLiteral(red: 0.2, green: 0.2470588235, blue: 0.3215686275, alpha: 1)
//        return label
//    }()
//
//    let surnameInputView:UITextField = {
//        let tf = UITextField()
//        tf.placeholder = " Нурдаулетова"
//        tf.layer.cornerRadius = 10
//        tf.layer.masksToBounds = true
//        tf.backgroundColor =  #colorLiteral(red: 233.0/255.0, green: 246.0/255.0, blue: 254.0/255.0, alpha: 1)
//        return tf
//    }()
//
//    let surnameTitleInputView:UILabel = {
//        let label = UILabel()
//        label.text = "Фамилия"
//        label.textColor = #colorLiteral(red: 0.2, green: 0.2470588235, blue: 0.3215686275, alpha: 1)
//        label.font = .getProximaNovaRegularFont(on: 18)
//        return label
//    }()
//
//
//    let yourINNInputView:UITextField = {
//        let tf = UITextField()
//        tf.placeholder = " 990425450809"
//        tf.layer.cornerRadius = 10
//        tf.layer.masksToBounds = true
//        tf.backgroundColor =  #colorLiteral(red: 233.0/255.0, green: 246.0/255.0, blue: 254.0/255.0, alpha: 1)
//        return tf
//    }()
//
//    let yourINNTitleInputView:UILabel = {
//        let label = UILabel()
//        label.text = "Ваш ИИН"
//        label.textColor = #colorLiteral(red: 0.2, green: 0.2470588235, blue: 0.3215686275, alpha: 1)
//        label.font = .getProximaNovaRegularFont(on: 18)
//        return label
//    }()
//
//    let emailInputView:UITextField = {
//        let tf = UITextField()
//        tf.placeholder = " unknown@gmail.com"
//        tf.layer.cornerRadius = 10
//        tf.layer.masksToBounds = true
//        tf.backgroundColor =  #colorLiteral(red: 233.0/255.0, green: 246.0/255.0, blue: 254.0/255.0, alpha: 1)
//        return tf
//    }()
//
//    let emailTitleInputView:UILabel = {
//        let label = UILabel()
//        label.text = "Электронная почта"
//        label.textColor = #colorLiteral(red: 0.2, green: 0.2470588235, blue: 0.3215686275, alpha: 1)
//        label.font = .getProximaNovaRegularFont(on: 18)
//        return label
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() -> Void {
        addSubview(firstNameInputView)
        firstNameInputView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.right.equalTo(snp.centerX).offset(-8)
        }
        
        addSubview(lastNameInputView)
        lastNameInputView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.right.equalTo(-16)
            make.left.equalTo(snp.centerX).offset(8)
        }
        
        addSubview(iinInputView)
        iinInputView.snp.makeConstraints { (make) in
            make.top.equalTo(firstNameInputView.snp.bottom).offset(24)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        
        addSubview(emailInputView)
        emailInputView.snp.makeConstraints { (make) in
            make.top.equalTo(iinInputView.snp.bottom).offset(24)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    
}
