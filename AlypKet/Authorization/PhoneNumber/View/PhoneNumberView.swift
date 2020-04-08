//
//  PhoneNumberView.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 3/25/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class PhoneNumberView: UIView {

//    MARK: - Properties
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Укажите номер телефона"
        label.font = .getProximaNovaSemiboldFont(on: 20)
        
        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "На номер будет отправлен\nСМС-код для подтверждения"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .getProximaNovaRegularFont(on: 16)
        
        return label
    }()

    lazy var phoneTextField = TitleInputView(title: "", inputType: .phone, placeholder: "")
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.numberOfLines = 0
        label.font = .getProximaNovaRegularFont(on: 14)
        
        return label
    }()

    
    lazy var getCodeButton = MainButton(title: "Получить код")
    
//    MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Setup function
    
    private func setupView() -> Void {
        self.layer.cornerRadius = 18
        self.backgroundColor = .white
        self.phoneTextField.delegate = self
        self.getCodeButton.alpha = 0.5
        self.getCodeButton.isUserInteractionEnabled = false
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { (make) in
            make.left.right.equalTo(subtitleLabel)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(8)
        }
        
        addSubview(errorLabel)
        errorLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(subtitleLabel)
            make.top.equalTo(phoneTextField.snp.bottom).offset(8)
        }
        
        addSubview(getCodeButton)
        getCodeButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(subtitleLabel)
            make.top.equalTo(errorLabel.snp.bottom).offset(16)
            make.bottom.equalTo(-40)
            make.height.equalTo(48)
        }
        
    }
}

extension PhoneNumberView: TextFieldDelegate {
    
    func didBeginEditing(view: UIView) {
        view.layer.borderColor = UIColor(red: 0.098, green: 0.569, blue: 0.922, alpha: 1).cgColor
        view.backgroundColor = #colorLiteral(red: 233.0/255.0, green: 246.0/255.0, blue: 254.0/255.0, alpha: 1)
        self.errorLabel.text = ""
    }
    
    func didEndEditing(view: UIView, isError: Bool) {
        
        view.layer.borderColor = isError ? UIColor.red.cgColor : UIColor.clear.cgColor
        view.backgroundColor = isError ? #colorLiteral(red: 255.0/255.0, green: 231.0/255.0, blue: 232.0/255.0, alpha: 1) : #colorLiteral(red: 233.0/255.0, green: 246.0/255.0, blue: 254.0/255.0, alpha: 1)
        
        self.errorLabel.text = isError ? self.phoneTextField.viewModel.errorMessage : ""
        self.getCodeButton.isUserInteractionEnabled = !isError
        self.getCodeButton.alpha = isError ? 0.5 : 1
    }
    
}
