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
        
    }
    
    @IBAction private func tappedSaveButton(_ sender: UIBarButtonItem) {
        guard let contactUIManager else { return }
        
        do {
            guard let name = nameTextField.text else { throw Errors.wrongName }
            guard let age = ageTextField.text else { throw Errors.wrongAge }
            guard let phoneNumber = phoneNumberTextField.text else { throw Errors.wrongPhoneNumber }
            guard let formattedPhoneNumber = contactUIManager.formmatingPhoneNumber(with: phoneNumber) else { return }
            let userInputModel = UserInputModel(name: name, age: age, phoneNum: formattedPhoneNumber)
            
            try contactUIManager.runProgram(menu: .add, data: userInputModel)
        } catch {
            print(error.localizedDescription)
        }
    }
}
