//
//  FilterViewController.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/16/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit


class FilterViewController: LoaderBaseViewController {
    
    
    let topView: TopFilterView = {
       let view = TopFilterView()
        
       return view
    }()
    
    let bottomView: BottomFilterView = {
        let view = BottomFilterView()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupView()
        setupNavBarButtons()
        // Do any additional setup after loading the view.
    }
    
    
    func setupNavBarButtons(){
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2352941176, green: 0.568627451, blue: 0.8941176471, alpha: 1)
        label.font = .getProximaNovaSemiboldFont(on: 18)
        label.text = "Сбросить"
        let cancelImage = UIImage(named: "close")?.withRenderingMode(.alwaysTemplate)
        let cancelBarButtonItem = UIBarButtonItem(image: cancelImage, style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = cancelBarButtonItem
        self.navigationController?.navigationBar.backgroundColor = .white
        self.title = "Фильтр"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)

    }
    
    @objc func handleCancel(){
        print("cancel")
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

        
    private func setupView() -> Void{
        contentView.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        contentView.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
    }
}


