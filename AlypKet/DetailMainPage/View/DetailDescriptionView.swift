//
//  DetailDescriptionView.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/8/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit


class DetailDescriptionView: UIView {
    let tittleLabel:UILabel = {
        let label = UILabel()
        label.text = "Описание"
        label.textColor = #colorLiteral(red: 0.007843137255, green: 0.09803921569, blue: 0.1254901961, alpha: 1)
        label.font = .getProximaNovaSemiboldFont(on: 20)
        return label
    }()
    
    let descriptionLabel:UILabel = {
        let label = UILabel()
        label.text = "Очень ценный товар просьба в целости и сохранности доставить голодным детям, студентам, моего брата, они сами оплатят заказ, казы очень свежий и для того что бы не испортилось нужно положить Очень ценный товар просьба в целости и сохранности доставить голодным детям, студентам, моего брата, они сами оплатят заказ, казы очень свежий и для того что бы не испортилось нужно положить"
        label.font = .getProximaNovaRegularFont(on: 18)
        label.numberOfLines = 4
        label.textColor = #colorLiteral(red: 0.007843137255, green: 0.09803921569, blue: 0.1254901961, alpha: 1)
        return label
    }()
    
    let showAllButotn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Показать всё", for: .normal)
        btn.titleLabel?.textAlignment = .right
        btn.setTitleColor(UIColor(red: 0.098, green: 0.569, blue: 0.922, alpha: 1), for: .normal)
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        addSubview(tittleLabel)
        
        tittleLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(16)
            make.height.equalTo(24)
        }
        
        addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tittleLabel.snp.bottom).offset(8)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        addSubview(showAllButotn)
        
        showAllButotn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 120, height: 24))
            make.right.equalTo(-16)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.bottom.equalTo(-32)
        }
    }
    
    private func setupAction() -> Void {
        showAllButotn.addTarget(self, action: #selector(showAllAction(sender:)), for: .touchUpInside)
    }
    
    @objc func showAllAction(sender: UIButton) -> Void {
        if sender.titleLabel?.text == "Показать всё" {
            descriptionLabel.numberOfLines = 0
            sender.setTitle("Скрыть", for: .normal)
        } else {
            sender.setTitle("Показать всё", for: .normal)
            descriptionLabel.numberOfLines = 4
        }
    }
}
