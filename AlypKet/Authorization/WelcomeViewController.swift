//
//  WelcomeViewController.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 3/19/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
//    MARK: - Properties
    
    lazy var appTitleImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "AlypKet"))
        image.contentMode = .scaleAspectFit
        
        return image
    }()
       
    
    lazy var appSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Отправляй товар в любую точку мира через путешествинников"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .getProximaNovaRegularFont(on: 18)
        
        return label
    }()

    lazy var mainIconImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "x35"))
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    lazy var startButton = MainButton(title: "Начать сейчас")
    
    
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
    
//    MARK: - Llifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupAction()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
//    MARK: - Setup funcions
    private func setupViews() -> Void {
        view.addSubview(appTitleImage)
        appTitleImage.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.right.left.equalToSuperview()
            make.height.equalTo(34)
        }
        
        view.addSubview(appSubtitleLabel)
        appSubtitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.right.equalToSuperview()
            make.top.equalTo(appTitleImage.snp.bottom).offset(12)
            make.height.equalTo(44)
        }
        
        view.addSubview(confedentionButton)
        confedentionButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(-24)
            make.left.right.equalToSuperview()
        }
        
        view.addSubview(startButton)
        startButton.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(48)
            make.bottom.equalTo(confedentionButton.snp.top).offset(-32)
        }
        
        
        view.addSubview(mainIconImage)
        mainIconImage.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(startButton.snp.top).offset(-(44*812/AppConstants.screenHeight))
            make.top.equalTo(appSubtitleLabel.snp.bottom).offset(44*812/AppConstants.screenHeight)
        }

    }
    
    private func setupAction() -> Void {
        startButton.addTarget(self, action: #selector(toPhoneNumberPage), for: .touchUpInside)
    }
    
//    MARK: - Actions
    
    @objc func toPhoneNumberPage() -> Void {
        navigationController?.pushViewController(PhoneNumberVerificationViewController(), animated: true)
//        AppCenter.shared.startWithToken()
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
