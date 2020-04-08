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
//        self.bottomView.haventView.haventLabelButton.addTarget(self, action: #selector(toSignInPage), for: .touchUpInside)
    }
    
    //    MARK: - Actions
    
    @objc func toSignInPage() -> Void {
//        self.navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
