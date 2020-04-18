//
//  AllItemViewModel.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 4/18/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
class AllItemViewModel {
    weak var delegate: ProcessViewDelegate?
    var itemList = [ItemModel]()
    
    func getItemList() -> Void {
        itemList.removeAll()
        ParseManager.shared.getRequest(url: AppConstants.API.getItemList, success: { (result: ItemListModel) in
            self.delegate?.hideLoader()
            self.itemList.append(contentsOf: result.data)
            self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.endRefreshing()
            self.delegate?.showErrorMessage(error)
        }
    }

}
