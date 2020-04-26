//
//  favouriteModel.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 4/26/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
class FavouriteDataModel: Codable {
    var data: FavouriteModel?
}

class FavouriteModel: Codable {
    var _id: String
}

class DeleteFavouriteModel: Codable {
    var data: DeleteFavouriteDataModel
}

class DeleteFavouriteDataModel: Codable {
    
}
