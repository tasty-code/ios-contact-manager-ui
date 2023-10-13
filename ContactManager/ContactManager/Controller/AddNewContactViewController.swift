//
//  AddNewContactViewController.swift
//  ContactManager
//
//  Created by 전성수 on 10/11/23.
//

import UIKit

protocol SendPersonContactData {
    func sendData(name: String, age: String, digits: String)
}

final class AddNewContactViewController: UIViewController {
    
    var delegate: SendPersonContactData?
    
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputAge: UITextField!
    @IBOutlet weak var inputDigits: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputDigits.delegate = self
    }
    
    @IBAction private func goBack(_ sender: Any) {
        presentUserCancelConfirmAlert()
    }
    
    @IBAction func saveNewPersonContact(_ sender: Any) {
        guard var name = inputName.text, let age = inputAge.text, let digits = inputDigits.text
        else { return }
        
        do {
            try hasText(name, age, digits)
            try isAgeLimitOver(age)
            try isDigitsProper(digits)
        } catch {
            switch error {
            case InputError.name:
                presentInputValidationAlert("이름")
                return
            case InputError.age:
                presentInputValidationAlert("나이")
                return
            case InputError.digits:
                presentInputValidationAlert("연락처")
                return
            default:
                presentInputValidationAlert("")
                return
            }
        }
        
        name = removeEmptySpace(name)
        
        delegate?.sendData(name: name, age: age, digits: digits)
        self.dismiss(animated: true)
    }
    
    private func presentInputValidationAlert(_ errorType: String) {
        var title: String = ""
        
        switch errorType {
        case "이름":
            title = "입력한 \(errorType)정보가 잘못되었습니다"
        case "나이":
            title = "입력한 \(errorType)정보가 잘못되었습니다"
        case "연락처":
            title = "입력한 \(errorType)정보가 잘못되었습니다"
        default:
            title = "입력한 정보가 잘못되었습니다"
        }
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    private func presentUserCancelConfirmAlert() {
        let alert = UIAlertController(title: "정말로 취소하시겠습니까?", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "예", style: .destructive, handler: {_ in 
            self.dismiss(animated: true)
        })
        let cancelAction = UIAlertAction(title: "아니오", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

extension AddNewContactViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let digitsCount = inputDigits.text?.count else { return false }
        
        guard let inputDigitsText = inputDigits.text else { return false }
        
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                setHyphenInDigits(range: range, inputDigitsText: inputDigitsText, digitsCount: digitsCount)
                return true
            }
        }
        
        guard digitsCount < 13 else { return false }
        
        setHyphenInDigits(range: range, inputDigitsText: inputDigitsText, digitsCount: digitsCount)
        
        return true
    }
    
    private func setHyphenInDigits(range: NSRange, inputDigitsText: String, digitsCount: Int) {
        var inputDigitsText: String = inputDigitsText
        
        switch digitsCount {
        case 0...10 :
            if range.length == 0 && (range.location == 2 || range.location == 6) {
                inputDigits.text = "\(inputDigits.text!)-"
            }
        case 11...12 :
            inputDigitsText = inputDigitsText.components(separatedBy: ["-"]).joined()
            inputDigitsText.insert("-", at: inputDigitsText.index(inputDigitsText.startIndex, offsetBy: 3))
            inputDigitsText.insert("-", at: inputDigitsText.index(inputDigitsText.startIndex, offsetBy: 8))
            inputDigits.text = inputDigitsText
            if range.length == 1 {
                inputDigitsText = inputDigitsText.components(separatedBy: ["-"]).joined()
                inputDigitsText.insert("-", at: inputDigitsText.index(inputDigitsText.startIndex, offsetBy: 2))
                inputDigitsText.insert("-", at: inputDigitsText.index(inputDigitsText.startIndex, offsetBy: 6))
                inputDigits.text = inputDigitsText
            }
        default:
            return
        }
    }
    
    private func removeEmptySpace(_ name: String) -> String {
        let removedEmptyName = name.components(separatedBy: [" "]).joined()
        
        return removedEmptyName
    }
    
    private func hasText(_ name: String, _ age: String, _ digits: String) throws {
        if name.isEmpty {
            throw InputError.name
        } else if age.isEmpty {
            throw InputError.age
        } else if digits.isEmpty{
            throw InputError.digits
        }
    }
    
    private func isAgeLimitOver(_ age: String) throws {
        guard let age = Int(age) else { throw InputError.exception }
        
        if age < 0 || age > 122 {
            throw InputError.age
        }
    }
    
    private func isDigitsProper(_ digits: String) throws {
        if digits.count < 11 {
            throw InputError.digits
        }
    }
}
