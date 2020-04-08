//
//  DetailView.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/8/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class DetailMainPageController: LoaderBaseViewController {
    
//      MARK: - Properties
    lazy var navBar: BackNavBarView = {
        let view = BackNavBarView(title: "", rightButtonImage: #imageLiteral(resourceName: "star"))
        view.backButton.setImage(#imageLiteral(resourceName: "arrow_back-1"), for: .normal)
        view.goBack = {
            self.navigationController?.popViewController(animated: true)
        }
        
        return view
    }()
    
    let sliderImageView: SliderImageView = {
        let view = SliderImageView()
        return view
    }()
    
    let detailCenterView: DetailCenterView = {
        let view = DetailCenterView()
        return view
    }()
    
    let detailDescriptionView: DetailDescriptionView = {
        let view = DetailDescriptionView()
        return view
    }()
    
    let detailUserInfoView: DetailUserInfoView = {
        let view = DetailUserInfoView()
        return view
    }()
        
    
    let writeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Написать", for: .normal)
        button.layer.borderColor = #colorLiteral(red: 0.2352941176, green: 0.568627451, blue: 0.8941176471, alpha: 1)
        button.layer.borderWidth = 3
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.setTitleColor(#colorLiteral(red: 0.2352941176, green: 0.568627451, blue: 0.8941176471, alpha: 1), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    let callButton: UIButton = {
        let button = UIButton()
        button.setTitle("Позвонить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.568627451, blue: 0.8941176471, alpha: 1)
        return button
    }()
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
        
//    MARK: - Setup function
    
    private func setupView() -> Void{
        view.backgroundColor = .white
        scrollView.delegate = self
        
        view.addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(AppConstants.navBarHeight+AppConstants.statusBarHeight)
        }
        
        contentView.addSubview(sliderImageView)
        sliderImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(270)
        }
        
                
        contentView.addSubview(detailCenterView)
        
        detailCenterView.snp.makeConstraints { (make) in
            make.top.equalTo(sliderImageView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(270)
        }
        
        contentView.addSubview(detailDescriptionView)
        
        
        detailDescriptionView.snp.makeConstraints { (make) in
            make.top.equalTo(detailCenterView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        contentView.addSubview(detailUserInfoView)
        
        detailUserInfoView.snp.makeConstraints { (make) in
            make.top.equalTo(detailDescriptionView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(120)
        }
        
        
        contentView.addSubview(writeButton)
        
        writeButton.snp.makeConstraints { (make) in
            make.top.equalTo(detailUserInfoView.snp.bottom).offset(12)
            make.left.equalTo(16)
            make.height.equalTo(50)
            make.bottom.lessThanOrEqualTo(-10)
        }
        
        contentView.addSubview(callButton)
        
        callButton.snp.makeConstraints { (make) in
            make.top.equalTo(writeButton.snp.top)
            make.left.equalTo(writeButton.snp.right).offset(8)
            make.right.equalTo(-16)
            make.height.equalTo(writeButton.snp.height)
            make.width.equalTo(writeButton.snp.width)
        }
    }
    
    private func setupAction() -> Void {
        sliderImageView.presentBlock = { [weak self]  controller in
            guard let `self` = self else { return }
            self.present(controller, animated: true, completion: nil)
        }
    }
}

extension DetailMainPageController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navBar.bottomView.alpha = scrollView.contentOffset.y/140
        navBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: scrollView.contentOffset.y/140)
        
        if scrollView.contentOffset.y/140 >= 0.5 {
            navBar.backButton.setImage(#imageLiteral(resourceName: "arrow_back"), for: .normal)
            navBar.rightButton.isHidden = true
        } else {
            navBar.backButton.setImage(#imageLiteral(resourceName: "arrow_back-1"), for: .normal)
            navBar.rightButton.isHidden = false
        }
    }

}
