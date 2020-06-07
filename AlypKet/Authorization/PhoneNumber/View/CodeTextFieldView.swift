//
//  льсылсь.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 3/20/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class CodeTextFieldView: UIView {
    
    //MARK:- Preasire
    
    var endedTypeCode: (() -> ())?
    lazy var passhereLabel: UILabel = {
        let label = UILabel()
        label.text = "На указанный номер отправлен код \nВведите его сюда:"
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    lazy var firstInputTextField: UITextField = {
        let text = UITextField()
        text.layer.cornerRadius = 10
        text.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9882352941, alpha: 1)
        text.layer.borderWidth = 1.0
        text.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)
        text.keyboardType = UIKeyboardType.numberPad
        text.textAlignment = .center
        text.isSecureTextEntry = false
        text.tintColor = .mainColor
        text.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        text.delegate = self
        return text
    }()
    lazy var secondInputTextField: UITextField = {
        let text = UITextField()
        text.layer.cornerRadius = 10
        text.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9882352941, alpha: 1)
        text.isSecureTextEntry = false
        text.layer.borderWidth = 1.0
        text.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)
        text.keyboardType = UIKeyboardType.numberPad
        text.textAlignment = .center
        text.tintColor = .mainColor
        text.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        text.delegate = self
        return text
    }()
    lazy var thirdInputTextField: UITextField = {
        let text = UITextField()
        text.layer.cornerRadius = 10
        text.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9882352941, alpha: 1)
        text.layer.borderWidth = 1.0
        text.isSecureTextEntry = false
        text.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)
        text.keyboardType = UIKeyboardType.numberPad
        text.textAlignment = .center
        text.tintColor = .mainColor
        text.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        text.delegate = self
        return text
    }()
    lazy var fourthInputTextField: UITextField = {
        let text = UITextField()
        text.layer.cornerRadius = 10
        text.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9882352941, alpha: 1)
        text.layer.borderWidth = 1.0
        text.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)
        text.isSecureTextEntry = false
        text.keyboardType = UIKeyboardType.numberPad
        text.textAlignment = .center
        text.tintColor = .mainColor
        text.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        text.delegate = self
        return text
    }()
        
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.numberOfLines = 0
        label.font = .getProximaNovaRegularFont(on: 14)
        label.textAlignment = .center
        
        return label
    }()

    
    lazy var sendagainView = ResendCodeView()
    
    //MARK:- Lifecycle
    init(phoneNumber: String) {
        super.init(frame: .zero)
        passhereLabel.text = "На номер \(phoneNumber) был\nотправлен СМС-код "
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- SetupViews
    func setupViews() -> Void {
        addSubview(passhereLabel)
        addSubview(firstInputTextField)
        addSubview(secondInputTextField)
        addSubview(thirdInputTextField)
        addSubview(fourthInputTextField)
        addSubview(sendagainView)
        
        passhereLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        firstInputTextField.snp.makeConstraints { (make) in
            make.right.equalTo(secondInputTextField.snp.left).offset(-15)
            make.height.width.equalTo(50)
            make.top.equalTo(passhereLabel.snp.bottom).offset(11)
        }
        secondInputTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-35)
            make.height.width.equalTo(50)
            make.top.equalTo(passhereLabel.snp.bottom).offset(11)
        }
        thirdInputTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(35)
            make.height.width.equalTo(50)
            make.top.equalTo(passhereLabel.snp.bottom).offset(11)
        }
        fourthInputTextField.snp.makeConstraints { (make) in
            make.left.equalTo(thirdInputTextField.snp.right).offset(15)
            make.height.width.equalTo(50)
            make.top.equalTo(passhereLabel.snp.bottom).offset(11)
        }

        addSubview(errorLabel)
        errorLabel.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(fourthInputTextField.snp.bottom).offset(8)
        }

        sendagainView.snp.makeConstraints { (make) in
            make.top.equalTo(errorLabel.snp.bottom).offset(12)
            make.bottom.centerX.equalToSuperview()
        }
    }
    
    //MARK: - @objc function
    @objc func textFieldDidChange(textField: UITextField) {
        let text = textField.text
        if text?.count == 1 {
            switch textField {
            case firstInputTextField:
                secondInputTextField.becomeFirstResponder()
            case secondInputTextField:
                thirdInputTextField.becomeFirstResponder()
            case thirdInputTextField:
                fourthInputTextField.becomeFirstResponder()
            case fourthInputTextField:
                fourthInputTextField.resignFirstResponder()
                endedTypeCode?()
            default:
                break
            }
        }
        if text?.count == 0 {
            switch textField {
            case secondInputTextField:
                secondInputTextField.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.8941176471, blue: 0.9568627451, alpha: 1)
                firstInputTextField.becomeFirstResponder()
            case thirdInputTextField:
                thirdInputTextField.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.8941176471, blue: 0.9568627451, alpha: 1)
                secondInputTextField.becomeFirstResponder()
            case fourthInputTextField:
                fourthInputTextField.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.8941176471, blue: 0.9568627451, alpha: 1)
                thirdInputTextField.becomeFirstResponder()
            default:
                break
            }
        }
    }
    
    func isValid() -> Bool {
        guard !firstInputTextField.text!.isEmpty else {
            firstInputTextField.layer.borderColor = UIColor.red.cgColor
            firstInputTextField.backgroundColor = #colorLiteral(red: 255.0/255.0, green: 231.0/255.0, blue: 232.0/255.0, alpha: 1)
            return false }
        guard !secondInputTextField.text!.isEmpty else {
            secondInputTextField.layer.borderColor = UIColor.red.cgColor
            secondInputTextField.backgroundColor = #colorLiteral(red: 255.0/255.0, green: 231.0/255.0, blue: 232.0/255.0, alpha: 1)
            return false }
        guard !thirdInputTextField.text!.isEmpty else {
            thirdInputTextField.layer.borderColor = UIColor.red.cgColor
            thirdInputTextField.backgroundColor = #colorLiteral(red: 255.0/255.0, green: 231.0/255.0, blue: 232.0/255.0, alpha: 1)
            return false }
        guard !fourthInputTextField.text!.isEmpty else {
            fourthInputTextField.layer.borderColor = UIColor.red.cgColor
            fourthInputTextField.backgroundColor = #colorLiteral(red: 255.0/255.0, green: 231.0/255.0, blue: 232.0/255.0, alpha: 1)
            return false }

        return true
    }
    
    func isError() -> Void {
        firstInputTextField.layer.borderColor = UIColor.red.cgColor
        firstInputTextField.backgroundColor = #colorLiteral(red: 255.0/255.0, green: 231.0/255.0, blue: 232.0/255.0, alpha: 1)
        secondInputTextField.layer.borderColor = UIColor.red.cgColor
        secondInputTextField.backgroundColor = #colorLiteral(red: 255.0/255.0, green: 231.0/255.0, blue: 232.0/255.0, alpha: 1)
        thirdInputTextField.layer.borderColor = UIColor.red.cgColor
        thirdInputTextField.backgroundColor = #colorLiteral(red: 255.0/255.0, green: 231.0/255.0, blue: 232.0/255.0, alpha: 1)
        fourthInputTextField.layer.borderColor = UIColor.red.cgColor
        fourthInputTextField.backgroundColor = #colorLiteral(red: 255.0/255.0, green: 231.0/255.0, blue: 232.0/255.0, alpha: 1)
    }
    
    func isEmptyTyping() -> Void {
        errorLabel.text = ""
        
        firstInputTextField.text = ""
        secondInputTextField.text = ""
        thirdInputTextField.text = ""
        fourthInputTextField.text = ""
        
        firstInputTextField.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9882352941, alpha: 1)
        firstInputTextField.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)

        secondInputTextField.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9882352941, alpha: 1)
        secondInputTextField.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)

        
        thirdInputTextField.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9882352941, alpha: 1)
        thirdInputTextField.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)

        
        fourthInputTextField.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9882352941, alpha: 1)
        fourthInputTextField.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)

    }
}

extension CodeTextFieldView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.mainColor.cgColor
        textField.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9882352941, alpha: 1)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9882352941, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)
    }

    
}
