//
//  NewContactViewController.swift
//  ios-contact-manager-ui
//
//  Created by 김진웅 on 2023/10/10.
//

import UIKit

protocol ContactsTableViewUpdateDelegate: AnyObject {
    func didContactsAdded(_ contactId: ObjectIdentifier)
}

final class NewContactViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    private var contactManager: ContactManager?
    private weak var delegate: ContactsTableViewUpdateDelegate?
    var contact: Contact?
    private let hyphen: Character = "-"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        nameTextField.autocapitalizationType = .sentences
        ageTextField.keyboardType = .numberPad
        phoneNumberTextField.keyboardType = .phonePad
    }
    
    @IBAction func phoneNumberTextFieldEditingChanged(_ sender: UITextField) {
        guard let text = sender.text?.replacingOccurrences(of: "\(hyphen)", with: "") else { return }
        sender.text = text.formattingPhoneNumber(divider: hyphen)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        let alertKind = AlertKind.cancel(
            title: "정말로 취소하시겠습니까?",
            actions: [
                UIAlertAction(title: "예", style: .destructive, handler: { _ in
                    self.dismiss(animated: true)
                }),
                UIAlertAction(title: "아니오", style: .cancel)
            ]
        )
        present(alertKind.configureAlertController(), animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let contactManager = contactManager,
              let name = nameTextField.text,
              let age = ageTextField.text,
              let phoneNumber = phoneNumberTextField.text else { return }
        do {
            let contactId = contactManager.addContact(try Contact(name: name, age: age, phoneNumber: phoneNumber))
            delegate?.didContactsAdded(contactId)
            self.dismiss(animated: true)
        } catch {
            let alertKind = AlertKind.error(type: error, action: UIAlertAction(title: "예", style: .default))
            present(alertKind.configureAlertController(), animated: true)
        }
    }
}

extension NewContactViewController {
    func configureData(_ contactManager: ContactManager?, delegate: ContactsTableViewUpdateDelegate?, contact: Contact? = nil) {
        self.contactManager = contactManager
        self.delegate = delegate
        
        if contact != nil {
            self.navigationItem.title = "기존 연락처"
            self.contact = contact
        }
    }
}
    }
}
