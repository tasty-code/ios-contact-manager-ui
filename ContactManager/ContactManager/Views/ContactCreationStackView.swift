//
//  CreationStackView.swift
//  ContactManager
//
//  Created by WonjiHa on 2023/10/16.
//

import UIKit

final class ContactCreationStackView: UIStackView {
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return label
    }()
    
    let field: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = .roundedRect
        return field
    }()
    
    init(frame: CGRect, type: ValidateType) {
        super.init(frame: frame)
        label.text = type.description
        addArrangedSubviews(label, field)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
