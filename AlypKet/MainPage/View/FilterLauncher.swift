//
//  FilterLauncher.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/6/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class FilterLauncher: NSObject, UITableViewDataSource, UITableViewDelegate{
    
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.separatorStyle = .none
        
        return tv
    }()
    
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    let cancelButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("Отмена", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        return btn
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Выберите город"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let cityArray = ["Алматы","Астана","Актау","Актобе","Атырау","Жанаозен","Жезказган","Караганда","Павлодар"]
    let blackView = UIView()
    
    
    override init() {
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.cellIdentifier())
        
    }

    func showSettings(){
        if let window = UIApplication.shared.keyWindow{
            cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(view)
            view.addSubview(cancelButton)
            view.addSubview(tableView)
            view.addSubview(label)
            let height = window.frame.height * 0.62
            view.frame = CGRect(x: 24, y: window.frame.height/5.3, width: window.frame.width-48, height: height)
            
            cancelButton.snp.makeConstraints { (make) in
                make.left.right.bottom.equalToSuperview()
                make.height.equalTo(60)
            }
            
            label.snp.makeConstraints { (make) in
                make.top.right.equalToSuperview()
                make.left.equalTo(12)
                make.height.equalTo(60)
            }
            tableView.snp.makeConstraints { (make) in
                make.top.equalTo(label.snp.bottom)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(cancelButton.snp.top)
            }
            blackView.frame = window.frame
            blackView.alpha = 1
        }
    }
    
    
    @objc func handleCancel(){
        dismissFunc()
    }
    
    
    @objc func handleDismiss(){
        dismissFunc()
    }
    
    
    func dismissFunc(){
        self.blackView.alpha = 0
        
        if let window = UIApplication.shared.keyWindow {
            self.view.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width-32, height: self.tableView.frame.height)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.cellIdentifier(), for: indexPath)
        cell.textLabel?.text = cityArray[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = .getProximaNovaRegularFont(on: 18)
        cell.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9803921569, blue: 0.9882352941, alpha: 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}

