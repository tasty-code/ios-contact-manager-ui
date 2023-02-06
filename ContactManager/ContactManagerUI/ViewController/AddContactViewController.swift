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
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var navigationBar: UINavigationBar!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.shadowImage = UIImage()
    }

    // MARK: - Actions
    @IBAction func tappedCancelButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "정말로 취소하시겠습니까?", message: nil, preferredStyle: .alert)
        let noAction = UIAlertAction(title: "아니오", style: .cancel)
        let yesAction = UIAlertAction(title: "예", style: .destructive) { _ in self.dismiss(animated: true)
        }

        alert.addAction(noAction)
        alert.addAction(yesAction)

        present(alert, animated: true)
    }
    
    @IBAction func tappedSaveButton(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text ,
              let age = Int(ageTextField.text ?? ""),
              let phoneNumber = phoneNumberTextField.text else { return }
        let contact = Contact(name: name, age: age, phoneNumber: phoneNumber)
        ContactManager.shared.add(contact: contact)
        
        dismiss(animated: true)
        delegate?.didContactChanged()
    }
}
