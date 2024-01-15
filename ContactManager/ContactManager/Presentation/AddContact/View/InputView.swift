//
//  InputView.swift
//  ContactManager
//
//  Created by Effie on 1/14/24.
//

import UIKit

final class InputView: UIView {
    private let formatter: InputFormatter
    
    var currentValue: String {
        return self.textField.text ?? ""
    }
    
    private var state: ValidationError? {
        didSet {
            switch state {
            case .some(let error):
                self.inputStatelabel.text = error.noticeMessage
            case .none:
                self.inputStatelabel.text = " "
            }
        }
    }
    
    private let fieldNamelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let inputStatelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption2)
        return label
    }()
    
    private lazy var nameStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(self.fieldNamelabel)
        stack.addArrangedSubview(UIView())
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(self.textField)
        stack.addArrangedSubview(self.inputStatelabel)
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(self.nameStack)
        stack.addArrangedSubview(self.contentStack)
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(
        fieldName: String,
        keyboardType: UIKeyboardType,
        formatter: @escaping InputFormatter
    ) {
        self.formatter = formatter
        super.init(frame: .zero)
        textField.delegate = self
        configure(fieldName: fieldName, keyboardType: keyboardType)
        setupViews()
    }
    
    private func configure(fieldName: String, keyboardType: UIKeyboardType) {
        self.fieldNamelabel.text = fieldName
        self.inputStatelabel.text = "필수 필드입니다."
        self.textField.keyboardType = keyboardType
    }
    
    private func setupViews() {
        self.addSubview(self.hStack)
        NSLayoutConstraint.activate([
            self.hStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.hStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.hStack.topAnchor.constraint(equalTo: self.topAnchor),
            self.hStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.fieldNamelabel.heightAnchor.constraint(equalTo: self.textField.heightAnchor),
            self.textField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
        ])
    }
}

extension InputView: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let oldText = textField.text else { return false }
        guard string.isEmpty == false else { return true } // 지울 때
        let newText = NSString(string: oldText).replacingCharacters(in: range, with: string)
        let result = self.formatter(newText)
        textField.text = result.formatted
        self.state = result.validationError
        return false
    }
}
