//
//  AddContactViewController.swift
//  ContactManager
//
//  Created by Effie on 1/13/24.
//

import UIKit

final class AddContactViewController: UIViewController {
    private let addContactUseCase: AddContactUseCase
    
    private let nameField = InputView(fieldName: "이름") { input in
        guard input.contains(where: { $0 == " " }) == false else {
            let result = input.components(separatedBy: " ").reduce("") { $0 + $1 }
            return FormattingResult(formatted: result, validationError: NameValidationError.cannotContainBlank)
        }
        return FormattingResult(formatted: input, validationError: nil)
    }
    
    private let ageField = InputView(fieldName: "나이") { input in
        return FormattingResult(formatted: "", validationError: AgeValidationError.cannotStartWithZero)
    }
    
    private let phoneNumberField = InputView(fieldName: "전화번호") { input in
        let minimumLength = 9
        return FormattingResult(formatted: "", validationError: PhoneNumberValidationError.minimumLengthError(minimumLength))
    }
    
    private lazy var fieldStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(self.nameField)
        stack.addArrangedSubview(self.ageField)
        stack.addArrangedSubview(self.phoneNumberField)
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var saveButton: UIBarButtonItem = {
        let action = UIAction { [weak self] _ in self?.save() }
        let button = UIBarButtonItem(systemItem: .save, primaryAction: action)
        return button
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(useCase: AddContactUseCase) {
        self.addContactUseCase = useCase
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func save() {
        guard case let .success(name) = self.nameField.provideInput(),
              case let .success(age) = self.ageField.provideInput(),
              case let .success(phoneNumer) = self.phoneNumberField.provideInput()
        else {
            return
        }
        let request = AddContact.Request(name: name, age: age, phoneNumber: phoneNumer)
        self.addContactUseCase.saveNewContact(request: request)
    }
    
    private func setupViews() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItem = saveButton
        
        self.view.addSubview(fieldStack)
        NSLayoutConstraint.activate([
            fieldStack.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12),
            fieldStack.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            fieldStack.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}
