//
//  HaventAccountView.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 3/20/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class HaventAccountView: UIView {
    
//    MARK: - Properties
    
    lazy var haventLabel: UILabel = {
        let label = UILabel()
//        label.text = "Нет аккаунта?"
        label.font = .getProximaNovaRegularFont(on: 18)
        label.textAlignment = .right
        
        return label
    }()
    
    lazy var haventLabelButton: UIButton = {
        let button = UIButton()
//        label.text = "Создать аккаунт"
        button.titleLabel!.font = .getProximaNovaSemiboldFont(on: 18)
        button.setTitleColor(.mainColor, for: .normal)
        button.titleLabel!.textAlignment = .left

        return button
    }()
    
//    MARK: - Lifecycle
    init(labelTitle: String, buttonTitle: String) {
        super.init(frame: .zero)
        self.haventLabel.text = labelTitle
        self.haventLabelButton.setTitle(buttonTitle, for: .normal)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    MARK: - Setup function
    
    private func setupView() -> Void {
        addSubview(haventLabel)
        haventLabel.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
        }
        
        let haventButtonLabelWidth = haventLabelButton.titleLabel!.text!.size(withAttributes:[.font: UIFont.getProximaNovaSemiboldFont(on: 18)]).width + 10

        addSubview(haventLabelButton)
        haventLabelButton.snp.makeConstraints { (make) in
            make.right.bottom.top.equalToSuperview()
            make.left.equalTo(haventLabel.snp.right).offset(3)
            make.width.equalTo(haventButtonLabelWidth)
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
