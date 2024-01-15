//
//  ContactValidateCheck.swift
//  contact-management
//
//  Created by Roh on 1/15/24.
//

enum ContactValidateCheck {
    case name(_ name: String)
    case age(_ age: Int)
    case phone(_ phoneNumber: String)
    
    var check: Bool {
        get throws {
            switch self {
            case .name(let name):
                print(name)
                if name.isEmpty { throw ContactListError.ContactNameIsValid }
                else { return true }
                
            case .age(let age):
                guard age > 0 && age <= 200 else {
                    throw ContactListError.ContactAgeIsValid
                }
                return true
                
            case .phone(let phoneNumber):
                let components = phoneNumber.components(separatedBy: "-").joined()
                print(components.count, components.count >= 9)
                print(components.allSatisfy({ $0.isNumber }))
                if components.count >= 9,
                   components.allSatisfy({ $0.isNumber })
                {
                    return true
                }
                else { throw ContactListError.ContactPhoneIsValid }
            }
        }
    }
}
