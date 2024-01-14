//
//  addContactView.swift
//  contact-management
//
//  Created by 박찬호 on 1/11/24.
//

import UIKit

class AddContactView: UIViewController {
    private var contactListStorage: ContactListStorage?
    private var nameContact: String?
    private var phoneContact: String?
    private var ageContact: Int?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    required init?(coder: NSCoder) {
        self.contactListStorage = nil
        super.init(coder: coder)
    }
    
    init?(coder: NSCoder, contactListStorage: ContactListStorage) {
        self.contactListStorage = contactListStorage
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        setView()
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
        else { throw ContactListError.ContactListWrongInput }
        return ContactList(name: name, phoneNumber: phone, age: age)
    }
}

extension AddContactView {
    @IBAction func didWriteName(_ name: UITextField) {
        nameContact = name.text
    }
    
    @IBAction func didWriteAge(_ age: UITextField) {
        guard let age = age.text else {
            return
        }
        ageContact = Int(age)
    }
    
    @IBAction func didWritePhone(_ phone: UITextField) {
        phoneContact = phone.text
    }
    
    @IBAction func didTappedCancel(_ sender: Any){
        let cancel: AlertActionHandler = { [weak self] _ in
            self?.dismiss(animated: true)
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
            self.contactListStorage?.addContact(unWrappedResult)
            print(contactListStorage!.getContact(3))
        } catch {
            print(error.localizedDescription)
            return
        }
    }
}

extension AddContactView {
    
}

