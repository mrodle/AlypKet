// ChatController.swift
// GulMarket
//
// Created by Yerassyl Zhassuzakhov on 6/3/19.
//Copyright © 2019 Yerassyl Zhassuzakhov. All rights reserved.
//

import UIKit

class ChatController: UIViewController {
    private var currentPage = 1
    private var numberOfPages = 1
    private var messageList: [MessageData] = [MessageData(message: "Приятно было познакомиться, Кит. Я заинтересован и хотел бы узнать больше о беспилотнике. Он все еще находится под гарантией? У тебя есть счета и прочее?", destination: "toOwner"), MessageData(message: "Конечно, мой друг. У меня они все есть.  Он был куплен в прошлом году, 24 марта, и до сих пор имеет гарантию.", destination: "toUser"), MessageData(message: "Вы бы приняли 40 тысяч долларов? Я готов его купить.", destination: "toOwner"), MessageData(message: "Приятно было познакомиться, Кит. Я заинтересован и хотел бы узнать больше о беспилотнике. Он все еще находится под гарантией? У тебя есть счета и прочее?", destination: "toOwner"), MessageData(message: "Конечно, мой друг. У меня они все есть.  Он был куплен в прошлом году, 24 марта, и до сих пор имеет гарантию.", destination: "toUser"), MessageData(message: "Вы бы приняли 40 тысяч долларов? Я готов его купить.", destination: "toOwner")] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    lazy var navBar = BackNavBarView(title: "Паленше Тугеншеев", rightButtonImage: #imageLiteral(resourceName: "more_vert"))
    var layout = UICollectionViewFlowLayout()

    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.register(MessageCell.self, forCellWithReuseIdentifier: MessageCell.cellIdentifier())
        cv.backgroundColor = .white
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 55, right: 0)
        cv.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        
        return cv
    }()
    
    lazy var messageSendView: MessageInputView = {
        let msv = MessageInputView(frame: .zero)
        
        return msv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCollectionView()
        setupActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupViews() {
        self.messageList.reverse()
        view.backgroundColor = .white
        view.addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(AppConstants.navBarHeight+AppConstants.statusBarHeight)
        }
        
        view.addSubview(messageSendView)
        messageSendView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
//            make.height.equalTo(55)
        }
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(messageSendView.snp.top)
            make.top.equalTo(navBar.snp.bottom)
        }
    }
    
    private func setupActions() -> Void {
//        messageSendView.l.addTarget(self, action: #selector(send), for: .touchUpInside)
        navBar.goBack = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setupCollectionView() {
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 20
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    @objc func send() -> Void {
        guard let text = messageSendView.textView.text, text.notEmpty() else { return }
//        self.sendMessage(message: text)
    }
    
    
}

extension ChatController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCell.cellIdentifier(), for: indexPath) as! MessageCell
        cell.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        let message = messageList[indexPath.item].message
        let owner = messageList[indexPath.item].destination
        cell.setCellLayoutAndData(message: message, owner: owner)
        
        if ((indexPath.item == messageList.count - 1) && (currentPage < numberOfPages)) {
            currentPage += 1
        }

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let message = messageList[indexPath.item].message
        let estimatedFrame = message.estimatedFrame()
        
        return CGSize(width: view.frame.width, height: estimatedFrame.height + 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }

}
