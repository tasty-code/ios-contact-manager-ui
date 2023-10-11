//
//  AddNewContactViewController.swift
//  ContactManager
//
//  Created by 전성수 on 10/11/23.
//

import UIKit

class AddNewContactViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputAge: UITextField!
    @IBOutlet weak var inputDigits: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputDigits.delegate = self
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
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
}

extension AddNewContactViewController {
    private func setHyphenInDigits(range: NSRange, inputText: String, digitsLength: Int) {
        var inputText: String = inputText
        
        switch digitsLength {
        case 0...10 :
            if range.length == 0 && (range.location == 2 || range.location == 6) {
                inputDigits.text = "\(inputDigits.text!)-"
                print("함수타는중")
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
