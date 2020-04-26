//
//  ProfileEditingViewController.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/18/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//


import UIKit

class ProfileEditingViewController: LoaderBaseViewController {
    
//    MARK: - Properties
    
    lazy var viewModel: EditProfileViewModel = {
        let viewModel = EditProfileViewModel()
        viewModel.delegate = self
        
        return viewModel
    }()
    
    lazy var imagePicker: ImagePicker = {
        let imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        return imagePicker
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 55
        image.layer.masksToBounds = true
        image.image = #imageLiteral(resourceName: "no_image")
        image.layer.borderWidth = 4
        image.layer.borderColor = #colorLiteral(red: 0.6705882353, green: 0.8235294118, blue: 0.9529411765, alpha: 1)
        image.contentMode = .scaleAspectFill

        return image
    }()
    
    let imagePickerButton = UIButton()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отменить", for: .normal)
        button.layer.borderColor = #colorLiteral(red: 0.2352941176, green: 0.568627451, blue: 0.8941176471, alpha: 1)
        button.layer.borderWidth = 3
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.setTitleColor(#colorLiteral(red: 0.2352941176, green: 0.568627451, blue: 0.8941176471, alpha: 1), for: .normal)
        button.backgroundColor = .clear
        
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.568627451, blue: 0.8941176471, alpha: 1)
        
        return button
    }()
    
    private let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.7725490196, green: 0.8156862745, blue: 0.8705882353, alpha: 0.4)
        
        return view
    }()
    
    
    let centerEditView: CenterEditView = {
        let view = CenterEditView()
        
        return view
    }()
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLoaderView()
        setupData()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
//    MARK: - Setup functions
    
    func setupView()->Void{
        
        view.backgroundColor = .white
        cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(getChangeAction), for: .touchUpInside)
        imagePickerButton.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(55)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(110)
        }
        view.addSubview(imagePickerButton)
        imagePickerButton.snp.makeConstraints { (make) in
            make.top.equalTo(55)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(110)
        }

        
        view.addSubview(centerEditView)
        centerEditView.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(32)
            make.left.right.equalToSuperview()
        }
        
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.height.equalTo(50)
            make.bottom.lessThanOrEqualTo(-28)
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { (make) in
            make.top.equalTo(cancelButton.snp.top)
            make.left.equalTo(cancelButton.snp.right).offset(8)
            make.right.equalTo(-16)
            make.width.height.equalTo(cancelButton)
        }
        
        view.addSubview(dividerLineView)
        dividerLineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(cancelButton.snp.top).offset(-8)
            make.height.equalTo(1)
        }
    }
    
    private func setupData() -> Void {
        if let user = UserManager.getCurrentUser() {
            self.centerEditView.firstNameInputView.textField.textField.text = user.firstName
            self.centerEditView.lastNameInputView.textField.textField.text = user.lastName
            self.centerEditView.emailInputView.textField.textField.text = user.email
            self.centerEditView.iinInputView.textField.textField.text = "\(String(describing: user.iin!))".getIinString()
    
            if let url = user.photo {
                self.imageView.kf.setImage(with: url.serverUrlString.url)
            } else {
                self.imageView.image = #imageLiteral(resourceName: "no_image")
            }
        }
    }
    
//    MARK: - Simple functions
    
    private func isValidate() -> Bool {
        guard !centerEditView.iinInputView.viewModel.setIinNumber(centerEditView.iinInputView.textField.textField.text!) else {
            self.showErrorMessage(centerEditView.iinInputView.viewModel.errorMessage)
            return false
        }
        
        guard !centerEditView.emailInputView.viewModel.setEmail(centerEditView.emailInputView.textField.textField.text!) else {
            self.showErrorMessage(centerEditView.emailInputView.viewModel.errorMessage)
            return false
        }

        guard !centerEditView.firstNameInputView.textField.textField.text!.isEmpty else {
            self.showErrorMessage("Введите имя!")
            return false
        }
        
        guard !centerEditView.lastNameInputView.textField.textField.text!.isEmpty else {
            self.showErrorMessage("Введите фамилию!")
            return false
        }

        return true
    }
    
//    MARK: - Objc functions
    @objc func openImagePicker() -> Void {
        print("GESTURE")
        imagePicker.present(from: view)
    }
    
    @objc func handleCancel(){
        self.navigationController?.popViewController(animated: true)
    }

    @objc func getChangeAction() -> Void {
        
        guard isValidate() else { return }

        let params: Parameters = [
            "name": centerEditView.firstNameInputView.textField.textField.text! + " " + centerEditView.lastNameInputView.textField.textField.text!,
            "firstName": centerEditView.firstNameInputView.textField.textField.text!,
            "lastName": centerEditView.lastNameInputView.textField.textField.text!,
            "iin": centerEditView.iinInputView.viewModel.iin,
            "email": centerEditView.emailInputView.textField.textField.text!
        ]
        
        var photoParams: Parameters = [:]
        if imageView.image != #imageLiteral(resourceName: "no_image") {
            photoParams["file"] = imageView.image?.jpegData(compressionQuality: 0.8)
        }
        viewModel.getEditInformation(photoParams: photoParams, params: params, id: UserManager.getCurrentUser()!._id)
    }
}

extension ProfileEditingViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        imageView.image = image
    }
}


extension ProfileEditingViewController: ProcessViewDelegate {
    func updateUI() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func endRefreshing() {
        
    }
    
    
}
