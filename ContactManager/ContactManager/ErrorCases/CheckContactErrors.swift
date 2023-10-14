enum CheckContactErrors: Error {
    case invalidName
    case invaildAge
    case invalidPhoneNumber
    case unknown
}

func catcher(of error: CheckContactErrors) -> String {
    switch error {
    case .invalidName:
        print("test")
        return "입력된 이름 정보가 잘못되었습니다"
    case .invaildAge:
        return "입력된 나이 정보가 잘못되었습니다"
    case .invalidPhoneNumber:
        return "입력된 연락처 정보가 잘못되었습니다"
    case .unknown:
        return "알 수 없는 에러입니다"
    }
}
