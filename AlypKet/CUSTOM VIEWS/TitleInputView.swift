//
//  TitleInputView.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 3/20/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

protocol TextFieldDelegate {
    func didBeginEditing(view: UIView) -> Void
    func didEndEditing(view: UIView, isError: Bool) -> Void
}

class TitleInputView: UIView {
    
    //MARK: - Properties
    let viewModel = SignInViewModel()
    
    var inputType: InputTypes
    var placeholder: String
    var delegate: TextFieldDelegate?
    var icon: UIImage?
    var inputViewType: InputViewTypes = .default {
        didSet {
            setupKeyboardType()
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .getProximaNovaRegularFont(on: 18)
        
        return label
    }()
    
    lazy var textField: InputView = {
        let textField = InputView(inputType: inputType, placeholder: placeholder, icon: icon)
        textField.backgroundColor = #colorLiteral(red: 233.0/255.0, green: 246.0/255.0, blue: 254.0/255.0, alpha: 1)
        textField.textField.delegate = self
        textField.phoneTextField.didEndEditing = {
            self.delegate?.didEndEditing(view: self.textField, isError: self.viewModel.setPhone(textField.phoneTextField.text!))
        }
        
        textField.phoneTextField.didBeginEditing = {
            self.delegate?.didBeginEditing(view: self.textField)
        }

        return textField
    }()
    
//    MARK: - Lifecycle
    
    init(title: String, inputType: InputTypes, placeholder: String, icon: UIImage? = nil) {
        self.inputType = inputType
        self.placeholder = placeholder
        self.icon = icon
        super.init(frame: .zero)
        titleLabel.text = title
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Setup function
    private func setupView() -> Void {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
        }
        
        addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(48)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
    
    private func setupKeyboardType() -> Void {
        if inputViewType == .iin {
            self.textField.textField.keyboardType = .decimalPad
        } else if inputViewType == .email {
            self.textField.textField.keyboardType = .emailAddress
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


extension TitleInputView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.didBeginEditing(view: self.textField)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.inputType == .secureText {
            delegate?.didEndEditing(view: self.textField, isError: viewModel.setPassword(textField.text!))
        } else if self.inputType == .plainText {
            if self.inputViewType == .iin {
                delegate?.didEndEditing(view: self.textField, isError: viewModel.setIinNumber(textField.text!))
            }else if self.inputViewType == .email {
                delegate?.didEndEditing(view: self.textField, isError: viewModel.setEmail(textField.text!))
            } else {
                delegate?.didEndEditing(view: self.textField, isError: viewModel.setUserInfo(textField.text!))
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if inputViewType == .iin {
            let text = textField.text!
            let spaceIndex = [3, 7, 11]

            if text.count == 15 && string != ""{
                return false
            }
            
            if spaceIndex.contains(textField.text!.count) && string != "" {
                textField.text!.append("-")
            }

        } else {
            return true
        }
        
        return true
    }

}
