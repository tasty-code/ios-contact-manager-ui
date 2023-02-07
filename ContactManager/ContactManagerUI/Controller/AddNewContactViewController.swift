//
//  AddNewContactViewController.swift
//  ContactManagerUI
//
//  Created by Blu on 2023/02/07.
//

import UIKit

class AddNewContactViewController: UIViewController {

    @IBOutlet var userInputTextArray: [UITextField]!
    private let contactManager = ContactManager()
    private let checker = Checker()

    @IBAction func tappedCancelButton(_ sender: UIBarButtonItem) {
        failiureAlert()
    }

    @IBAction func tappedSaveButton(_ sender: UIBarButtonItem) {
        let errorSentence = decideErrorLocation()
        successAlert(message: errorSentence)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func decideErrorLocation() -> String {
        var returnSentence = ""
        let validName = checkUserName()
        var checkUserInput = checker.checkCorrect(targets: validName)
        
        for (index, boolean) in checkUserInput.enumerated() {
            if !boolean {
                returnSentence = InputErrorMessage.allCases[index].rawValue
            }
        }
        return returnSentence
    }
    
    private func checkUserName() -> [String] {
        var inputCollection = [String]()
        
        userInputTextArray.forEach { element in
            if let userInput = element.text {
                inputCollection.append(userInput)
            }
        }
        
        if let excludeFirstInput = inputCollection.first {
            let validName = contactManager.removeBlankInput(value: excludeFirstInput)
            inputCollection[inputCollection.startIndex] = validName
        }
        return inputCollection
    }
}

extension AddNewContactViewController {
    private func successAlert(message: String) {
        let success = UIAlertAction(title: "확인", style: .default, handler: nil)
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alert.addAction(success)
        present(alert, animated: true, completion: nil)
    }
    
    private func failiureAlert() {
        let alert = UIAlertController(title: nil, message: "정말로 취소하시겠습니까?", preferredStyle: .alert)
        let allowAction = UIAlertAction(title: "예", style: .destructive, handler: { action in
            self.dismiss(animated: true)
        })
        let cancleAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        
        alert.addAction(allowAction)
        alert.addAction(cancleAction)
        present(alert, animated: true, completion: nil)
    }
}
