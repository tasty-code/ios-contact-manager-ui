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
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        return button
    }()
    
    private lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(setupButtonAction))
        return button
    }()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupnvBar()
        detailView.contact = contact
    }

    private func setupnvBar() {
        if contact == nil {
            title = "새연락처"
            self.navigationItem.leftBarButtonItem = self.cancelButton
            self.navigationItem.rightBarButtonItem = self.saveButton
        } else {
            title = "기존연락처"
            self.navigationItem.leftBarButtonItem = self.cancelButton
            self.navigationItem.rightBarButtonItem = self.saveButton
        }
    }
    
    @objc func cancelButtonTapped() {
        let alert = showErrorAlert(title: nil, "정말 취소하시겠습니까?", actions: [UIAlertAction(title: "예", style: .cancel, handler: { _ in
            self.dismiss(animated: true)
        }), UIAlertAction(title: "아니오", style: .destructive)])
        present(alert, animated: true)
    }
    
    @objc func setupButtonAction() {
        do {
            let (name, age, phone) = try makeInfo()
            
            var new = contact == nil ? Contact(name: name, phoneNumber: phone, age: age) : contact!
            
               if contact != nil {
                    new.phoneNumber = phone
                    new.age = age
                    new.name = name
                    delegate?.update(contact: new)
            } else {
                delegate?.add(contact: new)
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
