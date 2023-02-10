enum ErrorType{
    case name
    case age
    case phoneNumber
}

func errorTextOutput(with type: ErrorType){
    let errorText: String
    switch type {
    case .name: errorText = "이름"
    case .age: errorText = "나이"
    case .phoneNumber: errorText = "연락처"
    }
    print("입력한 \(errorText)정보가 잘못되었습니다. 입력 형식을 확인해주세요.")
}

func hasNoNameError(name: String) -> Bool{
    guard name.range(of: nameRegex, options: .regularExpression) != nil else {
        return false
    }
    return true
}

func hasNoAgeError(age: String) -> Bool{
    guard age.allSatisfy({ $0.isNumber }) else {
        return false
    }
    
    guard let changeToInt = Int(age), changeToInt < 1000 else {
        return false
    }
    return true
}

func hasNoPhoneNumberError(number: String) -> Bool {
    guard number.range(of: phoneNumberRegex, options: .regularExpression) != nil else {
        return false
    }
    
    guard Validation.validateInputByHyphenNum(input: number) else {
        return false
    }
    
    guard number.components(separatedBy: ["-"]).joined().count >= 9 else {
        return false
    }
    return true
}


func errorCheck(trimName: String, trimAge: String, trimNum: String) -> Bool {
    guard hasNoNameError(name: trimName), hasNoAgeError(age: trimAge), hasNoPhoneNumberError(number: trimNum) else {
        return false
    }
    return true
}
