//
//  EditProfileViewModel.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 4/24/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
class EditProfileViewModel {
    weak var delegate: ProcessViewDelegate?
    
    func getEditInformation(photoParams: Parameters, params: Parameters, id: String) -> Void {
        self.delegate?.showLoader()
        if !photoParams.isEmpty {
            ParseManager.shared.putRequest(url: AppConstants.API.getEditUser+"/\(id)/photo", parameters: photoParams, success: { (result: EditUserImageModel) in
                self.getEditUerInfo(params: params, id: id)
            }) { (error) in
                self.delegate?.showErrorMessage(error)
            }
        } else {
            self.getEditUerInfo(params: params, id: id)
        }
    }
    
    func getEditUerInfo(params: Parameters, id: String) -> Void {
        self.delegate?.showLoader()
        ParseManager.shared.putRequest(url: AppConstants.API.getEditUser+"/\(id)", parameters: params, success: { (result: AuthModel) in
            do { try? UserManager.createSessionWithUser(result) }
            self.delegate?.hideLoader()
            self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }

}
