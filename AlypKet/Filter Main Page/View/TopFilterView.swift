//
//  TopFilterView.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/16/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class TopFilterView: UIView {
    
    let sortTitle:UILabel = {
        let label = UILabel()
        label.font = .getProximaNovaMediumFont(on: 18)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.007843137255, green: 0.09803921569, blue: 0.1254901961, alpha: 0.3951460041)
        label.text = "Сортировка"
        return label
    }()
    
    
    
    let segmentControl:UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Цена","Дата"])
        segment.selectedSegmentIndex = 0
        if #available(iOS 13.0, *) {
            segment.selectedSegmentTintColor =  #colorLiteral(red: 0.2352941176, green: 0.568627451, blue: 0.8941176471, alpha: 1)
        }
        segment.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9568627451, blue: 0.9882352941, alpha: 1)
        let font = UIFont.getProximaNovaMediumFont(on: 18)
        segment.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        return segment
    }()
    
    let massTitle:UILabel = {
        let label = UILabel()
        label.font = .getProximaNovaMediumFont(on: 18)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.007843137255, green: 0.09803921569, blue: 0.1254901961, alpha: 0.3951460041)
        label.text = "Масса"
        return label
    }()
    
    lazy var massSlider:RangeSlider = {
        let slider = RangeSlider()
        let circleImage = ViewMaker.shared.makeCircleWith(size: CGSize(width: 14, height: 14),
                                                          backgroundColor: #colorLiteral(red: 0.9176470588, green: 0.9568627451, blue: 0.9882352941, alpha: 1))
        slider.maximumValue = 30
        slider.upperValue = 20
        slider.lowerValue = 5
        slider.trackHighlightTintColor =  #colorLiteral(red: 0.2352941176, green: 0.568627451, blue: 0.8941176471, alpha: 1)
        slider.addTarget(self, action: #selector(sliderAction(slider:)), for: .valueChanged)
        return slider
    }()
    
    let sliderText:UILabel = {
        let label = UILabel()
        label.font = .getProximaNovaMediumFont(on: 18)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.007843137255, green: 0.09803921569, blue: 0.1254901961, alpha: 1)
        label.text = "5 кг - 20 кг"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    @objc func sliderAction(slider:RangeSlider){
        sliderText.text = "\(Int(slider.lowerValue)) кг - \(Int(slider.upperValue)) кг"
    }
    
    func setupViews() -> Void{
        addSubview(sortTitle)
        sortTitle.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
        }
        addSubview(segmentControl)
        segmentControl.snp.makeConstraints { (make) in
            make.top.equalTo(sortTitle.snp.bottom).offset(16)
            make.height.equalTo(48)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        addSubview(massTitle)
        massTitle.snp.makeConstraints { (make) in
            make.top.equalTo(segmentControl.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        addSubview(massSlider)
        massSlider.snp.makeConstraints { (make) in
            make.top.equalTo(massTitle.snp.bottom).offset(16)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(35)
        }
        addSubview(sliderText)
        sliderText.snp.makeConstraints { (make) in
            make.top.equalTo(massSlider.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
