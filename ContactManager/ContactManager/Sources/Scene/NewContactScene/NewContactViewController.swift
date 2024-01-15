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
    @IBOutlet weak var contactTextField: UITextField!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: @IBAction
    @IBAction private func tapCancelButton(_ sender: UIBarButtonItem) {
        presentAlertWithCancel(title: "정말로 취소하시겠습니까?", okButtonTitle: "예", cancelButtonTitle: "아니오", okAction: { [weak self] _ in
            self?.dismiss(animated: true)
        })
    }
    
    @IBAction func tapSaveButton(_ sender: Any) {
       
        let name = nameTextField.text ?? ""
        let age = ageTextField.text ?? ""
        let contact = contactTextField.text ?? ""
        let checkData: ContactInfoModel = ContactInfoModel(name: name, age: Int(age) ?? 0, phoneNumber: contact)
        
        let result: [String: Bool] = checkValidityOfData(checkData)
        
        if result[checkData.name] == false {
            presentAlert(title: "입력한 이름 정보가 잘못되었습니다")
        } else if result[String(checkData.age)] == false {
            presentAlert(title: "입력한 나이 정보가 잘못되었습니다")
        } else if result[checkData.phoneNumber] == false {
            presentAlert(title: "입력한 연락처 정보가 잘못되었습니다")
        }
    }
    
    /// 유효성 검사
    func checkValidityOfData(_ data: ContactInfoModel) -> [String: Bool] {
        
        let correctName = data.name.deleteWhiteSpace(data.name)
        let isNameValid = !correctName.isEmpty
        
        let isAgeValid = String(data.age).checkValidityAge()
        let isContactValid = data.phoneNumber.checkValidityContact()
            
        let validationResults: [String: Bool] = [
            data.name: isNameValid,
            String(data.age): isAgeValid,
            data.phoneNumber: isContactValid
        ]
        
        return validationResults
    }
}

