//
//  AddNewContactViewController.swift
//  ContactManager
//
//  Created by 전성수 on 10/11/23.
//

import UIKit

final class AddNewContactViewController: UIViewController {
    
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputAge: UITextField!
    @IBOutlet weak var inputDigits: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputDigits.delegate = self
    }
    
    @IBAction private func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveNewPersonContact(_ sender: Any) {
        guard let name = inputName.text, let age = inputAge.text, let digits = inputDigits.text
        else { return }
        
        
        
        if hasText(name, age, digits) {
            print("몬드가잘못했네")
        } else {
            presentAlert("")
        }
        //나이 3자리와 122 언더
        //전화번호 9자리 미만일시 거를것
        
        inputName.text = removeEmptySpace(name)
    }
    
    func presentAlert(_ type: String) {
        var title: String = ""
        
        switch type {
        case "이름":
            title = "입력한 \(type)정보가 잘못되었습니다"
        case "나이":
            title = "입력한 \(type)정보가 잘못되었습니다"
        case "연락처":
            title = "입력한 \(type)정보가 잘못되었습니다"
        default:
            title = "입력한 정보가 잘못되었습니다"
        }
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}

extension AddNewContactViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let digitsLength = inputDigits.text?.count else { return false }
        
        guard let inputText = inputDigits.text else { return false }
        
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                setHyphenInDigits(range: range, inputText: inputText, digitsLength: digitsLength)
                return true
            }
        }
        
        guard inputDigits.text!.count < 13 else { return false }
        
        setHyphenInDigits(range: range, inputText: inputText, digitsLength: digitsLength)
        
        return true
    }
    
    private func setHyphenInDigits(range: NSRange, inputText: String, digitsLength: Int) {
        var inputText: String = inputText
        
        switch digitsLength {
        case 0...10 :
            if range.length == 0 && (range.location == 2 || range.location == 6) {
                inputDigits.text = "\(inputDigits.text!)-"
            }
        case 11...12 :
            inputText = inputText.components(separatedBy: ["-"]).joined()
            inputText.insert("-", at: inputText.index(inputText.startIndex, offsetBy: 3))
            inputText.insert("-", at: inputText.index(inputText.startIndex, offsetBy: 8))
            inputDigits.text = inputText
            if range.length == 1 {
                inputText = inputText.components(separatedBy: ["-"]).joined()
                inputText.insert("-", at: inputText.index(inputText.startIndex, offsetBy: 2))
                inputText.insert("-", at: inputText.index(inputText.startIndex, offsetBy: 6))
                inputDigits.text = inputText
            }
        default:
            return
        }
    }
    
    func hasText(_ name: String, _ age: String, _ digits: String) -> Bool {
        if name.isEmpty {
            presentAlert("이름")
            return false
        } else if age.isEmpty {
            presentAlert("나이")
            return false
        } else if digits.isEmpty{
            presentAlert("연락처")
            return false
        }
        
        return true
    }
    
    func removeEmptySpace(_ name: String) -> String {
        let removedEmptyName = name.components(separatedBy: [" "]).joined()
        
        return removedEmptyName
    }
}
