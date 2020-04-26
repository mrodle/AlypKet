//
//  SliderCollectionViewCell.swift
//  BidKab
//
//  Created by Eldor Makkambayev on 8/30/19.
//  Copyright © 2019 Nursultan Zhiyembay. All rights reserved.
//

import Foundation
import UIKit

class SliderCollectionViewCell: UICollectionViewCell {
    
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    private func setupViews() -> Void {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
