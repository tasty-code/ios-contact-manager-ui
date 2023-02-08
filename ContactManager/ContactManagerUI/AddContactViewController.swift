//
//  AddContactViewController.swift
//  ContactManagerUI
//
//  Created by DONGWOOK SEO on 2023/02/01.
//

import UIKit

final class AddContactViewController: UIViewController {
    
    // MARK: - Properties

    var contactUIManager: ContactUIManager?
    var contactListTableView: UITableView?
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak private var nameTextField: UITextField!
    @IBOutlet weak private var ageTextField: UITextField!
    @IBOutlet weak private var phoneNumberTextField: UITextField!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction private func tappedCancelButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "정말로 취소하시겠습니까?", message: nil, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "예", style: .destructive) { _ in
            self.dismiss(animated: true)
        }
        let cancel = UIAlertAction(title: "아니오", style: .default)
        
        alert.addAction(cancel)
        alert.addAction(confirm)
        
        present(alert, animated: true)
    }
    
    @IBAction private func tappedSaveButton(_ sender: UIBarButtonItem) {
        guard let contactUIManager else { return }
        
        do {
            guard let name = nameTextField.text else { throw Errors.wrongName }
            guard let age = ageTextField.text else { throw Errors.wrongAge }
            guard let phoneNumber = phoneNumberTextField.text else { throw Errors.wrongPhoneNumber }
            
            let trimmedName = name.split(separator: " ").joined()
            let userInputModel = UserInputModel(name: trimmedName, age: age, phoneNum: phoneNumber)
            
            try contactUIManager.runProgram(menu: .add, userInputModel: userInputModel)
            contactListTableView?.reloadData()
            self.dismiss(animated: true)
        } catch {
            presentErrorAlert(with: error.localizedDescription)
        }
    }
    
    @IBAction private func phoneNumEditingChanged(_ sender: UITextField) {
        checkMaxLength(phoneNumberTextField, 13)
    }
}

// MARK: - Methods

extension AddContactViewController {
    
    private func setDelegate() {
        nameTextField.delegate = self
        phoneNumberTextField.delegate = self
    }
    
    private func presentErrorAlert(with message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "예", style: .default, handler: nil)
        
        alert.addAction(confirm)
        
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension AddContactViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let contactUIManager else { return }
        guard let text = textField.text else { return }
        
        if textField == phoneNumberTextField {
            guard let formattedPhoneNumber = contactUIManager.formmatingPhoneNumber(with: text) else { return }
            textField.text = formattedPhoneNumber
        }
    }
    
    func checkMaxLength(_ textField: UITextField, _ maxLength: Int) {
        if textField.text!.count > maxLength {
            textField.deleteBackward()
        }
    }
}
