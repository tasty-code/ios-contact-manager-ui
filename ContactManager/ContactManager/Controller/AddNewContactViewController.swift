//
//  AddNewContactViewController.swift
//  ContactManager
//
//  Created by 전성수 on 10/11/23.
//

import UIKit

protocol PersonContactUpdating: AnyObject {
    func updateNewPersonContact(name: String, age: String, digits: String)
}

final class AddNewContactViewController: UIViewController {
    
    weak var delegate: PersonContactUpdating?
    
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
        else {
            return presentInputValidationAlert(InputError.exception)
        }
        
        do {
            try hasText(name, age, digits)
            try isAgeLimitOver(age)
            try isDigitsProper(digits)
            name = removeEmptySpace(name)
            
            delegate?.updateNewPersonContact(name: name, age: age, digits: digits)
            self.dismiss(animated: true)
        } catch {
            presentInputValidationAlert(error)
        }
    }
    
    private func presentInputValidationAlert(_ error: Error) {
        let alert = UIAlertController(title: "\(error.localizedDescription)", message: nil, preferredStyle: .alert)
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
        let maxDigitsCount: Int = 13
        
        guard let inputDigitsText = inputDigits.text else { return false }
        
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                setHyphenInDigits(range: range, inputDigitsText: inputDigitsText, digitsCount: inputDigitsText.count)
                return true
            }
        }
        
        guard inputDigitsText.count < maxDigitsCount else { return false }
        
        setHyphenInDigits(range: range, inputDigitsText: inputDigitsText, digitsCount: inputDigitsText.count)
        
        return true
    }
    
    private func setHyphenInDigits(range: NSRange, inputDigitsText: String, digitsCount: Int) {
        switch digitsCount {
        case 0...10 :
            insertHyphenLessThanNine(range, inputDigitsText)
        case 11...12 :
            insertHyphenMoreThanNine(range, inputDigitsText)
        default:
            return
        }
    }
    
    private func insertHyphenLessThanNine(_ range: NSRange, _ inputDigitsText: String) {
        if range.length == 0 && (range.location == 2 || range.location == 6) {
            inputDigits.text = "\(inputDigitsText)-"
        }
    }
    
    private func insertHyphenMoreThanNine(_ range: NSRange, _ inputDigitsText: String) {
        var convertedDigits = inputDigitsText.components(separatedBy: ["-"]).joined()
        
        if range.length == 1 {
            convertedDigits.insert("-", at: convertedDigits.index(convertedDigits.startIndex, offsetBy: 2))
            convertedDigits.insert("-", at: convertedDigits.index(convertedDigits.startIndex, offsetBy: 6))
        } else {
            convertedDigits.insert("-", at: convertedDigits.index(convertedDigits.startIndex, offsetBy: 3))
            convertedDigits.insert("-", at: convertedDigits.index(convertedDigits.startIndex, offsetBy: 8))
        }
        
        inputDigits.text = convertedDigits
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
        if age[age.startIndex] == "0" {
            throw InputError.age
        }
        
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
