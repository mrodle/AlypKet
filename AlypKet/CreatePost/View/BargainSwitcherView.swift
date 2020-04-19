//
//  BargainSwitcherView.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 4/20/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class BargainSwitcherView: UIView {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Возможен торг"
        label.font = .getProximaNovaMediumFont(on: 18)
        
        return label
    }()
    
    lazy var switcher: UISwitch = {
        let view = UISwitch()
        
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() -> Void {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        addSubview(switcher)
        switcher.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
        }
    }
}
