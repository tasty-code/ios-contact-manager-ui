//
//  NewContactViewController.swift
//  ios-contact-manager-ui
//
//  Created by 김진웅 on 2023/10/10.
//

import UIKit

final class NewContactViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var contactManager: ContactManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func phoneNumberTextFieldEditingChanged(_ sender: UITextField) {
        guard let text = sender.text?.replacingOccurrences(of: "-", with: "") else { return }
        sender.text = text.formattingPhoneNumber()
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        showAlert(with: "정말로 취소하시겠습니까?")
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let contactManager = contactManager,
              let name = nameTextField.text,
              let age = ageTextField.text,
              let phoneNumber = phoneNumberTextField.text else { return }
        do {
            contactManager.addContact(try Contact(name: name, age: age, phoneNumber: phoneNumber))
            self.dismiss(animated: true)
        } catch {
            showAlert(with: String(describing: error))
        }
    }
}

extension NewContactViewController {
    private func showAlert(with title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        if title == "정말로 취소하시겠습니까?" {
            let noAction = UIAlertAction(title: "아니오", style: .default)
            alert.addAction(noAction)
            
            let yesAction = UIAlertAction(title: "예", style: .destructive) { _ in
                self.dismiss(animated: true)
            }
            alert.addAction(yesAction)
        } else {
            let yesAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(yesAction)
        }
        self.present(alert, animated: true)
    }
}
