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
            // newText == 현재 text field에 있는 텍스트. 아직 textField에는 업데이트 되지 않은 상태
            let newText = oldText.replacingCharacters(in: textRange, with: string)

            // range 정보를 갖고 parse한 결과를 textField의 text에 할당
            textField.text = parse(newText, using: range)
        }
        return false
    }

    private func parse(_ newText: String, using range: NSRange) -> String {
        /*
         range.location == newText.count
         range.length == 삭제된 character 수
         */
        switch (range.location, range.length) {
        case (12, 1...), (11, 0): // 2-4-4로 바뀌어야 하는 경우
            return relocateHyphen(of: newText, locationsOfHyphen: [2, 7])
        case (11, 1...): // 2-3-4로 바뀌어야 하는 경우
            return relocateHyphen(of: newText, locationsOfHyphen: [2, 6])
        case (12, 0): // 3-4-4로 바뀌어야 하는 경우
            return relocateHyphen(of: newText, locationsOfHyphen: [3, 8])
        case (3, 1...), (7, 1...): // 맨 뒤 -를 없애는 경우
            return removeLastHyphen(from: newText)
        case (2, _), (6, _): // -를 추가해야 하는 경우
            return newText.inserting(Character.hyphen, at: range.location)
        default: // 그 외의 경우
            return newText
        }
    }

    private func removeLastHyphen(from text: String) -> String {
        if text.last == Character.hyphen {
            return String(text.dropLast())
        }
        return text
    }

    private func relocateHyphen(of string: String, locationsOfHyphen indices: [Int]) -> String {
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
