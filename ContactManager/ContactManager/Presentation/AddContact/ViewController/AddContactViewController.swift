//
//  AddContactViewController.swift
//  ContactManager
//
//  Created by Effie on 1/13/24.
//

import UIKit

final class AddContactViewController: UIViewController {
    private static let title = "새 연락처"
    
    private var addContactUseCase: AddContactUseCase
    
    private weak var coordinator: AddContactViewControllerDelegate?
    
    private let contactId: Int?
    
    private let nameField = InputView(fieldName: "이름", keyboardType: .default) { input in
        var formattedName = input
        if input.contains(where: { $0 == " " }) {
            formattedName = input.components(separatedBy: " ").reduce("") { $0 + $1 }
        }
        return formattedName
    }
    
    private let ageField = InputView(fieldName: "나이", keyboardType: .numberPad) { input in
        var formattedAge = input
        
        if input.first == "0" {
            formattedAge = String(input.dropFirst())
        } else if input.count >= 2 {
            formattedAge = String(input.prefix(2))
        }
        
        return formattedAge
    }
    
    private let phoneNumberField = InputView(fieldName: "전화번호", keyboardType: .phonePad) { input in
        func format(with mask: String, phone: String) -> String {
            let numbers = phone.filter { ch in ch.isNumber }
            var result = ""
            var index = numbers.startIndex
            for ch in mask where index < numbers.endIndex {
                if ch == "X" {
                    result.append(numbers[index])
                    index = numbers.index(after: index)
                } else {
                    result.append(ch)
                }
            }
            return result
        }
        
        let formattedText: String
        if input.first != "0" {
            formattedText = format(with: "XX-XXX-XXXX", phone: input)
        } else {
            formattedText = format(with: "XXX-XXXX-XXXX", phone: input)
        }
        return formattedText
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
        let action = UIAction { [weak self] _ in self?.didTapSaveButton() }
        let button = UIBarButtonItem(systemItem: .save, primaryAction: action)
        return button
    }()
    
    private lazy var cancelButton: UIBarButtonItem = {
        let action = UIAction { [weak self] _ in self?.didTapCancelButton() }
        let button = UIBarButtonItem(systemItem: .cancel, primaryAction: action)
        return button
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(
        contactId: Int?,
        useCase: AddContactUseCase,
        coordinator: AddContactViewControllerDelegate
    ) {
        self.contactId = contactId
        self.addContactUseCase = useCase
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        self.addContactUseCase.presenter = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setUpFields()
    }
    
    private func didTapSaveButton() {
        let request = AddContact.CreatContact.Request(
            name: self.nameField.currentValue,
            age: self.ageField.currentValue,
            phoneNumber: self.phoneNumberField.currentValue
        )
        self.addContactUseCase.saveNewContact(request: request)
    }
    
    private func didTapCancelButton() {
        let request = AddContact.CreatContact.Request(
            name: self.nameField.currentValue,
            age: self.ageField.currentValue,
            phoneNumber: self.phoneNumberField.currentValue
        )
        self.addContactUseCase.confirmCancel(request: request)
    }
    
    private func setupViews() {
        self.view.backgroundColor = .systemBackground
        self.title = Self.title
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = saveButton
        
        self.view.addSubview(fieldStack)
        NSLayoutConstraint.activate([
            fieldStack.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12),
            fieldStack.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            fieldStack.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    private func setUpFields() {
        guard let id = self.contactId else { return }
        let request = AddContact.FetchContact.Request(id: id)
        self.addContactUseCase.fetchContact(request: request)
    }
}

extension AddContactViewController: AddContactPresentable {
    func presentFetchContact(result: Result<Contact, Error>) {
        switch result {
        case .success(let contact):
            self.nameField.configure(with: contact.name)
            self.ageField.configure(with: "\(contact.age)")
            self.phoneNumberField.configure(with: contact.phoneNumber)
        case .failure(let error):
            handleError(error)
        }
    }
    
    func presentAddContact(result: Result<Void, Error>) {
        switch result {
        case .success:
            self.coordinator?.endAddContact()
        case .failure(let error):
            handleError(error)
        }
    }
    
    func presentCancelConfirmation(result: Result<Void, Error>) {
        switch result {
        case .success:
            self.coordinator?.cancelAddContact()
        case .failure(let error):
            if let addContactError = error as? AddContactError,
               addContactError == .someFieldIsFilled {
                let cancelAction = UIAlertAction(title: "작성 취소", style: .destructive) { _ in
                    self.coordinator?.endAddContact()
                }
                self.presentErrorAlert(error: addContactError, additionalAction: cancelAction)
            }
        }
    }
    
    private func handleError(_ error: Error) {
        if let error = error as? LocalizedError {
            print(error.localizedDescription)
        }
        if let error = error as? AlertableError {
            showErrorAlert(error: error)
        }
    }
}

extension AddContactViewController: ErrorAlertPresentableViewController {
    private func showErrorAlert(error: AlertableError) {
        self.presentErrorAlert(error: error)
    }
}
