//
//  InputView.swift
//  ContactManager
//
//  Created by Effie on 1/14/24.
//

import UIKit

final class InputView: UIView {
    private let fieldName: String
    
    private let content: String = ""
    
    private let state: String = "지원하는 형식이 아닙니다."
    
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
    
    init(fieldName: String) {
        self.fieldName = fieldName
        super.init(frame: .zero)
        textField.delegate = self
        configure()
        setupViews()
    }
    
    private func configure() {
        self.fieldNamelabel.text = self.fieldName
        self.inputStatelabel.text = self.state
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
        return true
    }
}

#warning("구현 이동")
protocol InputProvidable {
    func provideInput() -> Result<String, Error>
}

extension InputView: InputProvidable {
    func provideInput() -> Result<String, Error> {
        guard let text = self.textField.text else {
            return .failure(ContactValidateError.some)
        }
        
        // validate
        
        return .success(text)
    }
}

enum ContactValidateError: Error {
    case some
}
