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
            make.bottom.equalToSuperview()
        }
    }
    
    
}
