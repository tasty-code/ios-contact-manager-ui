//
//  AddContactViewController.swift
//  ContactManagerUI
//
//  Created by sei_dev on 2/6/23.
//

import UIKit

final class AddContactViewController: UIViewController {

    @IBOutlet weak var contactTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        contactTextField.delegate = self
    }
}

extension AddContactViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let oldText = textField.text, let textRange = Range(range, in: oldText) {
            let newText = oldText.replacingCharacters(in: textRange, with: string)
            textField.text = parse(newText, using: range)
        }
        return false
    }

    private enum LocationsOfHyphen {
        static let forTwoFourFour = [2, 7]
        static let forTwoThreeFour = [2, 6]
        static let forThreeFourFour = [3, 8]
    }

    private func parse(_ newText: String, using range: NSRange) -> String {
        switch (range.location, range.length) {
        case (12, 1...), (11, 0):
            return relocateHyphen(of: newText, at: LocationsOfHyphen.forTwoFourFour)
        case (11, 1...):
            return relocateHyphen(of: newText, at: LocationsOfHyphen.forTwoThreeFour)
        case (12, 0):
            return relocateHyphen(of: newText, at: LocationsOfHyphen.forThreeFourFour)
        case (3, 1...), (7, 1...):
            return removeLastHyphen(from: newText)
        case (2, _), (6, _):
            return newText.inserting(Character.hyphen, at: range.location)
        default:
            return newText
        }
    }

    private func removeLastHyphen(from text: String) -> String {
        if text.last == Character.hyphen {
            return String(text.dropLast())
        }
        return text
    }

    private func relocateHyphen(of string: String, at indices: [Int]) -> String {
        var relocated = string.replacingOccurrences(of: String.hyphen, with: String.empty)
        for index in indices {
            relocated.insert(Character.hyphen, at: index)
        }
        return relocated
    }
}


extension String {
    static var hyphen: String { "-" }
    static var empty: String { "" }

    mutating func insert(_ newElement: Character, at i: Int) {
        self.insert(newElement, at: self.index(self.startIndex, offsetBy: i))
    }

    func inserting(_ newElement: Character, at i: Int) -> String {
        var newString = self
        newString.insert(newElement, at: self.index(self.startIndex, offsetBy: i))
        return newString
    }
}

extension Character {
    static var hyphen: Character { "-" }
}
