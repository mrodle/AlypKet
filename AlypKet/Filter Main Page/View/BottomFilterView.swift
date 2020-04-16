//
//  CenterFilterView.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/16/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class BottomFilterView: UIView {
    
    let fromTitle:UILabel = {
        let label = UILabel()
        label.font = .getProximaNovaMediumFont(on: 18)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.007843137255, green: 0.09803921569, blue: 0.1254901961, alpha: 0.3951460041)
        label.text = "Отправка от"
        return label
    }()
    
    let priceTitle:UILabel = {
        let label = UILabel()
        label.font = .getProximaNovaMediumFont(on: 18)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.007843137255, green: 0.09803921569, blue: 0.1254901961, alpha: 0.3951460041)
        label.text = "Диапозон цены"
        return label
    }()
    
    private lazy var pickerview:UIPickerView = {
        let pickerview = UIPickerView()
        pickerview.delegate = self
        return pickerview
    }()
    
    let toTitle:UILabel = {
        let label = UILabel()
        label.font = .getProximaNovaMediumFont(on: 18)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.007843137255, green: 0.09803921569, blue: 0.1254901961, alpha: 0.3951460041)
        label.text = "Доставить до"
        return label
    }()
    
    let fromTextField:UITextField = {
       let tf = UITextField()
        tf.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9568627451, blue: 0.9882352941, alpha: 1)
        tf.setLeftView(image: #imageLiteral(resourceName: "Icon Color-6"))
        tf.placeholder = " Алматинская область, Алматы"
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = 10
        return tf
    }()
    
    let toTextField:UITextField = {
       let tf = UITextField()
        tf.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9568627451, blue: 0.9882352941, alpha: 1)
        tf.layer.masksToBounds = true
        tf.setLeftView(image: #imageLiteral(resourceName: "Icon Color-6"))
        tf.placeholder = " Алматинская область, Алматы"
        tf.layer.cornerRadius = 10
        return tf
    }()
    let toolbar:UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        return toolbar
    }()
    
    
    let city =  ["Almaty","Astana","Aktau","Nur-Sultan"]
    lazy var massSlider:RangeSlider = {
        let slider = RangeSlider()
        let circleImage = ViewMaker.shared.makeCircleWith(size: CGSize(width: 14, height: 14),
                                                          backgroundColor: #colorLiteral(red: 0.9176470588, green: 0.9568627451, blue: 0.9882352941, alpha: 1))
        slider.maximumValue = 15000
        slider.upperValue = 12000
        slider.lowerValue = 600
        slider.trackHighlightTintColor =  #colorLiteral(red: 0.2352941176, green: 0.568627451, blue: 0.8941176471, alpha: 1)
        slider.addTarget(self, action: #selector(sliderAction(slider:)), for: .valueChanged)
        return slider
    }()
    
    let sliderText:UILabel = {
        let label = UILabel()
        label.font = .getProximaNovaMediumFont(on: 18)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.007843137255, green: 0.09803921569, blue: 0.1254901961, alpha: 1)
        label.text = "600тг - 12000тг"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        showDatePicker()
    }
    
    @objc func sliderAction(slider:RangeSlider){
        sliderText.text = "\(Int(slider.lowerValue))тг - \(Int(slider.upperValue))тг"
    }
    
    
    func showDatePicker(){
           //Formate Date
           //ToolBar
           let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(donePickerAction))
           let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
           let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelPickerAction))
           toolbar.setItems([doneButton,spaceButton,cancelButton], animated: true)
           fromTextField.inputAccessoryView = toolbar
           fromTextField.inputView = pickerview
           pickerview.delegate = self
    }
    
    @objc func donePickerAction(){
        print("f")
    }
    @objc func cancelPickerAction(){
        print("s")
    }
    func setupViews() -> Void{
        addSubview(fromTitle)
        fromTitle.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
        }
        addSubview(fromTextField)
        fromTextField.snp.makeConstraints { (make) in
            make.top.equalTo(fromTitle.snp.bottom).offset(16)
            make.height.equalTo(48)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        addSubview(toTitle)
        toTitle.snp.makeConstraints { (make) in
            make.top.equalTo(fromTextField.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(16)
        }
        addSubview(toTextField)
        toTextField.snp.makeConstraints { (make) in
            make.top.equalTo(toTitle.snp.bottom).offset(16)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(48)

        }

        addSubview(priceTitle)
        priceTitle.snp.makeConstraints { (make) in
            make.top.equalTo(toTextField.snp.bottom).offset(32)
            make.left.equalTo(16)
        }
        
        addSubview(massSlider)
        massSlider.snp.makeConstraints { (make) in
            make.top.equalTo(priceTitle.snp.bottom).offset(16)
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


extension BottomFilterView:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4

    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return city[row]
        
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }

}



extension UITextField {
  func setLeftView(image: UIImage) {
    let iconView = UIImageView(frame: CGRect(x: 10, y: 20, width: 14, height: 8)) // set your Own size
    iconView.image = image
    let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
    iconContainerView.addSubview(iconView)
    rightView = iconContainerView
    rightViewMode = .always
    self.tintColor = .lightGray
  }
}
