//
//  NotificationViewModel.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 5/28/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
class NotificationViewModel {
    var delegate: ProcessViewDelegate?
    var notificationList = [NotificationModel]()
    
    func getNotificationList() -> Void {
        ParseManager.shared.getRequest(url: AppConstants.API.getNotifications, success: { (result: Notification) in
            self.notificationList = result.data
            self.delegate?.endRefreshing()
            self.delegate?.hideLoader()
            self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.endRefreshing()
            self.delegate?.hideLoader()
            self.delegate?.showErrorMessage(error)
        }
    }
}
