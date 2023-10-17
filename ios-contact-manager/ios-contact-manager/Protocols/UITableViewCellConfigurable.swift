//
//  UITableViewCellConfigurable.swift
//  ios-contact-manager
//
//  Created by Swain Yun on 10/10/23.
//

import UIKit

protocol ContactCellConfigurable {
    func configureCell(_ tableView: ContactListViewController, item: Contact)
}
