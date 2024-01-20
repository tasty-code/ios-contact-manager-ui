import UIKit

final class DetailContactViewController: UIViewController {
    
    private let contactManager: ContactManager = ContactManager.shared
    private let detailView: DetailContactView = DetailContactView()
    private let reloadDataClosure: (() -> Void)

    private lazy var saveButton: UIBarButtonItem = {
        let button: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        return button
    }()
    
    private lazy var cancelButton: UIBarButtonItem = {
        let button: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        return button
    }()
    
    init(reloadDataClosure: @escaping (() -> Void)) {
        self.reloadDataClosure = reloadDataClosure
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(CustomViewControllerString.fatalErrorText.description)
    }
}

// MARK: Lifecycle
extension DetailContactViewController {
    override func loadView() {
        view = detailView
        setupNavigator()
    }
}

// MARK: Method
extension DetailContactViewController {
    
    private func setupNavigator() {
        let navigationBarAppearance: UINavigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.tintColor = .blue
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
        title = CustomViewControllerString.detailTitleText.description
        navigationItem.rightBarButtonItem = self.saveButton
        navigationItem.leftBarButtonItem = self.cancelButton
    }

    @objc
    private func saveButtonTapped() {
        let name: String = detailView.nameTextField.text?.replacingOccurrences(of: " ", with: "") ?? ""
        let age: String = detailView.ageTextField.text ?? ""
        let phoneNumber: String = detailView.phoneNumberTextField.text ?? ""
        
        let textList: [String] = [name, age, phoneNumber]
        
        let okAction = UIAlertAction(title: CustomAlertString.alertActionOkText.description, style: .default)
        
        let isTextFieldValidResultDictionary = isTextFieldValid(inputContact: decodeContact(input: textList))
        checkNameTextFieldIsEmpty(name: name) ? showMessageAlertWithActions(inputMessage: CustomAlertString.isEmptyNameAlertMessage.description, actionList: [okAction]) : isValidCheck(inputValidDictionary: isTextFieldValidResultDictionary,contactInfo: decodeContact(input: textList))
    }
    
    @objc
    private func cancelButtonTapped() {
        let noAction = UIAlertAction(title: CustomAlertString.alertActionNoText.description, style: .default)
        let yesAction = UIAlertAction(title: CustomAlertString.alertActionYesText.description, style: .destructive) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        showMessageAlertWithActions(inputMessage: CustomAlertString.cancelAlertMessage.description, actionList: [yesAction, noAction])
    }
    
    private func showMessageAlertWithActions(inputMessage: String, actionList: [UIAlertAction]) {
        self.showMessageAlert(message: inputMessage, action: actionList)
    }
    
    private func checkNameTextFieldIsEmpty(name: String) -> Bool {
        return name.isEmpty ? true : false
    }
    
    private func decodeContact(input: [String]) -> Contact{
        let contact = Contact(name: input[0], age: Int(input[1]) ?? 0, phoneNumber: input[2])
        return contact
    }
    
    private func isTextFieldValid(inputContact: Contact) -> [String:Bool] {
        let namePattern: String = CustomValidString.regularExpressionNamePatthenText.description
        let agePattern: String = CustomValidString.regularExpressionAgePatthenText.description
        let phoneNumberPattern: String = CustomValidString.regularExpressionPhoneNumberPatthenText.description
        
        let isNameValidResult: Bool = NSPredicate(format: CustomValidString.regularMatchesText.description, namePattern).evaluate(with: inputContact.name)
        let isAgeValidResult: Bool = NSPredicate(format: CustomValidString.regularMatchesText.description, agePattern).evaluate(with: inputContact.age)
        let isPhoneNumberValidResult: Bool = NSPredicate(format: CustomValidString.regularMatchesText.description, phoneNumberPattern).evaluate(with: inputContact.phoneNumber)
        
        return [CustomValidString.validDictionaryNameKeyText.description: isNameValidResult,
                CustomValidString.validDictionaryAgeKeyText.description: isAgeValidResult,
                CustomValidString.validDictionaryPhoneNumberKeyText.description: isPhoneNumberValidResult]
    }
    
    private func isValidCheck(inputValidDictionary: [String: Bool], contactInfo: Contact) {
        let resultAction = UIAlertAction(title: CustomAlertString.alertActionOkText.description, style: .default)
    
        if let isNameValid = inputValidDictionary[CustomValidString.validDictionaryNameKeyText.description], !isNameValid {
            showMessageAlertWithActions(inputMessage: CustomAlertString.wrongNameAlertMessage.description, actionList: [resultAction] )
        } else if let isAgeValid = inputValidDictionary[CustomValidString.validDictionaryAgeKeyText.description], !isAgeValid {
            showMessageAlertWithActions(inputMessage: CustomAlertString.wrongAgeAlertMessage.description, actionList: [resultAction])
        } else if let isPhoneNumberValid = inputValidDictionary[CustomValidString.validDictionaryPhoneNumberKeyText.description], !isPhoneNumberValid {
            showMessageAlertWithActions(inputMessage: CustomAlertString.wrongPhoneNumberAlertMessage.description, actionList: [resultAction])
        } else {
            contactManager.createContact(name: contactInfo.name , age: contactInfo.age, number: contactInfo.phoneNumber)
            return self.dismiss(animated: true) { [weak self] in
                self?.reloadDataClosure()
            }
        }
    }
}

