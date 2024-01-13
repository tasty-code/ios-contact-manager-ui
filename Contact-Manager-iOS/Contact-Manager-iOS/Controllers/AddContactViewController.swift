//
//  AddContactViewController.swift
//  Contact-Manager-iOS
//
//  Created by nayeon  on 2024/01/12.
//

import UIKit

final class AddContactViewController: UIViewController {
    
    //MARK: - Property
    private var contactManager: ContactManager
    private let addContactView = PersonalContactDetailView()
    weak var delegate: ContactDelegate?
    
    
    //MARK: - Initializer
    init(contactManager: ContactManager) {
        self.contactManager = contactManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = addContactView
        
        configureNavigationBar()
    }
    
    
    //MARK: - Method
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
    }
    
    @objc private func cancelTapped() {
        showCancelAlert()
    }
    
    @objc private func saveTapped() {
        guard let name = addContactView.accessNameTextField().text?.replacingOccurrences(of: " ", with: ""),
              let ageString = addContactView.accessAgeTextField().text,
              let age = Int(ageString),
              let contactNumber = addContactView.accessContactNumberTextField().text,
              isValidName(name),
              isValidAge(age),
              isValidContactNumber(contactNumber)
        else {
            if let name = addContactView.accessNameTextField().text, !isValidName(name) {
                showAlert(message: "입력한 이름 정보가 잘못되었습니다.")
            } else if !isValidAge(Int(addContactView.accessAgeTextField().text ?? "")) {
                showAlert(message: "입력한 나이 정보가 잘못되었습니다.")
            } else if let contact = addContactView.accessContactNumberTextField().text, !isValidContactNumber(contact) {
                showAlert(message: "입력한 연락처 정보가 잘못되었습니다.")
            }
            return
        }
       
        let addNewContact = Contact(name: name, age: ageString, contactNumber: contactNumber)
        delegate?.addNewContact(newContact: addNewContact)
        dismiss(animated: true, completion: nil)
    }
    
    private func isValidName(_ name: String) -> Bool {
        return !name.isEmpty
    }
    
    private func isValidAge(_ age: Int?) -> Bool {
        if let ageValue = age, 0 < ageValue && ageValue <= 999 {
            return true
        }
        return false
    }
    
    private func isValidContactNumber(_ contact: String) -> Bool {
        guard let phoneNumber = addContactView.accessContactNumberTextField().text?.replacingOccurrences(of: "-", with: "").trimmingCharacters(in: .whitespacesAndNewlines),
              phoneNumber.count >= 9,
              contact.filter({$0 == "-"}).count == 2
        else {
            return false
        }
        return true
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "알림",
                                      message: message,
                                      preferredStyle: .alert)

        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)

        present(alert, animated: true, completion: nil)
    }
    
    private func showCancelAlert() {
        let alert = UIAlertController(title: "정말로 취소하시겠습니까?",
                                      message: nil,
                                      preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "예", style: .default) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
        let close = UIAlertAction(title: "아니요", style: .destructive)
        
        alert.addAction(confirm)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
    
}
