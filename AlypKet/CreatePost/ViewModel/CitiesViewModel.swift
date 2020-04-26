//
//  CitiesViewModel.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 4/25/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
class CitiesViewModel {
    weak var delegate: ProcessViewDelegate?
    var cityList = [City]()
    
    func getItemList() -> Void {
        cityList.removeAll()
        ParseManager.shared.getRequest(url: AppConstants.API.getCityList, success: { (result: CityListModel) in
            self.delegate?.hideLoader()
            self.cityList.append(contentsOf: result.data)
            self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.endRefreshing()
            self.delegate?.showErrorMessage(error)
        }
    }
}
