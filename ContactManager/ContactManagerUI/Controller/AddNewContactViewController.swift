//
//  AddNewContactViewController.swift
//  ContactManagerUI
//
//  Created by Blu on 2023/02/07.
//

import UIKit

class AddNewContactViewController: UIViewController {

    @IBOutlet var userInputTextArray: [UITextField]!
    private var newContactData = [String]()
    private let contactManager = ContactManager()
    private let checker = Checker()

    weak var delegate: SendContactDataDelegate?

    @IBAction func tappedCancelButton(_ sender: UIBarButtonItem) {
        cancelConfirmAlert()
    }

    @IBAction func tappedSaveButton(_ sender: UIBarButtonItem) {
        let errorSentence = decideErrorLocation()

        if errorSentence.isEmpty {
            let sendingContactData = ContactInformation(name: newContactData[0], age: newContactData[1], phoneNumber: newContactData[2])

            delegate?.sendData(newData: sendingContactData)
            
            dismiss(animated: true)
            return
        }

        successAlert(message: errorSentence)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func decideErrorLocation() -> String {
        var returnSentence = ""
        let convertedUserInputArray = convertToStringArray()
        newContactData = removeBlankInputName(inputArray: convertedUserInputArray)
        let checkUserInput = checker.checkCorrect(targets: newContactData)
        
        for (index, boolean) in checkUserInput.enumerated() {
            if !boolean {
                returnSentence = InputErrorMessage.allCases[index].rawValue
            }
        }
        return returnSentence
    }
    
    private func convertToStringArray() -> [String] {
        var inputCollection = [String]()
        
        userInputTextArray.forEach { element in
            if let userInput = element.text {
                inputCollection.append(userInput)
            }
        }
        return inputCollection
    }

    private func removeBlankInputName(inputArray: [String]) -> [String] {
        var resultArray = inputArray
        if let removedBlankInputName = resultArray.first {
            let joinedName = contactManager.removeBlankInput(value: removedBlankInputName)
            resultArray[resultArray.startIndex] = joinedName
        }
        return resultArray
    }
}

extension AddNewContactViewController {
    private func successAlert(message: String) {
        let success = UIAlertAction(title: "확인", style: .default, handler: nil)
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alert.addAction(success)

        present(alert, animated: true, completion: nil)
    }
    
    private func cancelConfirmAlert() {
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
