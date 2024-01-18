//
//  NewContactManager.swift
//  ContactManager
//
//  Created by EUNJU on 2024/01/17.
//

import Foundation

final class NewContactManager {
    
    /// 핸드폰 번호 형식인지 검사하는 메서드
    private func validatePhoneNumberFormat(_ text: String) -> Bool {
        let regex = "^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$"
        return NSPredicate(format: "SELF MATCHES %@", regex)
            .evaluate(with: text)
    }
    
    /// 일반 전화 형식인지 검사하는 메서드
    private func validateContactNumberFormat(_ text: String) -> Bool {
        let regex = "^0(2|3[1-3]|4[1-4]|5[1-5]|6[1-4])-([0-9]{3,4})-([0-9]{4})$"
        return NSPredicate(format: "SELF MATCHES %@", regex)
            .evaluate(with: text)
    }
    
    /// 연락처 정보 유효성 검사 메서드
    func checkValidityOfContactData(nameInput: String?,
                                            ageInput: String?,
                                            contactNumberInput: String?) throws -> ContactInfoModel {
        guard let name = nameInput?.deleteWhiteSpace() else {
            throw ContactManagerError.invalidInput(input: .name)
        }
        guard let ageInput,
              let age = Int(ageInput.deleteWhiteSpace()), age > 0 && age < 1000 else {
            throw ContactManagerError.invalidInput(input: .age)
        }
        guard let contactNumber = contactNumberInput,
              validatePhoneNumberFormat(contactNumber)
                || validateContactNumberFormat(contactNumber) else {
            throw ContactManagerError.invalidInput(input: .contactNumber)
        }

        return ContactInfoModel(name: name, age: age, contactNumber: contactNumber)
    }
}
