//
//  ItemViewModel.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 4/18/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
class ItemViewModel {
    weak var delegate: ProcessViewDelegate?
    var item: ItemModel?
    
    func getItem(id: String) -> Void {

        ParseManager.shared.getRequest(url: AppConstants.API.getItemList + "/\(id)", success: { (result: ItemDataModel) in
            self.item = result.data
            self.delegate?.hideLoader()
            self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.endRefreshing()
            self.delegate?.showErrorMessage(error)
        }
    }

}
