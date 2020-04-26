//
//  CreatePostDescriptionInputView.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 4/20/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class CreatePostDescriptionInputView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .getProximaNovaRegularFont(on: 18)
        return label
    }()
    
    lazy var textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = #colorLiteral(red: 0.098, green: 0.569, blue: 0.922, alpha: 0.1)
        view.layer.cornerRadius = 10
        view.font = .getProximaNovaRegularFont(on: 18)
        
        return view
    }()
    
    //    MARK: - Lifecycle
    
    init(title: String = "Описание") {
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
        
        addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(150)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
    
    
}
