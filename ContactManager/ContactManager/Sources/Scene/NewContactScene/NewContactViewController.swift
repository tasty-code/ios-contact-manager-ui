//
//  NewContactViewController.swift
//  ContactManager
//
//  Created by EUNJU on 2024/01/10.
//

import UIKit

final class NewContactViewController: UIViewController {

    // MARK: @IBOutlet
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var contactNumberTextField: UITextField!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: @IBAction
    @IBAction private func tapCancelButton(_ sender: UIBarButtonItem) {
        presentAlertWithCancel(title: "정말로 취소하시겠습니까?",
                               okButtonTitle: "예",
                               cancelButtonTitle: "아니오",
                               okAction: { [weak self] _ in
            self?.dismiss(animated: true)
        })
    }
    
    @IBAction private func tapSaveButton(_ sender: UIBarButtonItem) {
        let validationResult: [(ContactInfo, Bool)] = checkValidityOfContactData()
        
        for (key, result) in validationResult {
            if !result {
                presentAlert(title: "입력한 \(key.description) 정보가 잘못되었습니다")
                return
            }
        }
        
        let result: [String: Bool] = checkValidityOfData(checkData)
        
        guard let presentingViewController = presentingViewController as? ContactListViewController else {
            return
        }
    }
    
    // MARK: Custom Methods
    
    /// 연락처 정보 유효성 검사 메서드
    private func checkValidityOfContactData() -> [(ContactInfo, Bool)] {
        let name = nameTextField.text ?? ""
        let age = ageTextField.text ?? ""
        let contactNumber = contactNumberTextField.text ?? ""
        var validationResult: (name: Bool, age: Bool, contactNumber: Bool) = (false, false, false)
        
        validationResult.name = name.isEmpty ? false : true
        validationResult.age = age.isEmpty || age.count > 3 ? false : true
        validationResult.contactNumber = contactNumber.isEmpty || (!contactNumber.validatePhoneNumberFormat()
                               && !contactNumber.validateContactNumberFormat()) ? false : true
        
        return [(.name, validationResult.name), (.age, validationResult.age),
                (.contactNumber, validationResult.contactNumber)]
    }
}

