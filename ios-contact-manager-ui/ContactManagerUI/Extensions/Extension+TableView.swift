//
//  Extension+TableView.swift
//  ContactManagerUI
//
//  Created by 송선진 on 2023/02/10.
//

import UIKit

extension UITableView {
    
    func dequeue<T: UITableViewCell>(cellForRowAt indexPath: IndexPath) -> T {
        // register
        guard let cell = dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as? T else {
            fatalError("\(T.self) cell is not registered!")
        }
        return cell
    }
}
