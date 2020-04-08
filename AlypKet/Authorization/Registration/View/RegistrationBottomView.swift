//
//  RegistrationBottomView.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 3/25/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class RegistrationBottomView: UIView {
    //    MARK: - Properties
    
    lazy var firstNameTextField = TitleInputView(title: "Имя", inputType: .plainText, placeholder: "Eldor")
    lazy var secondNameTextField = TitleInputView(title: "Фамилия", inputType: .plainText, placeholder: "Makkambayev")
    lazy var iinTextField = TitleInputView(title: "Введите ИИН", inputType: .plainText, placeholder: "XXX-XXX-XXX-XXX")
    lazy var emailTextField = TitleInputView(title: "Электронная почта", inputType: .plainText, placeholder: "indushkin@gmail.com")
    
    lazy var regButton = MainButton(title: "Зарегистрироваться")
    lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Пропустить", for: .normal)
        button.titleLabel?.font = .getProximaNovaSemiboldFont(on: 18)
        button.setTitleColor(.mainColor, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.mainColor.cgColor
        button.layer.borderWidth = 2
        
        return button
    }()
    
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.numberOfLines = 0
        label.font = .getProximaNovaRegularFont(on: 14)
        
        return label
    }()
    
    //    MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Setup functions
    
    private func setupView() -> Void {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        iinTextField.inputViewType = .iin
        emailTextField.inputViewType = .email
        
        getButtonActive(is: false)
        
        firstNameTextField.delegate = self
        secondNameTextField.delegate = self
        iinTextField.delegate = self
        emailTextField.delegate = self
        
        addSubview(firstNameTextField)
        firstNameTextField.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(40)
            make.right.equalTo(self.snp.centerX).offset(-5)
        }
        
        addSubview(secondNameTextField)
        secondNameTextField.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.top.equalTo(firstNameTextField.snp.top)
            make.left.equalTo(self.snp.centerX).offset(5)
        }
        
        addSubview(iinTextField)
        iinTextField.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.left.equalTo(16)
            make.top.equalTo(secondNameTextField.snp.bottom).offset(24)
        }
        addSubview(emailTextField)
        emailTextField.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.left.equalTo(16)
            make.top.equalTo(iinTextField.snp.bottom).offset(24)
        }
        
        
        addSubview(errorLabel)
        errorLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(emailTextField)
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
        }
        
        
        addSubview(regButton)
        regButton.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(errorLabel.snp.bottom).offset(16)
            make.height.equalTo(48)
        }
        
        addSubview(skipButton)
        skipButton.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(regButton.snp.bottom).offset(16)
            make.height.equalTo(48)
            make.bottom.equalTo(-40)
        }

    }
    
    private func setupAction() -> Void {
        showErrorMessage(from: firstNameTextField)
        showErrorMessage(from: secondNameTextField)
        showErrorMessage(from: iinTextField)
        showErrorMessage(from: emailTextField)

        regButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
    }
    
    //    MARK: - Simple functions
    
    private func showErrorMessage(from textField: TitleInputView) -> Void {
        textField.viewModel.showErrorBlock = {
            self.errorLabel.text = textField.viewModel.errorMessage
        }
    }
    
    private func getButtonActive(is bool: Bool) -> Void {
        regButton.alpha = bool ? 1 : 0.5
        regButton.isUserInteractionEnabled = bool
    }
    
    private func validate() -> Bool {
        guard firstNameTextField.textField.textField.text != "" else { return false}
        guard secondNameTextField.textField.textField.text != "" else { return false}
        guard iinTextField.textField.textField.text != "" else { return false}
        guard emailTextField.textField.textField.text != "" else { return false}

        return true
    }
    
    private func validateErrorMessage() -> Bool {
        let textFieldList = [firstNameTextField, secondNameTextField, iinTextField, emailTextField]
        for view in textFieldList {
            if view.viewModel.errorMessage != "" {
                self.errorLabel.text = view.viewModel.errorMessage
                return false
            }
        }
        
        return true
    }
    
    //    MARK: - Actions
    @objc func nextButtonAction() -> Void {
        
    }
}

extension RegistrationBottomView: TextFieldDelegate {
    
    func didBeginEditing(view: UIView) {
        view.layer.borderColor = UIColor(red: 0.098, green: 0.569, blue: 0.922, alpha: 1).cgColor
        view.backgroundColor = #colorLiteral(red: 233.0/255.0, green: 246.0/255.0, blue: 254.0/255.0, alpha: 1)
        self.errorLabel.text = ""
    }
    
    func didEndEditing(view: UIView, isError: Bool) {
        
        view.layer.borderColor = isError ? UIColor.red.cgColor : UIColor.clear.cgColor
        view.backgroundColor = isError ? #colorLiteral(red: 255.0/255.0, green: 231.0/255.0, blue: 232.0/255.0, alpha: 1) : #colorLiteral(red: 233.0/255.0, green: 246.0/255.0, blue: 254.0/255.0, alpha: 1)
        
        guard validate() && validateErrorMessage() else { getButtonActive(is: false); return }
        getButtonActive(is: true)

    }
    
}



