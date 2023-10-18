enum CheckContactErrors: Error {
    case invalidName
    case invalidAge
    case invalidPhoneNumber
    case unknown

    var description: String {
        switch self {
        case .invalidName:
            return "입력된 이름 정보가 잘못되었습니다"
        case .invalidAge:
            return "입력된 나이 정보가 잘못되었습니다"
        case .invalidPhoneNumber:
            return "입력된 연락처 정보가 잘못되었습니다"
        case .unknown:
            return "알 수 없는 에러입니다"
        }
    }
}
