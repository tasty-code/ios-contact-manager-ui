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
        text = text?.formattedPhoneNumber
    }
}

extension PhoneNumberTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string.isEmpty || Int(string) != nil else {
            return false
        }
        return true
    }
}
