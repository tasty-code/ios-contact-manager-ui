//
//  Extension+UITableViewCell.swift
//  ContactManagerUI
//
//  Created by 신동오 on 2023/02/03.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}
