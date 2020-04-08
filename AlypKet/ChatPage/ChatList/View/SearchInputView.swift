//
//  SearchInputView.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 4/8/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class SearchInputView: UIView {
    
//    MARK: - Properties

    lazy var searchIcon: UIButton = {
        let view = UIButton()
        view.setImage(#imageLiteral(resourceName: "search"), for: .normal)
        
        return view
    }()
    
    lazy var textField: UITextField = {
        let view = UITextField()
        view.placeholder = "Найти..."
        
        return view
    }()
    
    lazy var clearButton: UIButton = {
        let view = UIButton()
        view.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        view.isHidden = true
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Setup functions
    
    private func setupView() -> Void {
        layer.cornerRadius = 10
        backgroundColor = .backColor
        
        addSubview(searchIcon)
        searchIcon.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(24)
        }
        
        addSubview(clearButton)
        clearButton.snp.makeConstraints { (make) in
            make.right.equalTo(-12)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(24)
        }
        
        addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(searchIcon.snp.right).offset(12)
            make.right.equalTo(clearButton.snp.left).offset(-12)
            make.top.bottom.equalToSuperview()
            make.height.equalTo(48)
        }
    }
    
    private func setupAction() -> Void {
        clearButton.addTarget(self, action: #selector(clearAction), for: .touchUpInside)
    }
    
    @objc func clearAction() -> Void {
        textField.text = ""
    }
    
}
