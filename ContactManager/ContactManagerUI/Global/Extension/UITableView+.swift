//
//  UITableView+.swift
//  ContactManagerUI
//
//  Created by DONGWOOK SEO on 2023/02/09.
//

import UIKit

extension UITableView {
    func dequeueCell<T: UITableViewCell>(type: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else { return T() }
        return cell
    }
}
