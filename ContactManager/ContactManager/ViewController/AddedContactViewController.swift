//
//  AddedContactViewController.swift
//  ContactManager
//
//  Created by Jin-Mac on 1/15/24.
//

import UIKit

protocol SendContactData {
    func addNewContact(name: String, age: Int, phoneNumber: String)
}

class AddedContactViewController: UIViewController {
    
    var delegate: SendContactData?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchUpSaveButton(_ sender: UIButton) {
        guard let name = nameTextField.text, let age = ageTextField.text, let phoneNumber = phoneNumberTextField.text else { return }
        guard let age = Int(age) else { return }
        delegate?.addNewContact(name: name, age: age, phoneNumber: phoneNumber)
        self.dismiss(animated: true)
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIButton) {
        showConfirmationAlert(title: "", message: "정말로 취소하시겠습니까?") { _ in
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}
