//
//  EditViewController.swift
//  ios-contact-manager
//
//  Created by Swain Yun on 10/10/23.
//

import UIKit

class ContactFormViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    weak var delegate: ContactFormViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViewComponents()
        self.phoneNumberTextField.addTarget(self, action: #selector(phoneNumberTextFieldEditingChanged), for: .editingChanged)
    }
    
    @objc private func phoneNumberTextFieldEditingChanged(_ textField: UITextField) {
        guard let text = textField.text?.replacingOccurrences(of: "-", with: "") else { return }
        textField.text = text.formatted(by: "-")
    }
    
    func configureViewComponents() {
        self.ageTextField.keyboardType = .numberPad
        self.phoneNumberTextField.keyboardType = .phonePad
    }
    
    private func presentRewindCancelAlert() {
        let alert = UIAlertController(title: "정말로 취소하시겠습니까?", message: nil, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "예", style: .destructive) { _ in
            self.dismiss(animated: true)
        }
        let noAction = UIAlertAction(title: "아니오", style: .default)
        alert.addAction(noAction)
        alert.addAction(yesAction)
        self.present(alert, animated: true)
    }
    
    func presentErrorAlert(_ error: ContactError) {
        let alert = UIAlertController(title: error.description, message: nil, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirm)
        self.present(alert, animated: true)
    }
    
    @IBAction private func touchCancelBarButton(_ sender: UIBarButtonItem) {
        self.presentRewindCancelAlert()
    }
    
    @IBAction func touchSaveBarButton(_ sender: UIBarButtonItem) {
        
    }
}
