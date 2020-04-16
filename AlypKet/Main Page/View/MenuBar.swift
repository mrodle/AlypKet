//
//  MenuBar.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/4/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit


class MenuBar: UIView ,UITextFieldDelegate{

    lazy var searchBar: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        textField.delegate = self
        textField.attributedPlaceholder =  NSAttributedString(string: "Найти...", attributes: [NSAttributedString.Key.font: UIFont.getProximaNovaRegularFont(on: 18)])
        textField.leftViewMode = .always
        textField.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
        
        let imageView = UIImageView(frame: CGRect(x: 5, y: 0, width: 20, height: 20))
        imageView.image = #imageLiteral(resourceName: "search")
        
        var viewLeft: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        viewLeft.addSubview(imageView)
        
        textField.leftView = viewLeft
        textField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textField.font = .getProximaNovaRegularFont(on: 18)
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        
        return textField
    }()
    
    
    let button: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.568627451, blue: 0.9215686275, alpha: 1)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(filterButton), for: .touchUpInside)
        return button
    }()
    
    
    var mainPageViewController:MainPageViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func filterButton(){
        mainPageViewController?.handleFilterAction()
    }
    
    func setupView(){
        addSubview(button)
        addSubview(searchBar)
        button.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12)
            make.height.equalToSuperview()
            make.width.equalTo(button.snp.height)
        }
        searchBar.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.right.equalTo(button.snp.left).offset(-8)
            make.height.equalToSuperview()
        }
    }
 
}
