//
//  BackNavBarView.swift
//  AidynNury
//
//  Created by Eldor Makkambayev on 2/3/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class BackNavBarView: UIView {

//    MARK: - Properties
    var rightButtonImage: UIImage?
    var rightButtonTitle: String?
    var rightButtonWidth: CGFloat
    
    var goBack: (() -> ())?
    var rightButtonTarget: (() -> ())?

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "arrow_back"), for: .normal)
        button.contentMode = .scaleAspectFit
        
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(rightButtonImage, for: .normal)
        button.setTitle(rightButtonTitle, for: .normal)
        button.setTitleColor(.mainColor, for: .normal)
        button.titleLabel?.font = .getProximaNovaRegularFont(on: 13)
        button.contentMode = .scaleAspectFit
        button.titleLabel?.textAlignment = .right
        
        return button
    }()

    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2, green: 0.2470588235, blue: 0.3215686275, alpha: 1)
        label.font = .getProximaNovaSemiboldFont(on: 18)
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.773, green: 0.816, blue: 0.871, alpha: 0.4)
        
        return view
    }()
//    MARK: - Initialization
    
    init(title: String = "", rightButtonImage: UIImage? = nil, rightButtonTitle: String? = nil, rightButtonWidth: CGFloat = 25) {
        self.rightButtonWidth = rightButtonWidth
        super.init(frame: .zero)
        self.rightButtonTitle = rightButtonTitle
        self.rightButtonImage = rightButtonImage
        self.titleLabel.text = title
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Setup function
    
    private func setupView() -> Void {
        self.backgroundColor = .white
        self.rightButton.isHidden = self.rightButtonImage == nil && self.rightButtonTitle == nil
        
        backButton.addTarget(self, action: #selector(goToBack), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
        
        addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.left.equalTo(24)
            make.centerY.equalTo(snp.bottom).offset(-22)
            make.height.width.equalTo(21)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo((25+rightButtonWidth))
            make.right.equalTo(-(25+rightButtonWidth))
            make.centerY.equalTo(backButton)
        }

        addSubview(rightButton)
        rightButton.snp.makeConstraints { (make) in
            make.right.equalTo(-24)
            make.centerY.equalTo(snp.bottom).offset(-22)
            make.height.equalTo(25)
            make.width.equalTo(rightButtonWidth)
        }
        
        addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }

    }
    
    @objc func goToBack() -> Void {
        self.goBack?()
    }
    
    @objc func rightButtonAction() -> Void {
        self.rightButtonTarget?()
    }
}
