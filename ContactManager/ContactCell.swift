//
//  ContactCell.swift
//  ContactManagerUI
//
//  Created by 신동오 on 2023/02/01.
//

import UIKit

final class ContactCell: UITableViewCell {
    static let reuseIdentifier = String(describing: ContactCell.self)

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
}
