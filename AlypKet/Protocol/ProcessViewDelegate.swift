//
//  ProcessViewDelegate.swift
//  AlypKet
//
//  Created by Eldor Makkambayev on 4/18/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation

protocol ProcessViewDelegate: class {
    func updateUI()
    func showErrorMessage(_ message: String)
    func endRefreshing()
    func showSuccess(_ message: String?)
    func showLoader()
    func hideLoader()
}
