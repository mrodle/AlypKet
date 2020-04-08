//
//  VerificationView.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 3/25/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class VerificationView: UIView {
    
    //    MARK: - Properties
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите СМС-код"
        label.font = .getProximaNovaSemiboldFont(on: 20)
        
        return label
    }()
    
    
    
    lazy var codeTextFields = CodeTextFieldView(phoneNumber: "")

    //    MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Setup function
    
    private func setupView() -> Void {
        self.layer.cornerRadius = 18
        self.backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        addSubview(codeTextFields)
        codeTextFields.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalTo(-40)
        }
        
        
    }
}

