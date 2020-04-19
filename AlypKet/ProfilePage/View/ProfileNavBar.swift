//
//  ProfileNavBar.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/18/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ProfileNavBar: UIView {
    
    var navBarButtonTarget: (() -> ())?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2470588235, green: 0.2, blue: 0.337254902, alpha: 1)
        label.font = .getProximaNovaSemiboldFont(on: 26)
        
        return label
    }()
    
    let navBarButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    
    init(title: String, buttonImage: UIImage) {
        super.init(frame: .zero)
        titleLabel.text = title
        navBarButton.setImage(buttonImage, for: .normal)
        setupViews()
        navBarButton.addTarget(self, action: #selector(handleEditAction), for: .touchUpInside)

    }
    
    @objc func handleEditAction(_ sender: UIButton){
        navBarButtonTarget?()
    }
    
    
    func setupViews() -> Void {
        
        self.addSubview(navBarButton)
        navBarButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(-6)
            make.right.equalTo(-16)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }

        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(navBarButton)
            make.left.equalTo(16)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
