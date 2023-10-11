//
//  NewContectViewController.swift
//  ios-contact-manager-ui
//
//  Created by JaeHyeok Sim on 2023/10/11.
//

import UIKit

protocol SendDelegate {
    func sendContact(newContact: Contact)
}

class NewContactViewController: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var delegate: SendDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSetting()
    }

    func navigationSetting() {
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
    }
}

extension NewContactViewController {
    @IBAction func tappedCancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @IBAction func tappedSaveButton(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text, let phoneNumber = phoneNumberTextField.text else { return }
        guard let stringAge = ageTextField.text, let age = Int(stringAge) else { return }
        
        delegate?.sendContact(newContact: Contact(name: name, phoneNumber: phoneNumber, age: age))
        self.dismiss(animated: true)
    }
}
