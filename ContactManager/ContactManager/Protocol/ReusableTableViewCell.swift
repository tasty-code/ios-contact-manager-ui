//
//  ReusableTableViewCell.swift
//  ContactManager
//
//  Created by Blu on 2023/02/03.
//

import Foundation

protocol ReusableTableViewCell {
    static var reuseIdentifier: String { get }
}

extension ReusableTableViewCell {
    static var reuseIdentifier: String { String(describing: self) }
}
