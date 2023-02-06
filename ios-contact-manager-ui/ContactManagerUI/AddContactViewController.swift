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
        if let oldText = textField.text {
            let formattedString = parse(target: oldText, range: range)
            textField.text = formattedString
        }
        return true
    }

    private func parse(target: String, range: NSRange) -> String {
        let suffix: String

        switch (range.location, range.length) {
        case (12, 1...):
            return addHyphen(to: slicingFromStart(target: target, offset: range.location), at: (2, 7))
        case (11, 1...):
            return addHyphen(to: slicingFromStart(target: target, offset: range.location), at: (2, 6))
        case (11, 0):
            return addHyphen(to: target, at: (2, 7))
        case (12, 0):
            return addHyphen(to: target, at: (3, 8))
        case (3, 1...), (7, 1...):
            return removeHyphen(target: target, length: range.location)
        case (2, _), (6, _):
            suffix = "-"
        default:
            suffix = ""
        }
        return target + suffix
    }

    private func slicingFromStart(target:String, offset length: Int) -> String {
        return String(target[...target.index(target.startIndex, offsetBy: length)])
    }

    private func removeHyphen(target: String, length: Int) -> String {
        return slicingFromStart(target: target, offset: length-1)
    }

    private func addHyphen(to string: String, at index: (first: Int, second: Int)) -> String {
        var hyphenRemoved = string.replacingOccurrences(of: "-", with: "")
        hyphenRemoved.insert("-", at: hyphenRemoved.index(hyphenRemoved.startIndex, offsetBy: index.first))
        hyphenRemoved.insert("-", at: hyphenRemoved.index(hyphenRemoved.startIndex, offsetBy: index.second))
        return hyphenRemoved
    }
}
