//
//  Extension+TableView.swift
//  ContactManagerUI
//
//  Created by 송선진 on 2023/02/10.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ Type: T.Type) {
        register(Type, forCellReuseIdentifier: Type.reuseIdentifier)
    }

    func dequeue<T: UITableViewCell>(_ t: T.Type, cellForRowAt indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("\(T.self) is not registered!")
        }
        return cell
    }
}
