//
//  UIStackView.swift
//  ContactManager
//
//  Created by Janine on 2023/10/16.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
}
