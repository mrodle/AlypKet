// ChatController.swift
// GulMarket
//
// Created by Yerassyl Zhassuzakhov on 6/3/19.
//Copyright © 2019 Yerassyl Zhassuzakhov. All rights reserved.
//

import UIKit

class ChatController: UIViewController {
    var user: MessageUser
    private var currentPage = 1
    private var numberOfPages = 1
    private var messageList = [MessageData]() {
        didSet {
            self.messageList.reverse()
            collectionView.reloadData()

        }
    }
    private var messageUserList = [[MessageData]]() {
        didSet {
            self.messageList = messageUserList[user.id]
        }
    }
    
    var chatList = [MessageUser]()
    
    private var firstUserMessageList = [MessageData(message: "Приятно было познакомиться, Eldar. Я заинтересован и хотел бы узнать больше о беспилотнике. Он все еще находится под гарантией? У тебя есть счета и прочее?", destination: "toOwner"), MessageData(message: "Конечно, мой друг. У меня они все есть.  Он был куплен в прошлом году, 24 марта, и до сих пор имеет гарантию.", destination: "toUser"), MessageData(message: "Вы бы приняли 40 тысяч долларов? Я готов его купить.", destination: "toOwner")]
    
    private var secondUserMessageList = [MessageData(message: "Добрый день!", destination: "toOwner"), MessageData(message: "Могу ли я выполнить ваш заказ?", destination: "toOwner"), MessageData(message: "Добрый день! Да, конечно, если вы соглащаетесь с моими условиями.", destination: "toUser"), MessageData(message: "А какие ваши условия?", destination: "toOwner"),  MessageData(message: "Вечером я вам сам напишу", destination: "toUser")]

    private var thirdUserMessageList = [MessageData(message: "Қайырлы кеш! тауарды уақытынан 1 күннен кейін алып шықсам бола ма?", destination: "toUser"), MessageData(message: "Қайырлы кеш! сіздің жеткізіп беру уақытыңызға байланысты", destination: "toOwner"), MessageData(message: "Неше күнде жеткізіп бере аласыз?", destination: "toOwner"), MessageData(message: "Ұзағымен 3 күнде", destination: "toUser"), MessageData(message: "Онда кешіріңіз, маған ертерек жеткізілуі қажет", destination: "toOwner")]

    private var fourthUserMessageList = [MessageData(message: "Добрый вечер", destination: "toUser"), MessageData(message: "Сколько коробок у вас", destination: "toUser"), MessageData(message: "добрый вечер, 3", destination: "toOwner"), MessageData(message: "хорошо тогда вечером встретимся", destination: "toUser"), MessageData(message: "договорились", destination: "toOwner")]

    
    
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

    init(user: MessageUser) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCollectionView()
        setupActions()
        setupMessage()
        setupData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        do { try? MessageManager.setMessageList(messageUserList) }

    }
    
    private func setupViews() {
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
    
    private func setupData() -> Void {
        self.navBar.titleLabel.text = user.fromUserName
    }
    
    private func setupActions() -> Void {
        messageSendView.locationOrSendButton.addTarget(self, action: #selector(send), for: .touchUpInside)
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
    
    private func setupMessage() -> Void {
        self.chatList = MessageManager.getUserList()

        self.messageUserList = [firstUserMessageList, secondUserMessageList, thirdUserMessageList, fourthUserMessageList]
        if MessageManager.getMessageList().isEmpty {
            do { try? MessageManager.setMessageList(messageUserList) }
        } else {
            messageUserList = MessageManager.getMessageList()
        }
    }
    
    @objc func send(_ sender: UIButton) -> Void {
        if sender.imageView?.image == #imageLiteral(resourceName: "send") {
            guard let text = messageSendView.textView.text, text.notEmpty() else { return }
            self.messageUserList[user.id].append(MessageData(message: text, destination: "toOwner"))
            messageSendView.textView.text = ""
            self.chatList[user.id] = MessageUser(id: user.id, fromUserName: "\(user.fromUserName)", message: text, date: "", thomb: "\(user.id)")
            do { try? MessageManager.setUserList(chatList) }

        }
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
        cell.setCellLayoutAndData(message: message, owner: owner, user: user)
        
        if ((indexPath.item == messageList.count - 1) && (currentPage < numberOfPages)) {
            currentPage += 1
        }

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let message = messageList[indexPath.item].message
        let estimatedFrame = message.estimatedFrame()
        
        return CGSize(width: view.frame.width, height: estimatedFrame.height + 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }

}
