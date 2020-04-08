//
//  ResendCodeView.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 3/25/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ResendCodeView: UIView {
    //MARK:- Preasire
    var resendClousure: (() -> ())?
    var sec = 15
    var timer: Timer?
    
    lazy var resendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Переотправить код", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        button.isUserInteractionEnabled = false
        
        return button
    }()
    
    lazy var sendagainLabel: UILabel = {
        let label = UILabel()
        label.text = "через 0:\(sec)"
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13)
        
        return label
    }()
    //MARK:- Lifecycle

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK:- SetupViews
    func setupViews() -> Void {
        let resendButtonWidth = resendButton.titleLabel!.text!.size(withAttributes:[.font: UIFont.systemFont(ofSize: 13)]).width + 10

        addSubview(sendagainLabel)
        sendagainLabel.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
        }
        
        addSubview(resendButton)
        resendButton.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(resendButtonWidth)
            make.right.equalTo(sendagainLabel.snp.left).offset(2)
        }
    }
    
    func startSecondomer() -> Void {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(changeTimer), userInfo: nil, repeats: false)
    }
    
    func stopSecondomer() -> Void {
        timer?.invalidate()
        timer = nil
        sec = 15
    }
    
    private func setupAction() -> Void {
        resendButton.addTarget(self, action: #selector(resendAction), for: .touchUpInside)
    }
    
    //MARK: - @objc function
    @objc func resendAction() -> Void {
        resendButton.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        resendButton.titleLabel?.font = .systemFont(ofSize: 13)
        sec = 15
        sendagainLabel.text = sec/10 == 0 ? "через 0:0\(sec)" : "через 0:\(sec)"
        startSecondomer()
        resendClousure?()
    }
    
    @objc func changeTimer() -> Void {
        self.sec -= 1
        timer?.invalidate()
        timer = nil
        sendagainLabel.text = sec/10 == 0 ? "через 0:0\(sec)" : "через 0:\(sec)"
        
        if sec != 0 {
            startSecondomer()
        } else {
            resendButton.setTitleColor(.mainColor, for: .normal)
            resendButton.titleLabel?.font = .boldSystemFont(ofSize: 13)
            resendButton.isUserInteractionEnabled = sec == 0

        }

    }


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
