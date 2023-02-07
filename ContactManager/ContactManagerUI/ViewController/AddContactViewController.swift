//
//  AddContactViewController.swift
//  ContactManagerUI
//
//  Created by 신동오 on 2023/02/06.
//

import UIKit

protocol AddContactViewControllerDelegate {
    func didContactChanged()
}

final class AddContactViewController: UIViewController {
    // MARK: - Properties
    var delegate: AddContactViewControllerDelegate?
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var ageTextField: UITextField!
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private weak var navigationBar: UINavigationBar!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.shadowImage = UIImage()
        configureTextField()
    }
    
    // MARK: - Actions
    @IBAction private func tappedCancelButton(_ sender: UIBarButtonItem) {
        showCheckCancelAlert()
    }
    
    @IBAction private func tappedSaveButton(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text ,
              let age = ageTextField.text,
              let phoneNumber = phoneNumberTextField.text else { return }
        
        let inputArray = [name, age, phoneNumber]
        
        do {
            let contact = try InputManager.contact(from: inputArray)
            ContactManager.shared.add(contact: contact)
        } catch {
            showFailAlert(withTitle: error.localizedDescription)
            return
        }
        
        dismiss(animated: true)
        delegate?.didContactChanged()
    }
    
    // MARK: - Helpers
    private func showFailAlert(withTitle title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(confirmAction)
        present(alert, animated: true)
    }
    
    private func showCheckCancelAlert() {
        let alert = UIAlertController(title: "정말로 취소하시겠습니까?", message: nil, preferredStyle: .alert)
        let noAction = UIAlertAction(title: "아니오", style: .cancel)
        let yesAction = UIAlertAction(title: "예", style: .destructive) { _ in self.dismiss(animated: true)
        }
        
        alert.addAction(noAction)
        alert.addAction(yesAction)
        
        present(alert, animated: true)
    }

    private func configureTextField() {
        nameTextField.delegate = self
        ageTextField.delegate = self
    }
}

extension AddContactViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField == ageTextField {
            guard string.isEmpty || Int(string) != nil else {
                return false
            }
        }
        return true
    }
}
