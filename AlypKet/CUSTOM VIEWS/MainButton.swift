//
//  MainButton.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 3/20/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit

class MainButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .getProximaNovaSemiboldFont(on: 18)
        self.setTitleColor(.white, for: .normal)
        self.tintColor = .white
        self.backgroundColor = .mainColor
        self.layer.cornerRadius = 10
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
