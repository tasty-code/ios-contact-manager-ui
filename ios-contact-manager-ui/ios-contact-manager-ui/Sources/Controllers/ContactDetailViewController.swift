//
//  ContactDetailViewController.swift
//  ios-contact-manager-ui
//
//  Created by 미르, 루피 on 1/11/24.
//

import UIKit

protocol ContactDetailDelegate: AnyObject {
    func add(contact: Contact)
    func update(contact: Contact)
}

final class ContactDetailViewController: UIViewController {
    
    private let detailView = DetailView()
    var contact: Contact?
    weak var delegate: ContactDetailDelegate?
    
    private lazy var cancelButton: UIBarButtonItem = {
        let customBtton = UIButton(type: .system)
        customBtton.setTitle("Cancel", for: .normal)
        customBtton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        let buttonSize = CGSize(width: 15, height: 15)
        customBtton.frame = CGRect(origin: .zero, size: buttonSize)
        
        let button = UIBarButtonItem(customView: customBtton)
        
        return button
    }()
    
    private lazy var saveButton: UIBarButtonItem = {
        let customBtton = UIButton(type: .system)
        customBtton.setTitle("Save", for: .normal)
        customBtton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        let buttonSize = CGSize(width: 15, height: 15)
        customBtton.frame = CGRect(origin: .zero, size: buttonSize)
        
        let button = UIBarButtonItem(customView: customBtton)
        button.isEnabled = false
        
        return button
    }()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupnvBar()
        viewTextField()
        detailView.contact = contact
    }
    
    private func viewTextField() {
        detailView.nameTextField.delegate = self
        detailView.ageTextField.delegate = self
        detailView.phoneNumberTextField.delegate = self
    }
    
    private func setupnvBar() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]
        if contact == nil {
            title = "새연락처"
            navigationItem.leftBarButtonItem = cancelButton
            navigationItem.rightBarButtonItem = saveButton
        } else {
            title = "기존연락처"
            navigationItem.leftBarButtonItem = cancelButton
            navigationItem.rightBarButtonItem = saveButton
        }
    }
    
    @objc private func cancelButtonTapped() {
        let alert = showErrorAlert(title: nil, "정말 취소하시겠습니까?", actions: [UIAlertAction(title: "예", style: .cancel, handler: { _ in
            self.dismiss(animated: true)
        }), UIAlertAction(title: "아니오", style: .destructive)])
        present(alert, animated: true)
    }
    
    @objc private func saveButtonTapped() {
        do {
            let (name, age, phone) = try makeInfo()
            
            if let id = contact?.id {
                let editContact = Contact(id: id, name: name, phoneNumber: phone, age: age)
                delegate?.update(contact: editContact)
            } else {
                let newContact = Contact(name: name, phoneNumber: phone, age: age)
                delegate?.add(contact: newContact)
            }
            self.dismiss(animated: true)
        } catch {
            let alert = showErrorAlert(title: nil, error.localizedDescription, actions: [UIAlertAction(title: "확인", style: .default)])
            present(alert, animated: true)
        }
    }
}

// MARK: - Verification

extension ContactDetailViewController {
    func makeInfo() throws -> (String, String, String) {
        guard let name = detailView.nameTextField.text, Verification.setName(name) else { throw ContactError.errorName }
        guard let age = detailView.ageTextField.text, Verification.setAge(age) else { throw ContactError.errorAge }
        guard let phone = detailView.phoneNumberTextField.text, Verification.setNumber(phone) else { throw ContactError.errorNumber }
        
        return (name.removeBlank, age, phone)
    }
}

extension ContactDetailViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let contact = self.contact else { return saveButton.isEnabled = true }
            
            if detailView.nameTextField.text == contact.name &&
                detailView.ageTextField.text == contact.age &&
                detailView.phoneNumberTextField.text == contact.phoneNumber {
                saveButton.isEnabled = false
            } else {
                saveButton.isEnabled = true
            }
        }
    }
