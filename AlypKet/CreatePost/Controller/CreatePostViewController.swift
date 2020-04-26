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
    var selectedtextFieldTag = -1
    var parameters: Parameters = [:]
    var photoParameters: Parameters = [:]

    var cityList: [City] = [] {
        didSet {
            fromLocationInputView.textField.pickerView.reloadAllComponents()
            toLocationInputView.textField.pickerView.reloadAllComponents()
        }
    }

    lazy var cityViewModel: CitiesViewModel = {
        let view = CitiesViewModel()
        view.delegate = self
        
        return view
    }()

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
    
    lazy var heighInputView = TitleInputView(title: "Вес товара", inputType: .plainText, placeholder: "Вес не должен превышать 30 кг")

    lazy var fromLocationInputView = TitleInputView(title: "Отправка от", inputType: .plainText, placeholder: "Алматинская область, Алматы", icon: #imageLiteral(resourceName: "Icon Color-6"))

    lazy var toLocationInputView = TitleInputView(title: "Доставить до", inputType: .plainText, placeholder: "Алматинская область, Алматы", icon: #imageLiteral(resourceName: "Icon Color-6"))

    lazy var descriptionInputView = CreatePostDescriptionInputView()

    lazy var createButton = MainButton(title: "Создать объявление")
    

//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDelegate()
        setupAction()
        setupLoaderView()
        cityViewModel.getItemList()
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
    
    private func setupDelegate() -> Void {
        heighInputView.textField.textField.keyboardType = .numberPad
        fromLocationInputView.textField.textField.tag = 0
        toLocationInputView.textField.textField.tag = 1
        
        fromLocationInputView.textField.textField.delegate = self
        toLocationInputView.textField.textField.delegate = self
        fromLocationInputView.textField.pickerView.delegate = self
        toLocationInputView.textField.pickerView.delegate = self
    }
    
    private func setupAction() -> Void {
        addImageSlider.createTarget = {
            self.openImagePicker()
        }
        
        createButton.addTarget(self, action: #selector(createPost), for: .touchUpInside)
    }
    
    
    
    //MARK: - Simple function
    
    private func isValidate() -> Bool {
        let inputViewList = [titleInputView.textField.textField, priceInputView.textField.textField, heighInputView.textField.textField, fromLocationInputView.textField.textField, toLocationInputView.textField.textField]
        
        for textField in inputViewList {
            guard !textField.text!.isEmpty else {
                self.showErrorMessage("Все поля должны быть заполнены!")
                return false
            }
        }
        
        guard !descriptionInputView.textView.text!.isEmpty else {
            self.showErrorMessage("Все поля должны быть заполнены!")
            return false
        }

        guard let mass = Int(heighInputView.textField.textField.text!), mass <= 30 else {
            self.showErrorMessage("Вес не должен превышать 30 кг")
            return false
        }
        
        guard descriptionInputView.textView.text.count <= 500 else {
            self.showErrorMessage("Описание не должен превышать 500 символов")
            return false
        }
        
        return true
    }
    
    private func setupParams() -> Void {
        parameters["title"] = titleInputView.textField.textField.text
        parameters["description"] = descriptionInputView.textView.text
        parameters["phone"] = "\(UserManager.getCurrentUser()!.phone)"
        parameters["price"] = Int(priceInputView.textField.textField.text!)
        parameters["mass"] = Int(heighInputView.textField.textField.text!)
        parameters["date"] = "1998-02-23"
        

        for photo in addImageSlider.imageList {
            photoParameters["file"] = photo
        }
    }
    
    private func uploadPhotos(id: String) -> Void {
        ParseManager.shared.putRequest(url: AppConstants.API.createItem + "/\(id)/photo", parameters: photoParameters, header: ["Content-Type": "multipart/form-data"], success: { (result: EmptyResponse) in
            self.hideLoader()
            self.dismiss(animated: true, completion: nil)
        }) { (error) in
            self.showErrorMessage(error)
        }

    }
    
    @objc func createPost() -> Void {
        guard isValidate() else { return }
        self.setupParams()
        self.showLoader()
        ParseManager.shared.postRequest(url: AppConstants.API.createItem, parameters: parameters, success: { (result: CreateItemModel) in
            if !self.photoParameters.isEmpty {
                self.uploadPhotos(id: result.data._id)
            } else {
                self.hideLoader()
                self.dismiss(animated: true, completion: nil)
            }
        }) { (error) in
            self.showErrorMessage(error)
        }
    }
    
    private func openImagePicker() -> Void {
        imagePicker.present(from: view)
    }
}


extension CreatePostViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return cityList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return cityList[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if selectedtextFieldTag == 0 {
            parameters["fromLocationId"] = cityList[row]._id!
            fromLocationInputView.textField.textField.text = cityList[row].name
        } else {
            parameters["toLocationId"] = cityList[row]._id!
            toLocationInputView.textField.textField.text = cityList[row].name
        }
    }
}
extension CreatePostViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.selectedtextFieldTag = textField.tag
    }
}


extension CreatePostViewController: ProcessViewDelegate {
    func updateUI() {
        self.cityList = cityViewModel.cityList
    }
    
    func endRefreshing() {
        
    }
    

}

extension CreatePostViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        addImageSlider.imageList.append(image!)
    }
}

