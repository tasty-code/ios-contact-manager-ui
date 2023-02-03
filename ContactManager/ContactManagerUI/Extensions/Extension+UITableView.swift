//
//  Extension+UITableView.swift
//  ContactManagerUI
//
//  Created by 신동오 on 2023/02/03.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue Reusable TableView cell")
        }
        return cell
    }
}
