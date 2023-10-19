//
//  CellPresenter.swift
//  ios-contact-manager-ui
//
//  Created by BOMBSGIE on 2023/10/19.
//

import UIKit

protocol CellPresenter: AnyObject {
    var cell: UITableViewCell? { get }
    func setCell(_ cell: UITableViewCell)
    func formatContent(_ content: Contact)
}
