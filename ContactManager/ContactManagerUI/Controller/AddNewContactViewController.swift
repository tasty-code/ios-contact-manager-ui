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
        excludePhoneNumberTextField()
    }
    
    private func excludePhoneNumberTextField() {
        guard let phoneNumberTextField = userInputTextArray.last else {
            return
        }
        phoneNumberTextField.delegate = self
    }
    
    private func decideErrorLocation() -> String {
        var returnSentence = ""
        let convertedUserInputArray = convertToStringArray()
        newContactData = removeBlankInputName(inputArray: convertedUserInputArray)
        let checkUserInput = checker.checkCorrect(targets: newContactData)
        
        for (index, boolean) in checkUserInput.enumerated() {
            if !boolean {
                returnSentence = InputErrorMessage.allCases[index].rawValue
                break
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

extension AddNewContactViewController: UITextFieldDelegate {
    
}
