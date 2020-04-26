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
    var id: String
    var inFavourite: Bool = false
    var phoneNumber: String = ""
    var favouriteId: String = ""
    
    lazy var viewModel: ItemViewModel = {
        let view = ItemViewModel()
        view.delegate = self
        
        return view
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateList), for: .valueChanged)
        refresh.tintColor = .mainColor
        
        return refresh
    }()

    lazy var navBar: BackNavBarView = {
        let view = BackNavBarView(title: "", rightButtonImage: #imageLiteral(resourceName: "star"))
        view.backButton.setImage(#imageLiteral(resourceName: "arrow_back-1"), for: .normal)
        view.goBack = {
            self.navigationController?.popViewController(animated: true)
        }
        view.rightButtonTarget = {
            self.inFavourite ? self.deleteFromFavourite() : self.getToFavourate()
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
    
//    MARK: - Initialization
    
    init(id: String) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
        setupLoaderView()
        showLoader()
        self.getData()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
        
//    MARK: - Setup function
    
    private func setupView() -> Void{
        self.navBar.rightButton.layer.cornerRadius = 12.5
        self.navBar.rightButton.layer.masksToBounds = true
        self.navBar.rightButton.backgroundColor = #colorLiteral(red: 0.2, green: 0.2470588235, blue: 0.3215686275, alpha: 0.25)

        view.backgroundColor = .white
        scrollView.delegate = self
        scrollView.refreshControl = refreshControl
        
        contentView.isHidden = true
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
        }
        
        contentView.addSubview(detailDescriptionView)
        
        
        detailDescriptionView.snp.makeConstraints { (make) in
            make.top.equalTo(detailCenterView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        contentView.addSubview(detailUserInfoView)
        
        detailUserInfoView.snp.makeConstraints { (make) in
            make.top.equalTo(detailDescriptionView.snp.bottom)
            make.left.right.equalToSuperview()
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
            make.width.height.equalTo(writeButton)
        }
    }
    
    private func setupAction() -> Void {
        sliderImageView.presentBlock = { [weak self]  controller in
            guard let `self` = self else { return }
            self.present(controller, animated: true, completion: nil)
        }
        writeButton.addTarget(self, action: #selector(writeAction), for: .touchUpInside)
        callButton.addTarget(self, action: #selector(callAction), for: .touchUpInside)
    }
    
    private func setupData(_ item: ItemModel?) -> Void {
        contentView.isHidden = false
        guard let item = item else { return }
        self.inFavourite = item.inFavorite
        self.favouriteId = item.favoriteId
        self.phoneNumber = item.phone
        self.navBar.rightButton.setImage(item.inFavorite ? #imageLiteral(resourceName: "yelStars") : #imageLiteral(resourceName: "star"), for: .normal)
        self.sliderImageView.setupData(item)
        self.detailCenterView.setupData(item)
        self.detailDescriptionView.setupData(item)
        self.detailUserInfoView.setupData(item)
    }
    
    private func getData() -> Void {
        viewModel.getItem(id: id)
    }
    
    func getToFavourate() -> Void {
        ParseManager.shared.postRequest(url: AppConstants.API.getToFavourite, parameters: ["bootcampId": id], success: { (result: FavouriteDataModel) in
            self.favouriteId = result.data!._id
            self.inFavourite.toggle()
            self.navBar.rightButton.setImage(#imageLiteral(resourceName: "yelStars"), for: .normal)
        }) { (error) in
            
        }
    }
    
    func deleteFromFavourite() -> Void {

        ParseManager.shared.deleteRequest(url: AppConstants.API.getToFavourite+"/\(favouriteId)", success: { (result: DeleteFavouriteModel) in
            self.inFavourite.toggle()
            self.navBar.rightButton.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        }) { (error) in
            if error == "The data couldn’t be read because it is missing." {
                self.inFavourite.toggle()
                self.navBar.rightButton.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            }
        }
    }

    @objc func updateList() -> Void {
        getData()
    }
    
    @objc func callAction() -> Void {
        if let url = URL(string: "tel://+7 \(phoneNumber.suffix(10))") {
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }

    }
    
    @objc func writeAction() -> Void {
        self.navigationController?.pushViewController(ChatController(), animated: true)
    }

}

extension DetailMainPageController: ProcessViewDelegate {
    func updateUI() {
        self.setupData(viewModel.item)
        self.refreshControl.endRefreshing()
    }
    
    func endRefreshing() {
        self.refreshControl.endRefreshing()
    }
    
    
}

extension DetailMainPageController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navBar.bottomView.alpha = scrollView.contentOffset.y/140
        navBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: scrollView.contentOffset.y/140)
        
        if scrollView.contentOffset.y/140 >= 0.5 {
            navBar.backButton.setImage(#imageLiteral(resourceName: "arrow_back"), for: .normal)
        } else {
            navBar.backButton.setImage(#imageLiteral(resourceName: "arrow_back-1"), for: .normal)
        }
    }

}
