//
//  AddContactViewController.swift
//  Contact-Manager-iOS
//
//  Created by nayeon  on 2024/01/12.
//

import UIKit

final class DetailContctViewController: UIViewController {
    
    //MARK: - Property
    private let contactDetailView: ContactDetailView = ContactDetailView()
    var isPresentedModally: Bool = false
    var contact: Contact?
    weak var delegate: ContactDelegate?
   
    
    //MARK: - Life Cycle
    override func loadView() {
        view = contactDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureContactData()
        configureNavigationBar()
        contactDetailView.contactNumberTextField.addTarget(self, action: #selector(contactNumberTextFieldEditingChanged), for: .editingChanged)
    }
    
    
    //MARK: - Method
    private func configureContactData() {
        contactDetailView.contact = contact
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    
    private func presentCancelAlert() {
        let alert = UIAlertController(title: "정말로 취소하시겠습니까?", message: nil, preferredStyle: .alert)
        let noAction = UIAlertAction(title: "아니오", style: .default)
        let okAction = UIAlertAction(title: "예", style: .destructive) { [weak self] _ in
            self?.moveToContactsViewScreen()
        }
        alert.addAction(noAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func moveToContactsViewScreen() {
        if isPresentedModally {
            self.dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func presentSaveFailureAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func validateInput() throws {
        let currentContactInpt: ContactInput = contactDetailView.fetchCurrentContactInput()
        let name = currentContactInpt.name.replacingOccurrences(of: " ", with: "")
        let ageString = currentContactInpt.age
        let contactNumber = currentContactInpt.contactNumber
        
        try validateName(name)
        try validateAge(ageString)
        try validateContactNumber(contactNumber)
    }
    
    private func updateContact(name: String, age: String, contactNumber: String){
        if var contact = contact {
            contact.name = name
            contact.age = age
            contact.contactNumber = contactNumber
            
            contactDetailView.contact = contact
            delegate?.updateContact(contactId: contact.id, with: contact)
        }
    }
    
    private func addNewContact(name: String, age: String, contactNumber: String){
        let newContact = Contact(name: name, age: age, contactNumber: contactNumber)
        delegate?.addNewContact(newContact: newContact)
    }
    
    private func validateName(_ name: String) throws {
        guard name != "" else {
            throw ContactInputError.invalidNameError
        }
    }
    
    private func validateAge(_ ageString: String) throws {
        guard let age = Int(ageString), 0 < age && age <= 999, ageString != "",
              String(age) == ageString else {
            throw ContactInputError.invalidAgeError
        }
    }
    
    private func validateContactNumber(_ contact: String) throws {
        let phoneNumber = contact.replacingOccurrences(of: "-", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
        guard phoneNumber.count >= 9, contact.filter({$0 == "-"}).count == 2 else {
            throw ContactInputError.invalidContactNumberError
        }
    }
    
//    func toggleIsPresentedModally() {
//        isPresentedModally = !isPresentedModally
//    }
    
    
    //MARK: - Selector
    @objc private func cancelButtonTapped() {
        presentCancelAlert()
    }
    
    @objc private func saveButtonTapped() {
        do {
            let currentContactInput: ContactInput = contactDetailView.fetchCurrentContactInput()
            try validateInput()
            if contact == nil{
                addNewContact(name: currentContactInput.name, age: currentContactInput.age, contactNumber: currentContactInput.contactNumber)
            } else {
                updateContact(name: currentContactInput.name, age: currentContactInput.age, contactNumber: currentContactInput.contactNumber)
            }
        } catch let error as ContactInputError {
            presentSaveFailureAlert(message: error.errorDescription)
        } catch {
            print("예상치못한 에러")
        }
        
        moveToContactsViewScreen()
    }
    
    @objc private func contactNumberTextFieldEditingChanged(_ textField: UITextField) {
        guard textField == contactDetailView.contactNumberTextField else {
            return
        }

        var formattedNumber = textField.text?.replacingOccurrences(of: "-", with: "").replacingOccurrences(of: " ", with: "") ?? ""

        if formattedNumber.count >= 3 && formattedNumber.count <= 5 {
            let insertIndex = formattedNumber.hasPrefix("0") && formattedNumber.prefix(2) != "02" ? 3 : 2
            formattedNumber.insert("-", at: formattedNumber.index(formattedNumber.startIndex, offsetBy: insertIndex))
        } else if formattedNumber.count >= 6 && formattedNumber.count <= 10 {
            let insertIndex = formattedNumber.hasPrefix("0") && formattedNumber.prefix(2) != "02" ? 3 : 2
            formattedNumber.insert("-", at: formattedNumber.index(formattedNumber.startIndex, offsetBy: insertIndex))
            formattedNumber.insert("-", at: formattedNumber.index(formattedNumber.startIndex, offsetBy: insertIndex + 4))
        } else if formattedNumber.count > 10 && formattedNumber.count < 12 {
            let insertIndex = formattedNumber.hasPrefix("0") && formattedNumber.prefix(2) != "02" ? 3 : 2
            formattedNumber.insert("-", at: formattedNumber.index(formattedNumber.startIndex, offsetBy: insertIndex))
            formattedNumber.insert("-", at: formattedNumber.index(formattedNumber.startIndex, offsetBy: insertIndex + 5))
        }

        if let lastChar = formattedNumber.last, lastChar == "-" {
            formattedNumber.removeLast()
        }

        textField.text = formattedNumber
    }
}
