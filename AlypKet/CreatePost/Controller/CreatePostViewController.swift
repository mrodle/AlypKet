//
//  CreatePostViewController.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 4/20/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class CreatePostViewController: LoaderBaseViewController {
    
//    MARK: - Properties
    
    lazy var imagePicker: ImagePicker = {
        let imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        return imagePicker
    }()

    lazy var navBar: ProfileNavBar = {
        let view = ProfileNavBar(title: "Создать объявление", buttonImage: #imageLiteral(resourceName: "close-1"))
        view.navBarButtonTarget = {
            self.dismiss(animated: true, completion: nil)
        }
        
        return view
    }()
    
    lazy var addImageSlider = AddImageSliderView()
    
    lazy var titleInputView = TitleInputView(title: "Заголовок объявления", inputType: .plainText, placeholder: "Кошка людоед")
    
    lazy var priceInputView: TitleInputView = {
        let view = TitleInputView(title: "Цена", inputType: .plainText, placeholder: "2400 тг")
        view.textField.textField.keyboardType = .numberPad
        
        return view
    }()
    lazy var bargainSwitchView = BargainSwitcherView()
    
    lazy var heighInputView = TitleInputView(title: "Вес товара", inputType: .plainText, placeholder: "Вес не должен превышать 30 кг", icon: #imageLiteral(resourceName: "Icon Color-6"))

    lazy var fromLocationInputView = TitleInputView(title: "Отправка от", inputType: .plainText, placeholder: "Алматинская область, Алматы", icon: #imageLiteral(resourceName: "Icon Color-6"))

    lazy var toLocationInputView = TitleInputView(title: "Доставить до", inputType: .plainText, placeholder: "Алматинская область, Алматы", icon: #imageLiteral(resourceName: "Icon Color-6"))

    lazy var descriptionInputView = CreatePostDescriptionInputView()

    lazy var createButton = MainButton(title: "Создать объявление")
    

//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
        setupLoaderView()
        // Do any additional setup after loading the view.
    }
    
//    MARK: - Setup functions
    
    private func setupView() -> Void {
        view.backgroundColor = .white
        contentView.addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        contentView.addSubview(addImageSlider)
        addImageSlider.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(navBar.snp.bottom).offset(16)
            make.bottom.lessThanOrEqualToSuperview()
        }
        
        contentView.addSubview(titleInputView)
        titleInputView.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(addImageSlider.snp.bottom).offset(24)
            make.right.equalTo(-16)
        }
        
        contentView.addSubview(priceInputView)
        priceInputView.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleInputView)
            make.top.equalTo(titleInputView.snp.bottom).offset(24)
        }

        contentView.addSubview(bargainSwitchView)
        bargainSwitchView.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleInputView)
            make.top.equalTo(priceInputView.snp.bottom).offset(32)
        }

        contentView.addSubview(heighInputView)
        heighInputView.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleInputView)
            make.top.equalTo(bargainSwitchView.snp.bottom).offset(32)
        }

        contentView.addSubview(fromLocationInputView)
        fromLocationInputView.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleInputView)
            make.top.equalTo(heighInputView.snp.bottom).offset(24)
        }
        
        contentView.addSubview(toLocationInputView)
        toLocationInputView.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleInputView)
            make.top.equalTo(fromLocationInputView.snp.bottom).offset(24)
        }

        contentView.addSubview(descriptionInputView)
        descriptionInputView.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleInputView)
            make.top.equalTo(toLocationInputView.snp.bottom).offset(24)
        }

        contentView.addSubview(createButton)
        createButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleInputView)
            make.top.equalTo(descriptionInputView.snp.bottom).offset(24)
            make.height.equalTo(48)
            make.bottom.lessThanOrEqualTo(-32)
        }

    }
    
    private func setupAction() -> Void {
        addImageSlider.createTarget = {
            self.openImagePicker()
        }
    }
    
    //MARK: - Simple function
    
    private func openImagePicker() -> Void {
        imagePicker.present(from: view)
    }
}

extension CreatePostViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        addImageSlider.imageList.append(image!)
    }
}

