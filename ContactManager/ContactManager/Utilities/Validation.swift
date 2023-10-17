import Foundation

@available(iOS 16.0, *)
struct Validation {
    func check(name: String?) throws -> String {
        let regex = /^\S+(\s+\S+)*$/
        if let name = name,
           let _ = name.wholeMatch(of: regex) {
            return name
        } else {
            throw CheckContactErrors.invalidName
        }
    }
    
    func check(age: String?) throws -> String {
        let regex = /^\d{1}+(\s\d{1})?+(\s\d{1})?$/
        if let age = age,
           let _ = age.wholeMatch(of: regex) {
            return age
        } else {
            throw CheckContactErrors.invaildAge
        }
    }
    
    func check(phoneNumber: String?) throws -> String {
        let regex = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/
        if let phoneNumber = phoneNumber,
           let _ = phoneNumber.wholeMatch(of: regex) {
            return phoneNumber
        } else {
            throw CheckContactErrors.invalidPhoneNumber
        }
    }
}
