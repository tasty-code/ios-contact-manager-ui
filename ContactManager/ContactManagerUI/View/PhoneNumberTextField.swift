//
//  PhoneNumberTextField.swift
//  ContactManagerUI
//
//  Created by Mason Kim on 2023/02/07.
//

import UIKit

final class PhoneNumberTextField: UITextField {
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    // MARK: - Helpers
    private func configure() {
        delegate = self
        addTarget(self, action: #selector(didPhoneNumberTextChange), for: .editingChanged)
    }


    // MARK: - Actions
    @objc func didPhoneNumberTextChange() {
        text = formattedPhoneNumber(with: text)
    }
}

// MARK: - UITextFieldDelegate
extension PhoneNumberTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string.isEmpty || Int(string) != nil else {
            return false
        }
        return true
    }
}

// MARK: - Number Format 관련
extension PhoneNumberTextField {
    func formattedPhoneNumber(with text: String?) -> String {
        let pureNumbers = text?.filter { $0.isNumber } ?? ""
        let pattern = createPhoneNumberPattern(with: pureNumbers)
            return applyPatternOn(pureNumbers: pureNumbers, pattern: pattern, replacementCharacter: "#")
    }
    
    private func createPhoneNumberPattern(with pureNumbers: String) -> String {
        if pureNumbers.starts(with: "0") && !pureNumbers.starts(with: "02")  {
            if pureNumbers.count <= 10 {
                return "###-###-####"
            }
            
            if pureNumbers.count == 11 {
                return "###-####-####"
            }
        }

        if pureNumbers.count <= 9 {
            return "##-###-####"
        }

        if pureNumbers.count == 10 {
            return "##-####-####"
        }
        
        return ""
    }

    private func applyPatternOn(pureNumbers: String,
                                pattern: String,
                                replacementCharacter: Character) -> String {
        var numbers = pureNumbers
        for index in 0 ..< pattern.count {
            guard index < numbers.count else { return numbers }
            let pattenIndex = pattern.index(pattern.startIndex, offsetBy: index)
            let patternCharacter = pattern[pattenIndex]

            guard patternCharacter != replacementCharacter else { continue }
            numbers.insert(patternCharacter, at: pattenIndex)
        }
        return numbers
    }
}
