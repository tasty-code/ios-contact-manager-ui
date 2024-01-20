//
//  addContactView.swift
//  contact-management
//
//  Created by 박찬호 on 1/11/24.
//

import UIKit

final class AddContactViewController: UIViewController {
    var nameContact: String?
    var phoneContact: String?
    var ageContact: Int?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    private var contactListStorage: ContactListStorage?
    var phoneFormat: PhoneFormat?
    var tableCellIndex: Int?
    
    required init?(coder: NSCoder) {
        self.contactListStorage = nil
        phoneFormat = nil
        tableCellIndex = nil
        super.init(coder: coder)
    }
    
    init?(coder: NSCoder, contactListStorage: ContactListStorage) {
        self.contactListStorage = contactListStorage
        phoneFormat = PhoneFormat.init(appenCharacter: "-")
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        setView()
        addTextField()
        isClickedTableCell()
    }
    
    private func setView() {
        title = "새연락처"
        nameLabel.text = "이름"
        ageLabel.text = "나이"
        phoneLabel.text = "연락처"
    }
    
    private func unWrappedSender(name: String?, phone: String?, age: Int?) throws -> ContactList {
        guard let name,
              let phone,
              let age
        else {
            throw ContactListError.ContactListWrongInput
        }
        return ContactList(name: name, phoneNumber: phone, age: age)
    }
    
    private func isClickedTableCell() {
        let isNavigation = navigationController != nil
        if isNavigation {
            guard let unWrappedIndex = tableCellIndex else {
                return
            }
            nameTextField.text = contactListStorage?.getContact(unWrappedIndex).name
            ageTextField.text = contactListStorage?.getContact(unWrappedIndex).age.codingKey.stringValue
            phoneTextField.text = contactListStorage?.getContact(unWrappedIndex).phoneNumber
        }
    }
}

extension AddContactViewController {
    @IBAction func didTappedCancel(_ sender: Any){
        let isPresented = presentingViewController != nil
        let cancel: AlertActionHandler
        if isPresented {
            cancel = { [weak self] _ in
                self?.dismiss(animated: true)
            }
        } else {
            cancel = { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
        }
        present(Alert.stopEditContact(cancel).alertController, animated: true)
    }
    
    @IBAction func didTappedSave(_ sender: Any) {
        do {
            let unWrappedResult = try unWrappedSender(
                name: nameContact,
                phone: phoneContact,
                age: ageContact
            )
            
            let isNameValid = try ContactValidateCheck.name(unWrappedResult.name).check
            let isAgeValid = try ContactValidateCheck.age(unWrappedResult.age).check
            let isPhoneValid = try ContactValidateCheck.phone(unWrappedResult.phoneNumber).check
            
            if isNameValid,
               isAgeValid,
               isPhoneValid
            {
                self.contactListStorage?.addContact(unWrappedResult)
                NotificationCenter.default.post(name: NSNotification.Name("ModalDismissNC"), object: nil, userInfo: nil)
                self.dismiss(animated: true)
            }
        } 
        catch ContactListError.ContactNameIsValid {
            present(Alert.isCorrectName.alertController, animated: true)
        } 
        catch ContactListError.ContactAgeIsValid {
            present(Alert.isCorrectAge.alertController, animated: true)
        } 
        catch ContactListError.ContactPhoneIsValid {
            present(Alert.isCorrectPhone.alertController, animated: true)
        } 
        catch ContactListError.ContactListWrongInput {
            present(Alert.isCorrectList.alertController, animated: true)
        } 
        catch {
            return
        }
    }
}


