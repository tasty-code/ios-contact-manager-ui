//
//  UIView.swift
//  ContactManager
//
//  Created by Janine on 2023/10/16.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}

