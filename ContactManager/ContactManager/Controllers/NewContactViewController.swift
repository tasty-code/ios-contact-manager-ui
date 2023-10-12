//
//  NewContactViewController.swift
//  ContactManager
//
//  Created by imseonghyeon on 2023/10/11.
//

import UIKit

@available(iOS 16.0, *)
class NewContactViewController: UIViewController {
    
    @IBOutlet private weak var cancelButton: UIBarButtonItem!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var ageTextField: UITextField!
    @IBOutlet private weak var contactTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchUpSaveButton(_ sender: Any) {
        checkName()
        checkAge()
        checkContact()
    }
    
    func checkName() {
        let regex = /^\S+$/
        if let name = nameTextField.text, let match = name.wholeMatch(of: regex) {
            print(match.output)
        }
    }
    
    func checkAge() {
        let regex = /^[0-9]{1, 3}$/
        if let age = ageTextField.text, let match = age.wholeMatch(of: regex) {
            print(match.output)
        }
    }
    
    func checkContact() {
        let regex = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/
        if let contact = contactTextField.text, let match = contact.wholeMatch(of: regex) {
            // 가능하면 match.output으로 받을 수 있도록 regex 수정하기
            print(match.output)
        }
    }
    
    @IBAction func touchUpCancelButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController()
        
        alertController
            .configureAlertController(title: "정말로 취소하시겠습니까?",
                                      message: nil,
                                      firstAction: "아니오",
                                      secondAction: "예",
                                      viewController: self)
    }
}
