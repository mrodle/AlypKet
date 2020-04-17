//
//  PhoneNumberVerificationViewController.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 3/25/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class PhoneNumberVerificationViewController: LoaderBaseViewController {
    
    //    MARK: - Properties
    var code: String = ""
    var phone = Int()
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "🔹 Icon Color-2"), for: .normal)
        button.isHidden = true
        
        return button
    }()
    
    lazy var appTitleImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "AlypKet-4"))
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    
    lazy var appSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Отправляй товар в любую точку мира через путешествинников"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.alpha = 0.55
        label.font = .getProximaNovaRegularFont(on: 18)
        
        return label
    }()
    
    lazy var phoneNumberView = PhoneNumberView()
    lazy var verificationView = VerificationView()
    
    lazy var confedentionButton: UIButton = {
        let button = UIButton()
        let buttonAttributes : [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2, green: 0.247, blue: 0.322, alpha: 1),
                                                                NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]
        let attString = NSMutableAttributedString(string: "Политика конфиденциальности\n Условия пользовательского соглашения", attributes: buttonAttributes)
        
        button.setAttributedTitle(attString, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .getProximaNovaRegularFont(on: 14)
        
        
        return button
    }()
    
    
    //    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupAction()
        setupLoaderView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //    MARK: - Setup funcions
    private func setupViews() -> Void {
        view.backgroundColor = .mainColor
        verificationView.alpha = 0
        verificationView.isUserInteractionEnabled = false
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.top).offset(AppConstants.navBarHeight+8)
            make.left.equalTo(24)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        view.addSubview(phoneNumberView)
        phoneNumberView.snp.makeConstraints { (make) in
            make.center.equalToSuperview().offset(50)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        view.addSubview(verificationView)
        verificationView.snp.makeConstraints { (make) in
            make.center.equalToSuperview().offset(50)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        view.addSubview(appSubtitleLabel)
        appSubtitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.bottom.equalTo(phoneNumberView.snp.top).offset(-50)
            make.height.equalTo(44)
        }
        
        view.addSubview(appTitleImage)
        appTitleImage.snp.makeConstraints { (make) in
            make.bottom.equalTo(appSubtitleLabel.snp.top).offset(-10)
            make.right.left.equalToSuperview()
            make.height.equalTo(34)
        }
        
        view.addSubview(confedentionButton)
        confedentionButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(-24)
            make.left.right.equalToSuperview()
        }
        
        
    }
    
    private func setupAction() -> Void {
        phoneNumberView.getCodeButton.addTarget(self, action: #selector(getCodeAction), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backToPhoneNumber), for: .touchUpInside)
        
        verificationView.codeTextFields.endedTypeCode = {
            let codeView = self.verificationView.codeTextFields
            let typedCode = codeView.firstInputTextField.text! + codeView.secondInputTextField.text! + codeView.thirdInputTextField.text! + codeView.fourthInputTextField.text!
            if typedCode == self.code {
                self.getLogin()
            } else {
                codeView.isError()
                self.verificationView.codeTextFields.errorLabel.text = "Введенный код неправильный"
            }
        }
    }
    
    
    //    MARK: - Parse manager
    
    private func sendCodeMessage() -> Void {
        phone = Int(self.phoneNumberView.phoneTextField.viewModel.phone)!
        let params: Parameters = ["phone": phone]
        ParseManager.shared.postRequest(url: AppConstants.API.sendCodeMessage, parameters: params, success: { (result:
            SendMessageModel) in
            if let data = result.data {
                self.code = "\(String(describing: data.code!))"
            }
            self.verificationView.codeTextFields.passhereLabel.text = "На номер \(self.phoneNumberView.phoneTextField.textField.phoneTextField.text!) был\nотправлен СМС-код "
            self.showVerificationView()
            self.verificationView.codeTextFields.sendagainView.startSecondomer()
            
        }) { (error) in
            self.showErrorMessage(error)
        }
    }
    
    private func getLogin() -> Void {
        self.showLoader()
        self.verificationView.codeTextFields.errorLabel.text = ""
        let params: Parameters = ["phone": phone]
        ParseManager.shared.postRequest(url: AppConstants.API.getLogin, parameters: params, success: { (result: AuthModel) in
            self.hideLoader()
            do { try? UserManager.createSessionWithUser(result) }
            AppCenter.shared.startWithToken()
            
        }) { (error) in
//            self.showErrorMessage(error)

            if error == "Пользователь не найден!" {
                let vc = RegistrationViewController()
                vc.phone = self.phone
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.verificationView.codeTextFields.errorLabel.text = error
            }
        }
    }
    //    MARK: - Objc functions
    
    @objc func getCodeAction() -> Void {
        self.sendCodeMessage()
    }
    
    @objc func backToPhoneNumber() -> Void {
        hideVerificationView()
        self.verificationView.codeTextFields.isEmptyTyping()
        self.verificationView.codeTextFields.sendagainView.stopSecondomer()
    }
    
    //    MARK: - Simple functions
    
    private func showVerificationView() -> Void {
        UIView.animate(withDuration: 0.5, animations: {
            self.verificationView.alpha = 1
            self.phoneNumberView.snp.remakeConstraints { (make) in
                make.center.equalToSuperview().offset(50)
                make.width.equalTo(AppConstants.screenWidth - 32)
                make.right.equalTo(self.view.snp.left)
            }
            self.view.superview?.layoutIfNeeded()
            
            
        }) { (Bool) in
            self.verificationView.isUserInteractionEnabled = true
            self.backButton.isHidden = false
        }
    }
    
    func hideVerificationView() -> Void {
        UIView.animate(withDuration: 0.5, animations: {
            self.verificationView.alpha = 0
            self.phoneNumberView.snp.remakeConstraints { (make) in
                make.center.equalToSuperview().offset(50)
                make.left.equalTo(16)
                make.right.equalTo(-16)
            }
            self.view.superview?.layoutIfNeeded()
            
            
        }) { (Bool) in
            self.verificationView.isUserInteractionEnabled = false
            self.backButton.isHidden = true
        }
    }
    
    
}


