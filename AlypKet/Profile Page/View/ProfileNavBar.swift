//
//  ProfileNavBar.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/18/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ProfileNavBar: UIView {
    
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2470588235, green: 0.2, blue: 0.337254902, alpha: 1)
        label.font = .getProximaNovaMediumFont(on: 22)
        label.text = "Профиль"
        return label
    }()
    
    let navBarButton:UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "🔹Icon Color"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        navBarButton.addTarget(self, action: #selector(handleEditAction), for: .touchUpInside)

    }
    
    @objc func handleEditAction(_ sender: UIButton){
        print("111")
        //        let vc = ProfileEditingViewController()
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func setupViews() -> Void {
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.bottom.equalToSuperview().offset(-6)
        }
        
        self.addSubview(navBarButton)
        navBarButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-6)
            make.right.equalTo(-17)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
