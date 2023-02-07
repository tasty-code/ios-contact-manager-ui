//
//  AddContactViewController.swift
//  ContactManagerUI
//
//  Created by DONGWOOK SEO on 2023/02/01.
//

import UIKit

final class AddContactViewController: UIViewController {
    
    var contactUIManager: ContactUIManager?
    
    @IBOutlet weak private var nameTextField: UITextField!
    @IBOutlet weak private var ageTextField: UITextField!
    @IBOutlet weak private var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
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
            guard let formattedPhoneNumber = contactUIManager.formmatingPhoneNumber(with: phoneNumber) else { return }
            let userInputModel = UserInputModel(name: name, age: age, phoneNum: formattedPhoneNumber)
            
            try contactUIManager.runProgram(menu: .add, userInputModel: userInputModel)
        } catch {
            presentErrorAlert(with: error.localizedDescription)
        }
    }
    
    private func presentErrorAlert(with message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "예", style: .default, handler: nil)
        
        alert.addAction(confirm)
        
        present(alert, animated: true)
    }
}
