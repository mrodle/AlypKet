//
//  SuccessStatusViewController.swift
//  MyBuh.kz
//
//  Created by Eldor Makkambayev on 4/25/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class SuccessStatusViewController: UIViewController {
    
//    MARK: - Properties
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 26
        
        return view
    }()
    
    lazy var successIcon: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "check_circle_outline"))
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .getProximaNovaBoldFont(on: 20)
        label.textAlignment = .center
        label.text = "Объявление создано"
        
        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .getProximaNovaRegularFont(on: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Для редактирования объявления перейдите в ‘Мои объявления’"
        
        return label
    }()
    
    lazy var doneButton = MainButton(title: "Понятно")

//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRecognizer()
        // Do any additional setup after loading the view.
    }
    
//    MARK: - Setup function
    private func setupView() -> Void {
        
        doneButton.addTarget(self, action: #selector(doneAction(sender:)), for: .touchUpInside)
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        view.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.left.equalTo(32)
            make.right.equalTo(-32)
            make.center.equalToSuperview()
        }
        
        
        backView.addSubview(successIcon)
        successIcon.snp.makeConstraints { (make) in
            make.top.equalTo(30)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(80)
        }
        
        backView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(successIcon.snp.bottom).offset(16)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        backView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        backView.addSubview(doneButton)
        doneButton.snp.makeConstraints { (make) in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(32)
            make.left.right.equalTo(titleLabel)
            make.bottom.equalTo(-22)
            make.height.equalTo(50)
        }

    }
    
    func setupRecognizer() -> Void {
        let dissmisGesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.view.addGestureRecognizer(dissmisGesture)
        let notActionGesture = UITapGestureRecognizer(target: self, action:  #selector(self.notAction))
        self.backView.addGestureRecognizer(notActionGesture)

    }
    
//    MARK: - Objc functions
    @objc func checkAction(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func doneAction(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func notAction(sender: UITapGestureRecognizer) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
