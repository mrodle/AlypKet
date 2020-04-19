//
//  ProfileEditingViewController.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/18/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//


import UIKit

class ProfileEditingViewController: UIViewController {
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 55
        image.layer.masksToBounds = true
        image.image = #imageLiteral(resourceName: "Circle - S")
        image.layer.borderWidth = 4
        image.layer.borderColor = #colorLiteral(red: 0.6705882353, green: 0.8235294118, blue: 0.9529411765, alpha: 1)
        return image
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отменить", for: .normal)
        button.layer.borderColor = #colorLiteral(red: 0.2352941176, green: 0.568627451, blue: 0.8941176471, alpha: 1)
        button.layer.borderWidth = 3
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.setTitleColor(#colorLiteral(red: 0.2352941176, green: 0.568627451, blue: 0.8941176471, alpha: 1), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.568627451, blue: 0.8941176471, alpha: 1)
        return button
    }()
    
    private let dividerLineView:UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.7725490196, green: 0.8156862745, blue: 0.8705882353, alpha: 0.4)
        return view
    }()
    
    
    let centerEditView:CenterEditView = {
        let view = CenterEditView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        setupView()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func handleCancel(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func setupView()->Void{
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(55)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 110, height: 110))
        }
        
        self.view.addSubview(centerEditView)
        centerEditView.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(32)
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.60)
        }
        
        self.view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.height.equalTo(50)
            make.bottom.lessThanOrEqualTo(-28)
        }
        
        self.view.addSubview(saveButton)
        saveButton.snp.makeConstraints { (make) in
            make.top.equalTo(cancelButton.snp.top)
            make.left.equalTo(cancelButton.snp.right).offset(8)
            make.right.equalTo(-16)
            make.width.height.equalTo(cancelButton)
        }
        
        self.view.addSubview(dividerLineView)
        dividerLineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(cancelButton.snp.top).offset(-8)
            make.height.equalTo(1)
        }

    }
    
    
}
