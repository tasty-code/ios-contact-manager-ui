//
//  EditContactViewController.swift
//  ios-contact-manager-ui
//
//  Created by 김준성 on 2023/10/11.
//

import UIKit

final class EditContactViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTextFields()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "새 연락처"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tapCancelButton(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(tapSaveButton(_:)))
    }
    
    private func configureTextFields() {
        self.ageTextField.keyboardType = .numberPad
        self.phoneNumberTextField.keyboardType = .numbersAndPunctuation
    }
    
    @objc private func tapCancelButton(_ sender: UIBarButtonItem) {
        showCancelAlert()
    }
    
    @objc private func tapSaveButton(_ sender: UIBarButtonItem) {
        do {
            try checkContactValidation()
        } catch {
            showInvalidContactAlert(error.localizedDescription)
        }
    }
    
    private func showInvalidContactAlert(_ message: String) {
        let invalidContactAlert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        invalidContactAlert.addAction(UIAlertAction(title: "확인", style: .default))
        
        present(invalidContactAlert, animated: true)
    }
    
    private func showCancelAlert() {
        let message = "정말로 취소 하시겠습니까?"
        let cancelAlert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        cancelAlert.addAction(UIAlertAction(title: "아니오", style: .cancel))
        cancelAlert.addAction(UIAlertAction(title: "예", style: .destructive) { _ in
            self.dismiss(animated: true)
        })
        present(cancelAlert, animated: true)
    }
    
    private func checkContactValidation() throws {
        throw ContactException.invalidInput(type: .name)
    }
}
