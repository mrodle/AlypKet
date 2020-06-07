//
//  PopUpLongPressView.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/16/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class PopUpLongPressView: NSObject, UITableViewDataSource, UITableViewDelegate {

    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.separatorStyle = .none
        tv.layer.masksToBounds = true
        tv.layer.cornerRadius = 10
        return tv
    }()
    
    var selectClosure: ((Int) -> ())?
    
    var array = ["Удалить сообщения","Архивировать"]
    let blackView = UIView()
    
    override init() {
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.cellIdentifier())
        
    }

    func showSettings(index:Int){
        if let window = UIApplication.shared.keyWindow{
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.3)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(tableView)
            let height = window.frame.height * 0.62
            tableView.frame = CGRect(x: Int(Float(window.frame.width) - 200), y: index * 124 + 100, width: 188, height: 90)
            blackView.frame = window.frame
            blackView.alpha = 1
        }
    }
    
    @objc func handleDismiss(){
        dismissFunc()
    }
    
    func dismissFunc(){
        self.blackView.alpha = 0
        if let window = UIApplication.shared.keyWindow {
            self.tableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width-32, height: self.tableView.frame.height)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.cellIdentifier(), for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = .getProximaNovaMediumFont(on: 14)
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectClosure?(indexPath.row)
        self.dismissFunc()
    }
    
    
}
