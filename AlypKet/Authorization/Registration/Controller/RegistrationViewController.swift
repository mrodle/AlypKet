//
//  RegistrationViewController.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 3/25/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class RegistrationViewController: LoaderBaseViewController {
    
    //    MARK: - Properties
    var phone = Int()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .getProximaNovaBoldFont(on: 26)
        label.text = "Регистрация"
        
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .getProximaNovaRegularFont(on: 18)
        label.text = "Пройдите регистрацию чтобы вам были доступны наши сервисы"
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var bottomView = RegistrationBottomView()
    
    //    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
        // Do any additional setup after loading the view.
    }
    
    //    MARK: - Setup functions
    
    private func setupView() -> Void {
        view.backgroundColor = .mainColor
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(75)
            make.centerX.equalToSuperview()
        }
        
        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        contentView.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(40)
            make.left.right.equalTo(subtitleLabel)
            make.bottom.lessThanOrEqualTo(-48)
        }
        
    }
    
    
    private func setupAction() -> Void {
        self.bottomView.regButton.addTarget(self, action: #selector(getRegistrationAction), for: .touchUpInside)
//        self.bottomView.haventView.haventLabelButton.addTarget(self, action: #selector(toSignInPagex), for: .touchUpInside)
    }
    
    //    MARK: - Actions
    
    @objc func getRegistrationAction() -> Void {
        let params: Parameters = [
            "firstName": bottomView.firstNameTextField.textField.textField.text!,
            "lastName": bottomView.secondNameTextField.textField.textField.text!,
            "iin": Int(bottomView.iinTextField.viewModel.iin)!,
            "phone": phone,
            "email": bottomView.emailTextField.textField.textField.text!,
            "password": "\(phone)",
            "role": "user"
        ]
        
        ParseManager.shared.postRequest(url: AppConstants.API.getRegistration, parameters: params, success: { (result: AuthModel) in
            do { try? UserManager.createSessionWithUser(result) }
            AppCenter.shared.startWithToken()
        }) { (error) in
            self.showErrorMessage(error)
        }
    }
    
    
}
