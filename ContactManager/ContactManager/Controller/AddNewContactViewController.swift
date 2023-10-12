//
//  AddNewContactViewController.swift
//  ContactManager
//
//  Created by 전성수 on 10/11/23.
//

import UIKit

final class AddNewContactViewController: UIViewController, UITextFieldDelegate {
    
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
        presentAlert("test")
    }
    
    
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
    
    func presentAlert(_ title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension AddNewContactViewController {
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
}
