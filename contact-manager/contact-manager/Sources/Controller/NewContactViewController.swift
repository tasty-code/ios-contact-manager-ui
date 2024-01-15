import UIKit

final class NewContactViewController: UIViewController {
    
    typealias AddContactHandler = (_ contact: Contact) throws -> Void
    
    private let updateTableViewHandler: () -> Void
    private let addContactHandler: AddContactHandler
    private var alertService = AlertService()
    
    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        configureNavigationBar(on: navigationBar, title: "새 연락처", leftButton: cancelButton, rightButton: saveButton, disableShadow: true)
        return navigationBar
    }()
    private let nameInputView = InputView(config: InputViewConfiguration(labelText: "이름", keyboardType: .default))
    private let ageInputView = InputView(config: InputViewConfiguration(labelText: "나이", keyboardType: .numberPad))
    private lazy var phoneNumberInputView: InputView = {
        let inputView = InputView(config: InputViewConfiguration(labelText: "연락처", keyboardType: .phonePad))
        inputView.delegate = self
        return inputView
    }()
    private lazy var inputForms: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameInputView, ageInputView, phoneNumberInputView])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(updateTableViewHandler: @escaping () -> Void,
         addContactHandler: @escaping AddContactHandler) {
        self.updateTableViewHandler = updateTableViewHandler
        self.addContactHandler = addContactHandler
        super.init(nibName: nil, bundle: nil)
        alertService.viewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
}

extension NewContactViewController {
    private func setupLayout() {
        view.backgroundColor = .white
        setupNavigationBar()
        setupInputForms()
    }
    
    private func setupNavigationBar() {
        view.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupInputForms() {
        view.addSubview(inputForms)
        NSLayoutConstraint.activate([
            inputForms.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 10),
            inputForms.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            inputForms.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }

    @objc private func cancelButtonTapped() {
        alertService.alertCancelConfirmation()
    }
    
    @objc private func saveButtonTapped() {
        let name = nameInputView.textFieldValue.trimmed()
        let age = ageInputView.textFieldValue
        let phoneNumber = phoneNumberInputView.textFieldValue
        
        if isInputFormsValidate(name: name, age: age, phoneNumber: phoneNumber) {
            let contact = Contact(phoneNumber: phoneNumber, name: name, age: age)
            saveNewContact(contact)
            updateTableViewHandler()
        }
    }
    
    private func isInputFormsValidate(name: String, age: String, phoneNumber: String) -> Bool {
        if !InputValidator.isValidName(name) {
            alertService.alertInvalidInput(alertMessage: .invalidName)
            return false
        }
        
        if !InputValidator.isValidAge(age) {
            alertService.alertInvalidInput(alertMessage: .invalidAge)
            return false
        }
        
        if !InputValidator.isValidPhoneNumber(phoneNumber) {
            alertService.alertInvalidInput(alertMessage: .invalidPhoneNumber)
            return false
        }
        
        return true
    }
    
    private func saveNewContact(_ contact: Contact) {
        do {
            try addContactHandler(contact)
            presentingViewController?.dismiss(animated: true)
        } catch {
            alertService.alertInvalidInput(alertMessage: .invalidPhoneNumber)
        }
    }
}

extension NewContactViewController: InputViewDelegate {
    func handleEditingChanged() {
        let phoneNumberText = phoneNumberInputView.textFieldValue
        guard let formattedPhoneNumber = PhoneNumberFormatter.format(unformatted: phoneNumberText) else {
            return
        }
        phoneNumberInputView.textFieldValue = formattedPhoneNumber
    }
}
