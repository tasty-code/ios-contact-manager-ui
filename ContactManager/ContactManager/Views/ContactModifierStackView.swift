//
//  ContactModifierStackView.swift
//  ContactManager
//
//  Created by WonjiHa on 2023/10/16.
//

import UIKit

final class ContactModifierStackView: UIStackView {
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.adjustsFontForContentSizeCategory = true
        label.minimumScaleFactor = 0.5
        
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.widthAnchor.constraint(greaterThanOrEqualToConstant: 70).isActive = true
        
        let textStyle = UIFont.TextStyle.body
        label.font = UIFont.preferredFont(forTextStyle: textStyle)
        
        return label
    }()
    
    let field: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = .roundedRect
        
        field.adjustsFontSizeToFitWidth = true
        field.adjustsFontForContentSizeCategory = true
        
        let textStyle = UIFont.TextStyle.body
        field.font = UIFont.preferredFont(forTextStyle: textStyle)
        
        return field
    }()
    
    init(frame: CGRect, type: ValidateType) {
        super.init(frame: frame)
        addArrangedSubviews(label, field)
        
        label.text = type.description
        spacing = 10
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
