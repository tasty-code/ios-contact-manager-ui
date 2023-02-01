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

func checkNameError(name: String) -> Bool{
    guard name.range(of: regex, options: .regularExpression) != nil else {
        errorTextOutput(with: .name)
        return false
    }
    return true
}

func checkAgeError(age: String) -> Bool{
    guard age.allSatisfy({ $0.isNumber}) else {
        errorTextOutput(with: .age)
        return false
    }
    guard let changeToInt = Int(age), changeToInt <= 1000 else {
        errorTextOutput(with: .age)
        return false
    }
    return true
}

func checkPhoneNumError(num: String) -> Bool {
    guard Validation.validateInputByHyphenNum(input: num), num.components(separatedBy: ["-"]).joined().count >= 9 else {
        errorTextOutput(with: .phoneNumber)
        return false
    }
        return true
}


func errorCheck(trimName: String, trimAge: String, trimNum: String) -> Bool {
    guard checkNameError(name: trimName), checkAgeError(age: trimAge), checkPhoneNumError(num: trimNum) else {
        return false
    }
    return true
}
