//
//  Reusable.swift
//  ContactManagerUI
//
//  Created by sei_dev on 2/10/23.
//

import Foundation

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
