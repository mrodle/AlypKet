//
//  SearchHeaderView.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 4/8/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class SearchHeaderView: UITableViewHeaderFooterView {

//    MARK: - Properties
    
    lazy var searchInputView: SearchInputView = {
        let view = SearchInputView()
        view.textField.delegate = self
        
        return view
    }()
    
    
//    MARK: - Initialization

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Setup function
    
    private func setupView() -> Void {
        tintColor = .white
        addSubview(searchInputView)
        searchInputView.snp.makeConstraints { (make) in
            make.top.equalTo(6)
            make.bottom.equalTo(-6)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
    }
}


extension SearchHeaderView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        searchInputView.clearButton.isHidden = textField.text!.isEmpty
        if !textField.text!.isEmpty {
            searchInputView.searchIcon.setImage(#imageLiteral(resourceName: "arrow_back-2"), for: .normal)
        } else {
            searchInputView.searchIcon.setImage(#imageLiteral(resourceName: "search"), for: .normal)
        }
    }
}
