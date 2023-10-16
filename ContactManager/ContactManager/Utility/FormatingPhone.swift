//
//  FormatingPhone.swift
//  ContactManager
//
//  Created by Rarla on 2023/10/16.
//

import Foundation

extension String {
  func formatingPhone() -> String {
    let phoneNumber = self.replacingOccurrences(of: "-", with: "")
    if(self.count > 12) { return self }
    
    var regexPattern: String
    if phoneNumber.count == 9 {
      regexPattern = "([0-9]{0,2})([0-9]{0,3})([0-9]{0,4})"
    } else {
      regexPattern = "([0-9]{0,3})([0-9]{0,4})([0-9]{0,4})"
    }
    
    if let regex = try? NSRegularExpression(pattern: regexPattern, options: .caseInsensitive) {
      let modString = regex.stringByReplacingMatches(in: phoneNumber,
                                                     options: [],
                                                     range: NSRange(phoneNumber.startIndex..., in: phoneNumber),
                                                     withTemplate: "$1-$2-$3")
      return modString.trimmingCharacters(in: ["-"])
    }
    
    return phoneNumber
  }
}
